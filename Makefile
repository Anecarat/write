.PHONY: all

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: demo

demo: \
	Output/Article_demo.pdf \
	Output/Article_demo.adoc

Output/%.adoc: Content/%.md References/*.bib
	$(PANDOC) -t asciidoc

Output/%.xml: Content/%.md References/*.bib
	$(PANDOC) -t docbook --standalone

Output/%.fo: Output/%.xml Core/docbook_to_fo.xsl
	xsltproc --output $@ $(word 2,$^) $<

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@
