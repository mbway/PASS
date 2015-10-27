.PHONY: all

all: currying.pdf

currying.pdf: currying.md
	pandoc -V geometry:margin=2cm --from=markdown_github+tex_math_dollars+inline_code_attributes $^ -o $@

