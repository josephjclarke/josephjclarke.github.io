PUBLICATION_LIST_MD := content/publications/header/index.md
PUBLICATION_LIST_BIB := cv/cvpub.bib 

.PHONY: all build serve clean

all: build

build: $(PUBLICATION_LIST_MD) static/cv.pdf
	hugo

serve: $(PUBLICATION_LIST_MD) static/cv.pdf
	hugo server

clean:
	rm -rf public $(PUBLICATION_LIST_MD) static/cv.pdf cv/build

$(PUBLICATION_LIST_MD): $(PUBLICATION_LIST_BIB) scripts/generate_publications.py
	uv run --project scripts scripts/generate_publications.py $(PUBLICATION_LIST_BIB) $(PUBLICATION_LIST_MD)

static/cv.pdf: cv/cv.tex cv/cvpub.bib cv/cvtalk.bib cv/cvjc.cls
	mkdir -p cv/build
	cd cv && latexmk -xelatex --synctex=1 -output-directory="build" cv.tex
	cp cv/build/cv.pdf static/cv.pdf 