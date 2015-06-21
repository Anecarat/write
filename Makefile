.PHONY: help debug all pdfs demo
.SECONDARY:



# Help

help:
	@echo 'write! 0.1'
	@echo 'Run `make all` to automatically (re-)build all documents.'
	@echo 'Run `make <Project name>/<Document name>.article` to create a new article-type document.'

debug: help
	@echo
	pandoc --version
	@echo
	pandoc-citeproc --version
	@echo
	asciidoctor --version
	@echo
	xsltproc --version
	@echo
	fop -version



# Build documents

all_outputs = $(addprefix Output/,$(basename $(shell cd Content && ls */*.md)))
all_pdfs = $(addsuffix .pdf,$(all_outputs))

all: pdfs

pdfs: $(all_pdfs)
	@echo Done: $^

demo: \
		Output/Demo/Article_demo.pdf
	@echo Done: $^



# The basic write! pipeline:
#   markdown > AsciiDoc > DocBook > FO > PDF

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

Output/%.md: Content/%.md Core/rework_markdown.sed Content/*/rework.sed
	cp $< $@
	sed -i -f $(<D)/rework.sed $@
	sed -i -f $(word 2,$^) $@

Output/%.adoc: Output/%.md Core/rework_asciidoc.sed References/*.bib
	$(PANDOC) -t asciidoc
	sed -i -f $(word 2,$^) $@

Output/%.xml: Output/%.adoc Core/rework_docbook.sed
	asciidoctor --backend docbook --out-file $@ $<
	sed -i -f $(word 2,$^) $@

Output/%.fo: Output/%.xml Core/rework_fo.sed Stylesheets/%.docbook_to_fo.xsl Stylesheets/docbook_to_fo.xsl Stylesheets/docbook_common.xsl Stylesheets/*/docbook_common.xsl
	xsltproc --output $@ $(word 3,$^) $<
	sed -i -f $(word 2,$^) $@

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@



# Create new document
#   e.g.:
#     make Demo/Article_demo.article
#     make Templates/Article_template.article

%.article:
	mkdir -p Content/$(@D) Stylesheets/$(@D) Output/$(@D)
	test -f Content/$(@D)/rework.sed || cp -v Content/Templates/rework.sed Content/$(@D)/rework.sed
	test -f Content/$(basename $@).md || cp -v Content/Templates/Article_template.md Content/$(basename $@).md
	test -f Stylesheets/$(basename $@).docbook_to_fo.xsl || cp -v Stylesheets/Templates/Article_template.docbook_to_fo.xsl Stylesheets/$(basename $@).docbook_to_fo.xsl
