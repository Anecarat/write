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

You’ll need to install [Make](https://www.gnu.org/software/make/), [Git](https://git-scm.com/), [Pandoc](http://pandoc.org/), [pandoc-citeproc](http://pandoc.org/), [Asciidoctor](http://asciidoctor.org/), [xsltproc](http://xmlsoft.org/), [DocBook XSL stylesheets](http://docbook.sourceforge.net/), [FOP](https://xmlgraphics.apache.org/fop/), and [unoconv](http://dag.wiee.rs/home-made/unoconv/):

```sh
sudo apt-get install make git pandoc pandoc-citeproc asciidoctor xsltproc docbook-xsl fop unoconv
```

Ubuntu is pretty up-to-date on most of the required software. However you can **optionally** update [Pandoc](https://github.com/jgm/pandoc/wiki/Installing-the-development-version-of-pandoc) and/or [Asciidoctor](https://github.com/asciidoctor/asciidoctor#installation) to their respective development versions to get the most out of you document.


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
[warning] /usr/bin/fop: No java runtime was found
Picked up JAVA_TOOL_OPTIONS: -javaagent:/usr/share/java/jayatanaag.jar 
Font "Symbol,normal,700" not found. Substituting with "Symbol,normal,400".
Font "ZapfDingbats,normal,700" not found. Substituting with "ZapfDingbats,normal,400".
Rendered page #1.
Rendered page #2.
Rendered page #3.
asciidoctor --out-file Output/Demo/Article_demo.fancy.html Output/Demo/Article_demo.adoc
xsltproc --output Output/Demo/Article_demo.html Stylesheets/Demo/Article_demo.docbook_to_html.xsl Output/Demo/Article_demo.xml
sed -i -f Core/rework_html.sed Output/Demo/Article_demo.html
unoconv -d document --f doc Output/Demo/Article_demo.html
Done: Output/Demo/Article_demo.pdf Output/Demo/Article_demo.fancy.html Output/Demo/Article_demo.doc
```

## Update write*!*

If you want to update write*!* to its newest version run:

```sh
cd write
git pull
make upgrade
make -B all
```



# Usage

**This is still a work in progress and not yet usable!**


## For the impatient

```sh
cd write
make <Project name>/<Document name>.article
```

This creates a new document named `<Document name>.md` in the folder `Content/<Project name>/`. Add some text (in markdown), and run `make all` to convert it to a PDF, HTML, and Microsoft Word file. All export files can be found in the folder `Output/<Project name>/`

Voilà!

### A simple example

```sh
cd write
make My_first_paper/Main_text.article
make My_first_paper/SI.article
make all
```


## References/Bibliography/Citations

In the YAML header of your document, you can set the following:

* `bibliography`: this should point to your [BibTeX](https://en.wikipedia.org/wiki/BibTeX) file, which you can put in the folder `References/`. Any other Pandoc-supported bibliography file and its location will work, but then documents will not be automatically updated if the bibliography file changes (see [Known_issues.md](https://github.com/and3k/write/blob/master/Known_issues.md)).
  * Example: `bibliography: References/Demo.bib`.
* `csl`: this should point to any of the [citation styles](http://citationstyles.org/) located in the folder `Citation_styles/` or be left empty. [All publicly available CSL files](https://github.com/citation-style-language/styles) are included for your convenience.
  * Example: `csl: Citation_styles/science.csl`.

See also http://pandoc.org/README.html#citations.




# Under the hood

[Pandoc](https://en.wikipedia.org/wiki/Pandoc) is used to convert your markdown documents to [AsciiDoc](https://en.wikipedia.org/wiki/AsciiDoc). Asciidoctor is used to further convert it to [DocBook](https://en.wikipedia.org/wiki/DocBook), which is then converted to [FO](https://en.wikipedia.org/wiki/XSL_Formatting_Objects) which can be used to generate PDFs.


## Futher reading

* [What is AsciiDoc? Why do we need it?](http://asciidoctor.org/docs/what-is-asciidoc/)
* [Official Ubuntu DocBook guide](https://help.ubuntu.com/community/DocBook)


# Credits

The demo articles consist of nonsense text generated by [Lorem Markdownum](http://jaspervdj.be/lorem-markdownum/) and examples copied from the [Pandoc User’s Guide](http://pandoc.org/README.html).


# Help and Feedback

Feel free to ask for help or submit feedback and issues at https://github.com/and3k/write/issues. For issues please also add the output of `make debug`.

There are some known issues listed in [Known_issues.md](https://github.com/and3k/write/blob/master/Known_issues.md).

Example output of `make debug`:

```
write! 0.1
Run `make all` to automatically (re-)build all documents.
Run `make <Project name>/<Document name>.article` to create a new article-type document.

pandoc --version
pandoc 1.14
Compiled with texmath 0.8.2, highlighting-kate 0.5.15.
Syntax highlighting is supported for the following languages:
    abc, actionscript, ada, agda, apache, asn1, asp, awk, bash, bibtex, boo, c,
    changelog, clojure, cmake, coffee, coldfusion, commonlisp, cpp, cs, css,
    curry, d, diff, djangotemplate, dockerfile, dot, doxygen, doxygenlua, dtd,
    eiffel, email, erlang, fasm, fortran, fsharp, gcc, glsl, gnuassembler, go,
    haskell, haxe, html, idris, ini, isocpp, java, javadoc, javascript, json,
    jsp, julia, latex, lex, lilypond, literatecurry, literatehaskell, lua, m4,
    makefile, mandoc, markdown, mathematica, matlab, maxima, mediawiki,
    metafont, mips, modelines, modula2, modula3, monobasic, nasm, noweb,
    objectivec, objectivecpp, ocaml, octave, opencl, pascal, perl, php, pike,
    postscript, prolog, pure, python, r, relaxng, relaxngcompact, rest, rhtml,
    roff, ruby, rust, scala, scheme, sci, sed, sgml, sql, sqlmysql,
    sqlpostgresql, tcl, tcsh, texinfo, verilog, vhdl, xml, xorg, xslt, xul,
    yacc, yaml, zsh
Default user data directory: /home/bela/.pandoc
Copyright (C) 2006-2015 John MacFarlane
Web:  http://johnmacfarlane.net/pandoc
This is free software; see the source for copying conditions.
There is no warranty, not even for merchantability or fitness
for a particular purpose.

pandoc-citeproc --version
pandoc-citeproc 0.7.1

asciidoctor --version
Asciidoctor 1.5.3.dev [http://asciidoctor.org]
Runtime Environment (ruby 2.1.2p95 (2014-05-08) [x86_64-linux-gnu]) (lc:UTF-8 fs:UTF-8 in:- ex:UTF-8)

xsltproc --version
Using libxml 20902, libxslt 10128 and libexslt 817
xsltproc was compiled against libxml 20902, libxslt 10128 and libexslt 817
libxslt 10128 was compiled against libxml 20902
libexslt 817 was compiled against libxml 20902

fop -version
[warning] /usr/bin/fop: No java runtime was found
Picked up JAVA_TOOL_OPTIONS: -javaagent:/usr/share/java/jayatanaag.jar 
FOP Version 1.1
```
