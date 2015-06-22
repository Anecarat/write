# write*!*

A ready-to-use framework to generate beautiful scientific documents, like journal articles, directly from markdown text.

**This is still a work in progress and not yet usable!**


## Is this for you?

If you

1. (want to) write your documents in markdown (or AsciiDoc),
2. and need a beautiful PDF or HTML version of your document,
3. but also a Microsoft Word export,

then this is perfect for you!



# Installation

This installation guide is written for [Ubuntu](http://www.ubuntu.com/), please adapt the commands to your operation system where needed. write*!* should work on all GNU/Linux distributions, as well as OS X and Windows.

Open up your favourite terminal and let’s go!


## Prerequisites

You’ll need to install [Make](https://www.gnu.org/software/make/), [Git](https://git-scm.com/), [pandoc](http://pandoc.org/), [pandoc-citeproc](http://pandoc.org/), [Asciidoctor](http://asciidoctor.org/), [xsltproc](http://xmlsoft.org/), [DocBook XSL stylesheets](http://docbook.sourceforge.net/), [FOP](https://xmlgraphics.apache.org/fop/), and [unoconv](http://dag.wiee.rs/home-made/unoconv/):

```sh
sudo apt-get install make git pandoc pandoc-citeproc asciidoctor xsltproc docbook-xsl fop unoconv
```


## Get write*!*

Get a copy of this repository.

```sh
git clone git@github.com:and3k/write.git
cd write
git submodule update --init
```


## Test your setup

Test if all the tools work.

```sh
make -B demo
```

The output of `make` should look something like this and display no errors:

```
cp Content/Demo/Article_demo.md Output/Demo/Article_demo.md
sed -i -f Content/Demo/rework.sed Output/Demo/Article_demo.md
sed -i -f Core/rework_markdown.sed Output/Demo/Article_demo.md
pandoc Output/Demo/Article_demo.md -o Output/Demo/Article_demo.adoc --filter pandoc-citeproc --no-wrap -t asciidoc
sed -i -f Core/rework_asciidoc.sed Output/Demo/Article_demo.adoc
asciidoctor --backend docbook --out-file Output/Demo/Article_demo.xml Output/Demo/Article_demo.adoc
sed -i -f Core/rework_docbook.sed Output/Demo/Article_demo.xml
xsltproc --output Output/Demo/Article_demo.fo Stylesheets/Demo/Article_demo.docbook_to_fo.xsl Output/Demo/Article_demo.xml
Making portrait pages on A4 paper (210mmx297mm)
sed -i -f Core/rework_fo.sed Output/Demo/Article_demo.fo
fop -c Core/fop_config.xml -fo Output/Demo/Article_demo.fo -pdf Output/Demo/Article_demo.pdf
INFO: Rendered page #1.
INFO: Rendered page #2.
INFO: Rendered page #3.
asciidoctor --out-file Output/Demo/Article_demo.fancy.html Output/Demo/Article_demo.adoc
xsltproc --output Output/Demo/Article_demo.html Stylesheets/Demo/Article_demo.docbook_to_html.xsl Output/Demo/Article_demo.xml
sed -i -f Core/rework_html.sed Output/Demo/Article_demo.html
unoconv -d document --f doc Output/Demo/Article_demo.html
Done: Output/Demo/Article_demo.pdf Output/Demo/Article_demo.fancy.html Output/Demo/Article_demo.doc
```

## Update write*!*

```sh
cd write
git pull
make -B all
```



# Usage

**This is still a work in progress and not yet usable!**


## For the impatient

```sh
cd write
make <Project name>/<Document name>.article
```

This creates a new document in the folder `Content/<Project name>/` with the extension `.md`. Add some text (in markdown), and run `make all` to convert it to a PDF, HTML, and Microsoft Word file. All export files can be found in the folder `Output/<Project name>/`

Voila!

### A simple example

```sh
cd write
make My_frist_paper/Main_text.article
make My_frist_paper/SI.article
make all
```


## References/Bibliography/Citations

In the YAML header of your document, you can set the following:

* `bibliography`: this should point to your [BibTeX](https://en.wikipedia.org/wiki/BibTeX) file, which you can put in the folder `References/`. Any other pandoc-supported bibliography file and its location will work, but then documents will not be automatically updated if the bibliography file changes (see [Known_issues.md](https://github.com/and3k/write/blob/master/Known_issues.md)).
  * Example: `bibliography: References/Demo.bib`.
* `csl`: this should point to any of the [citation styles](http://citationstyles.org/) located in the folder `Citation_styles/` or be left empty. [All publicly available CSL files](https://github.com/citation-style-language/styles) are included for your convenience.
  * Example: `csl: Citation_styles/science.csl`.

See also http://pandoc.org/README.html#citations.




# Under the hood

[pandoc](https://en.wikipedia.org/wiki/Pandoc) is used to convert your markdown documents to [AsciiDoc](https://en.wikipedia.org/wiki/AsciiDoc). Asciidoctor is used to further convert it to [DocBook](https://en.wikipedia.org/wiki/DocBook), which is then converted to [FO](https://en.wikipedia.org/wiki/XSL_Formatting_Objects) which can be used to generate PDFs.


## Futher reading

* [What is AsciiDoc? Why do we need it?](http://asciidoctor.org/docs/what-is-asciidoc/)
* [Official Ubuntu DocBook guide](https://help.ubuntu.com/community/DocBook)


# Help and Feedback

Feel free to ask for help or submit feedback and issues at https://github.com/and3k/write/issues. For issues please also add the output of `make debug`.

There are some known issues listed in [Known_issues.md](https://github.com/and3k/write/blob/master/Known_issues.md).
