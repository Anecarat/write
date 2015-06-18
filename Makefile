.PHONY: all

PANDOC = pandoc $< -o $@ --filter pandoc-citeproc --no-wrap

all: \
	Output/Article_demo.xml

Output/%.xml: Content/%.md
	$(PANDOC) -t docbook --standalone
