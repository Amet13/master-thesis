# master-thesis

[Русская версия](README-ru.md) | [English version](README.md)

[![Actions Status](https://github.com/Amet13/master-thesis/workflows/master-thesis/badge.svg)](https://github.com/Amet13/master-thesis/actions)
[![Source Code License](https://img.shields.io/badge/license-GNU_GPLv3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.ru.html)
[![Content License](https://img.shields.io/badge/license-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/deed.ru)

Master's thesis in LaTeX, formatted according to the standards of Sevastopol State University in 2017.

## Features

- use of XeLaTeX, main font Times New Roman, 14pt, 1.5 line spacing
- XITS Math font for formulas, PT Sans and PT Mono fonts for presentation
- figure and table captions in format `sectionNumber.figureNumber`
- page numbers centered at the top
- ability to specify starting page number
- ability to configure page margins
- list marking with `—` symbol
- numbered lists are denoted by lowercase Cyrillic letters with parentheses
- section titles in uppercase, including table of contents
- one line indent after title name
- one line indents before and after second and third level headings
- custom functions for adding figures, appendices and bibliography
- use of `listings` for formatting source code listings in document, FreeMono font
- ability to add your own PDFs to the document
- bibliography addition in `0-bibliography.tex` file
- separate sections for abstract, appendices
- automatically generated list of illustrative and tabular material
- references to abbreviations and symbols list
- presentation slides
- `Makefile` for project compilation and building
- `Dockerfile` for building project in isolated environment

## Source Structure

```
.
├── extra
├── images
├── inc
├── presentation
├── presentation_it_planet
└── vulncontrol
```

In the root directory are files:

- `Dockerfile`, with its help you can build the project in a Docker container without installing LaTeX on your local computer
- `main.tex` includes all other files
- `Makefile` can be used to build the project
- `master-thesis.pdf` is the result of project compilation
- `preamble.tex` sets the preamble
- `.gitignore` file contains temporary files that are not included in the repository
- `.gitmodules` file connects the `vulncontrol` repository to the project

In the `extra/` directory are included PDF files that for some reason were not typeset in LaTeX.

In the `images/` directory are illustrations.

In the `inc/` directory are files that are included in `main.tex`:

- files of format `0-*.tex` are unnumbered sections (e.g., introduction, conclusion, bibliography)
- files of format `[1-9]-*.tex` are numbered sections (e.g., problem statement, literature review, etc.)
- files of format `[a-z]-app.tex` are appendix files

In the `presentation/` directory are files necessary for building presentation slides:

- `beamerthemeMasterThesis.sty` is the presentation style file
- `main.tex` file contains the preamble
- `Makefile` is necessary for building
- `slides.tex` is the file containing the presentation text
- `presentation.pdf` is the result of presentation slides compilation
- `report.md` contains accompanying text for the presentation slides

The `vulncontrol/` directory is a link to the [repository](https://github.com/Amet13/vulncontrol) containing the source code of the script for collecting vulnerability data.

## Working with LaTeX

Installing required LaTeX packages in Ubuntu:

```bash
sudo apt install texlive-base texlive-latex-extra texlive-xetex texlive-lang-cyrillic latexmk texlive-fonts-extra texlive-science texlive-latex-recommended
```

For building the project, installation of Times New Roman, XITS Math, PT Sans, PT Mono, FreeMono fonts is required:

```bash
sudo apt install ttf-mscorefonts-installer fonts-freefont-ttf fontconfig
sudo wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf
sudo wget https://ponce.cc/slackware/sources/repo/ttf-paratype-pt-fonts/{PTSansOFL,PTMonoOFL}.zip
sudo unzip -o PTSansOFL.zip -d /usr/share/fonts/ && sudo unzip -o PTMonoOFL.zip -d /usr/share/fonts/
sudo rm -f {PTSansOFL,PTMonoOFL}.zip && sudo fc-cache -f -v
```

Example of project compilation using Makefile:

```bash
git clone --recursive https://github.com/Amet13/master-thesis
cd master-thesis/
make
```

Example of cleaning build files after compilation (except PDF):

```bash
make clean
```

Example of building presentation slides:

```bash
make pres
```

## Docker

The project can be built in Docker, in which case you won't need to install LaTeX.
Docker should already be installed on the server or local computer:

```bash
git clone --recursive https://github.com/Amet13/master-thesis
cd master-thesis/
make docker
```
