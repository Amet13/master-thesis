all: build run

build:
	git submodule init
	git submodule update --remote
	latexmk -xelatex -synctex=1 -jobname=master-thesis main.tex

run:
	# Я использую macOS
	open master-thesis.pdf &

clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.lof \
	*.lot \
	*.log \
	*.out \
	*.synctex.gz \
	*.xdv \
	*.toc

docker:
	docker build -t docker-latex .
	docker run --rm -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make build && make clean"
	docker run --rm -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make -C presentation && make -C presentation clean"

pres:
	make -C presentation run
