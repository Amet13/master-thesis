master-thesis
=============
[![TravisCI](https://travis-ci.org/Amet13/master-thesis.svg?branch=master)](https://travis-ci.org/Amet13/master-thesis/)
[![Лицензия на исходный код](https://img.shields.io/badge/license-GNU_GPLv3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.ru.html)
[![Лицензия на произведения](https://img.shields.io/badge/license-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/deed.ru)

Выпускная квалификационная работа (ВКР) магистра в LaTeX, оформленная в соответствии с нормоконтролем Севастопольского государственного университета в 2017 г.

Особенности
-----------
* использование XeLaTeX, основной шрифт Times New Roman, 14pt, полуторный межстрочный интервал
* шрифт для формул XITS Math, шрифты для презентации PT Sans, PT Mono
* подрисуночные и подтабличные записи в формате `номерСекции.номерРисунка`
* нумерация страниц посередине сверху
* возможность указания начала нумерации страниц
* возможность настройки отступов страниц
* маркировка списка символом `—`
* нумерованные списки обозначаются строчными буквами кириллицы со скобкой
* названия секций в верхнем регистре, включая содержание
* отступ в одну строку после имени заголовка
* отступы в одну строку до и после имени заголовков второго и третьего уровней
* пользовательские функции добавления рисунков, приложений и библиографии
* использование `listings` для оформления исходного кода в документе, шрифт FreeMono
* возможность добавления своих PDF в документ
* добавление библиографии в файл `0-bibliography.tex`
* отдельные секции для аннотации, приложений
* автоматически генерируемый список иллюстративного и табличного материала
* ссылки на перечень сокращений и условных обозначений
* слайды презентации
* `Makefile` для компиляции и сборки проекта
* `Dockerfile` для сборки проекта в изолированном окружении

Структура исходников
--------------------
```
.
├── images
├── inc
├── presentation
└── vulncontrol
```

В корневом каталоге находятся файлы:
* `Dockerfile`, с его помощью можно собрать проект в Docker-контейнере без установки LaTeX на локальный компьютер
* в `main.tex` подключаются все остальные файлы
* с помощью `Makefile` можно собрать проект
* файл `master-thesis.pdf` является результатом компиляции проекта
* в `preamble.tex` задается преамбула
* файл `.gitmodules` подключает к проекту репозиторий `vulncontrol`
* файл `.travis.yml` необходим для сборки git-проекта в окружении TravisCI
* в каталоге `images/` находятся изображения, используемые в тексте диплома

В каталоге `inc/` находятся файлы, которые подключаются к `main.tex`:
* файлы формата `0-*.tex` являются ненумерованными секциями (например введение, заключение, библиография)
* файлы формата `[1-9]-*.tex` являются нумерованными секциями (например постановка задчи, обзор литературных источников и т.д)
* файлы формата `[a-z]-app.tex` являются файлами приложений

В каталоге `presentation/` находятся файлы необходимые для сборки слайдов презентации:
* `beamerthemeMasterThesis.sty` является файлом стиля презентации
* в файле `main.tex` находится преамбула
* `Makefile` необходим для сборки
* `slides.tex` является файлом, содержащим текст презентации
* `presentation.pdf` является результатом компиляции слайдов презентации
* `report.md` содержит сопровождающий текст к слайдам презентации

Каталог `vulncontrol/` является ссылкой на [репозиторий](https://github.com/Amet13/vulncontrol), содержащий исходный код скрипта для сбора данных по уязвимостям.

Работа с LaTeX
--------------
Установка нужных пакетов LaTeX в Ubuntu/Mint:
```bash
sudo apt install texlive-base texlive-latex-extra texlive-xetex texlive-lang-cyrillic latexmk texlive-fonts-extra texlive-math-extra latex-beamer
```

Для сборки проекта понадобится установка шрифтов Times New Roman, XITS Math, PT Sans, PT Mono:
```bash
sudo apt install ttf-mscorefonts-installer
sudo wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/xits-math.otf
sudo wget http://www.paratype.ru/uni/public/{PTSansOFL,PTMono}.zip
sudo unzip PTSansOFL.zip -d /usr/share/fonts/ && sudo unzip PTMono.zip -d /usr/share/fonts/
sudo rm -f {PTSansOFL,PTMono}.zip && sudo fc-cache -f -v
```

Пример компиляции проекта с помощью Makefile:
```bash
git clone --recursive https://github.com/Amet13/master-thesis
cd master-thesis/
make
```

Пример очистки сборочных файлов после компиляции (кроме PDF):
```bash
make clean
```

Пример сборки слайдов презентации:
```bash
make pres
```

Docker
------
[![Docker](https://img.shields.io/badge/docker_build-passing-green.svg)](https://github.com/Amet13/master-thesis/releases)

Проект можно собрать в Docker, в таком случае не придется устанавливать LaTeX.
Docker уже должен быть установлен на сервере или локальном компьютере:
```
git clone --recursive https://github.com/Amet13/master-thesis
cd master-thesis/
make docker
```
