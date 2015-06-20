.PHONY: all demo

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: demo

demo: Output/Demo/Article_demo.pdf

# The basic write! pipeline:
# markdown > AsciiDoc > DocBook > FO > PDF

Output/%.md: Content/%.md
	cp $< $@

Output/%.adoc: Output/%.md References/*.bib
	$(PANDOC) -t asciidoc

Output/%.xml: Output/%.adoc
	asciidoctor --backend docbook --out-file $@ $<

Output/%.fo: Output/%.xml Core/docbook_to_fo.xsl Core/docbook_common.xsl
	xsltproc --output $@ $(word 2,$^) $<

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@
