.PHONY: cv.pdf all

all: cv.pdf

cv.pdf: cv.tex cvjc.cls
	mkdir -p build
	latexmk -xelatex --synctex=1 -output-directory="build" cv.tex

clean:
	rm -rf build

