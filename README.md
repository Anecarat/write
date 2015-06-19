# write!

A ready-to-use framework to generate beautiful scientific documents written in markdown.

**This is still a work in progress and not yet usable!**

## Is this for you?

If you

1. (want to) write you documents in markdown, and
2. need a Word export of you document, and/or
3. need a beautiful PDF export of you document,

then this is perfect for you!

# Installation

## Prerequisites

You’ll need to install git, pandoc and pandoc-citeproc.

Ubuntu:

```sh
sudo apt-get install git pandoc pandoc-citeproc.
```

## Get write!

Get a copy of this repository.

```sh
git clone git@github.com:and3k/write.git
cd write
```

## Test your setup

Test if all the tools work.

```sh
make -B
```

The output of `make` should look something like this and display not errors:

```
pandoc Content/Article_demo.md -o Output/Article_demo.xml --filter pandoc-citeproc --no-wrap -t docbook --standalone
pandoc Content/Article_demo.md -o Output/Article_demo.adoc --filter pandoc-citeproc --no-wrap -t asciidoc

```


# Usage

Create a new document in the folder `Content/` with the extension `.md` and run `make`.

The export files can be found in the folder `Output/`

Voila!

**This is still a work in progress and not yet usable!**
