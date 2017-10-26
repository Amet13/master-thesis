all: build

build:
	latexmk -xelatex -synctex=1 -jobname=presentation_it_planet main.tex

run: build clean
	# Я использую xreader для просмотра PDF
	xreader presentation_it_planet.pdf &

clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc \
	*.snm \
	*.nav
