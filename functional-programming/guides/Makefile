.PHONY: all

PANDOC_CMD=pandoc -V geometry:margin=2cm --from=markdown_github+tex_math_dollars+inline_code_attributes

all: currying.pdf \
     isomorphism.pdf ../week-4/isomorphism.pdf

currying.pdf: currying.md
	$(PANDOC_CMD) $^ -o $@

isomorphism.pdf: isomorphism.md
	$(PANDOC_CMD) $^ -o $@

# I made a mistake putting this here in the first place. But now there are
# links to this location it should be maintained if the content ever changes.
../week-4/isomorphism.pdf: isomorphism.md
	$(PANDOC_CMD) $^ -o $@



