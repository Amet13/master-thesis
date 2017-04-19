all: build run

build:
	git submodule update --remote
	latexmk -xelatex -synctex=1 -jobname=master-thesis main.tex

run:
	# Я использую xreader для просмотра PDF
	xreader master-thesis.pdf &

clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.lof \
	*.lot \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc

docker:
	docker build -t docker-latex .
	docker run -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make build && make clean"
	docker run -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make -C presentation && make -C presentation clean"

pres:
	make -C presentation run
