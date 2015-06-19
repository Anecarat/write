.PHONY: all

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: \
	Output/Article_demo.fo \
	Output/Article_demo.adoc

Output/%.adoc: Content/%.md References/*.bib
	$(PANDOC) -t asciidoc

Output/%.xml: Content/%.md References/*.bib
	$(PANDOC) -t docbook --standalone

Output/%.fo: Output/%.xml Core/docbook_to_fo.xsl
	xsltproc --output $@ $(word 2,$^) $<
