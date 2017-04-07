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
	*.lof \
	*.lot \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc

IMAGE=docker-latex
PROJECT_DIR=master-thesis
DOCKER_DIR=master-thesis

docker:
	docker build -t docker-latex .
	docker run -ti -v ../$PROJECT_DIR:/$DOCKER_DIR:Z $IMAGE bash -c "make build && make clean"
