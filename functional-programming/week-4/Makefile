.PHONY: all

all: isomorphism.pdf q4.pdf

isomorphism.pdf: isomorphism.md
	pandoc -V geometry:margin=2cm --from=markdown_github+tex_math_dollars+inline_code_attributes $^ -o $@

q4.pdf: q4.md
	pandoc -V geometry:margin=2cm --from=markdown_github+tex_math_dollars+inline_code_attributes $^ -o $@

