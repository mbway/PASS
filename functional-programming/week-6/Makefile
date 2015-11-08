.PHONY: all

all: wk6ex2-explanation.pdf

wk6ex2-explanation.pdf: wk6ex2-explanation.md
	pandoc -V geometry:margin=2cm --from=markdown_github+tex_math_dollars+inline_code_attributes $^ -o $@

