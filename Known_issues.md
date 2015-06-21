If you know a good solution to any of the following issues, feel free to [submit them](https://github.com/and3k/write/issues). Thank you!

# Makefile

Some unnecessary rebuilds are performed:

* `Output/%.md` depends on **all** `Content/<Project name>/rework.sed` files, not the just correct one. This is hard to fix because of the pattern rule. The same goes for `Output/%.fo` and `Stylesheets/*/docbook_common.xsl`.
* `Output/%.adoc` depends on all BibTeX files in `References/`, because the Makefile doesn’t know the correct one (which is defined in den YAML header of the markdown file). On the other hand it does not depend on any BibTex files outside of `References/` which may also wrong if a user decides to put them somewhere else.
