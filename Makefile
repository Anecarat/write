.PHONY: help all pdfs demo
.SECONDARY:



# Intro to write!

help:
	@echo 'write! 0.1'
	@echo 'Run `make all` to automatically (re-)build all documents.'
	@echo 'Run `make <Project name>/<Document name>.article` to create a new article-type document.'



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
# markdown > AsciiDoc > DocBook > FO > PDF

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

Output/%.md: Content/%.md Core/rework_markdown.sed
	cp $< $@
	sed -i -f $(word 2,$^) $@

Output/%.adoc: Output/%.md Core/rework_asciidoc.sed References/*.bib
	$(PANDOC) -t asciidoc
	sed -i -f $(word 2,$^) $@

Output/%.xml: Output/%.adoc Core/rework_docbook.sed
	asciidoctor --backend docbook --out-file $@ $<
	sed -i -f $(word 2,$^) $@

Output/%.fo: Output/%.xml Core/rework_fo.sed Stylesheets/%.docbook_to_fo.xsl Core/docbook_to_fo.xsl Core/docbook_common.xsl
	xsltproc --output $@ $(word 3,$^) $<
	sed -i -f $(word 2,$^) $@

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@



# Create new document

%.article:
	mkdir -p Content/$(dir $@) Stylesheets/$(dir $@) Output/$(dir $@)
	touch Content/$(basename $@).md Stylesheets/$(basename $@).docbook_to_fo.xsl
