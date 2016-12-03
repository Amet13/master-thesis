all: build run

build:
	latexmk -xelatex -synctex=1 -jobname=master-thesis main.tex
	
run:
	# Я использую xreader для просмотра PDF
	xreader master-thesis.pdf &
	
clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc
