# write!

A ready-to-use framework to generate beautiful scientific documents, like journal articles, directly from markdown text.

**This is still a work in progress and not yet usable!**


## Is this for you?

If you

1. (want to) write your documents in markdown, and
2. need a Word export of you document, and/or
3. need a beautiful PDF export of you document,

then this is perfect for you!



# Installation

This installation guide is written for Ubuntu, please adapt the commands to your operation system where needed. write! should work on all GNU/Linux distributions, as well as OS X and Windows.

Open up your favourite terminal an let’s go!


## Prerequisites

You’ll need to install make, git, pandoc, pandoc-citeproc, xsltproc, DocBook stylesheets, and fop.

```sh
sudo apt-get install build-essential git-core pandoc pandoc-citeproc xsltproc docbook-xsl fop
```


## Get write!

Get a copy of this repository.

```sh
git clone git@github.com:and3k/write.git
```


## Test your setup

Test if all the tools work.

```sh
cd write
make -B demo
```

The output of `make` should look something like this and display no errors:

```
pandoc Content/Article_demo.md -o Output/Article_demo.xml --filter pandoc-citeproc --no-wrap -t docbook --standalone
xsltproc --output Output/Article_demo.fo Core/docbook_to_fo.xsl Output/Article_demo.xml
Making portrait pages on A4 paper (210mmx297mm)
fop -c Core/fop_config.xml -fo Output/Article_demo.fo -pdf Output/Article_demo.pdf
INFO: Rendered page #1.
INFO: Rendered page #2.
INFO: Rendered page #3.
pandoc Content/Article_demo.md -o Output/Article_demo.adoc --filter pandoc-citeproc --no-wrap -t asciidoc
```

## Update write!

```sh
cd write
git pull
make -B
```



# Usage

**This is still a work in progress and not yet usable!**


## For the impatient

Create a new document in the folder `Content/` with the extension `.md`, start writing (in markdown), and run `make` to convert it to a PDF. The export files can be found in the folder `Output/`

Voila!



# Under the hood

pandoc is used to convert your markdown documents to DocBook, which is then further converted to FO which can be used to generate PDFs.

Futher reading:

* [Official Ubuntu DocBook guide](https://help.ubuntu.com/community/DocBook)


# Help and Feedback

Please use https://github.com/and3k/write/issues
