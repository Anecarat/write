.PHONY: all

all: \
	Output/Article_demo.xml

Output/%.xml: Content/%.md
	pandoc $< -o $@ -t docbook --standalone --no-wrap
