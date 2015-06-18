.PHONY: all

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: \
	Output/Article_demo.xml \
	Output/Article_demo.adoc

Output/%.adoc: Content/%.md
	$(PANDOC) -t asciidoc

Output/%.xml: Content/%.md
	$(PANDOC) -t docbook --standalone
