# master-thesis

[![Actions Status](https://github.com/Amet13/master-thesis/workflows/master-thesis/badge.svg)](https://github.com/Amet13/master-thesis/actions)
[![Лицензия на исходный код](https://img.shields.io/badge/license-GNU_GPLv3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.ru.html)
[![Лицензия на произведения](https://img.shields.io/badge/license-CC_BY--SA_4.0-blue.svg)](https://creativecommons.org/licenses/by-sa/4.0/deed.ru)

Выпускная квалификационная работа (ВКР) магистра в LaTeX, оформленная в соответствии с нормоконтролем Севастопольского государственного университета в 2017 г.

## Особенности

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
* использование `listings` для оформления листинга исходного кода в документе, шрифт FreeMono
* возможность добавления своих PDF в документ
* добавление библиографии в файл `0-bibliography.tex`
* отдельные секции для аннотации, приложений
* автоматически генерируемый список иллюстративного и табличного материала
* ссылки на перечень сокращений и условных обозначений
* слайды презентации
* `Makefile` для компиляции и сборки проекта
* `Dockerfile` для сборки проекта в изолированном окружении

## Структура исходников

```
.
├── extra
├── images
├── inc
├── presentation
├── presentation_it_planet
└── vulncontrol
```

В корневом каталоге находятся файлы:

* `Dockerfile`, с его помощью можно собрать проект в Docker-контейнере без установки LaTeX на локальный компьютер
* в `main.tex` подключаются все остальные файлы
* с помощью `Makefile` можно собрать проект
* файл `master-thesis.pdf` является результатом компиляции проекта
* в `preamble.tex` задается преамбула
* файл `.gitignore` содержит в себе временные файлы, которые не включаются в репозиторий
* файл `.gitmodules` подключает к проекту репозиторий `vulncontrol`

В каталоге `extra/` находятся подключаемые PDF файлы, которые по каким-либо причинам не были сверстны в LaTeX.

В каталоге `images/` находятся иллюстрации.

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

## Работа с LaTeX

Установка нужных пакетов LaTeX в Ubuntu:

```bash
sudo apt install texlive-base texlive-latex-extra texlive-xetex texlive-lang-cyrillic latexmk texlive-fonts-extra texlive-science texlive-latex-recommended
```

Для сборки проекта понадобится установка шрифтов Times New Roman, XITS Math, PT Sans, PT Mono, FreeMono:

```bash
sudo apt install ttf-mscorefonts-installer fonts-freefont-ttf fontconfig
sudo wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf
sudo wget https://ftp.tw.freebsd.org/distfiles/xorg/font/{PTSansOFL,PTMonoOFL}.zip
sudo unzip -o PTSansOFL.zip -d /usr/share/fonts/ && sudo unzip -o PTMonoOFL.zip -d /usr/share/fonts/
sudo rm -f {PTSansOFL,PTMonoOFL}.zip && sudo fc-cache -f -v
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

## Docker

Проект можно собрать в Docker, в таком случае не придется устанавливать LaTeX.
Docker уже должен быть установлен на сервере или локальном компьютере:

```bash
git clone --recursive https://github.com/Amet13/master-thesis
cd master-thesis/
make docker
```
