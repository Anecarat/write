.PHONY: all demo
.SECONDARY:

help:
	echo 'write! version 0.pre-alpha'
	echo 'Please run `make all` to automatically build all documents.'

all:
	make $(addprefix Output/,$(addsuffix .pdf,$(basename $(shell cd Content && find . -name '*.md'))))

demo: Output/Demo/Article_demo.pdf



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

Output/%.fo: Output/%.xml Core/rework_fo.sed Core/docbook_to_fo.xsl Core/docbook_common.xsl
	xsltproc --output $@ $(word 3,$^) $<
	sed -i -f $(word 2,$^) $@

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@



# Create new document

%.article:
	mkdir -p Content/$(dir $@) Output/$(dir $@)
	make Content/$(basename $@).md

Content/%.md:
	touch $@
