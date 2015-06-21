# Makefile

Some unnecessary rebuilds are performed:

* `Output/%.md` depends on **all** `Content/<Project name>/rework.sed` files, not the just correct one. This is hard to fix because of the pattern rule.
* `Output/%.adoc` depends on all BibTeX files in `References/`, because the Makefile doesn’t know the correct one (which is defined in den YAML header of the markdown file)
