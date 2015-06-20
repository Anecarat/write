.PHONY: all demo

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: demo

demo: Output/Article_demo.pdf

Output/%.adoc: Content/%.md References/*.bib
	$(PANDOC) -t asciidoc

#Output/%.xml: Content/%.md References/*.bib
#	$(PANDOC) -t docbook --standalone

Output/%.xml: Output/%.adoc
	asciidoctor --backend docbook --out-file $@ $<

Output/%.fo: Output/%.xml Core/docbook_to_fo.xsl Core/common.xsl
	xsltproc --output $@ $(word 2,$^) $<

Output/%.pdf: Output/%.fo Core/fop_config.xml
	fop -c $(word 2,$^) -fo $< -pdf $@
