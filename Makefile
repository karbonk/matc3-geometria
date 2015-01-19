# makefile per geometria.tex
#
# (c) 2015 Daniele Masini - d.masini.it@gmail.com
# v1.0
#
NAME = geometria

SHORT_NAME = geometria_clr

TEX = $(NAME).tex

PDF = $(NAME).pdf

PDF_DEF = $(NAME)-def.pdf

PDFLATEX = pdflatex --shell-escape

FILE_CLEAN = *.aux *.gnuplot *.table *.toc *.log *~ *backup

ROOT = $(shell basename $$(pwd))

DIRS = chap* lbr

CLEAN_DIRS= $(DIRS:%=clean-%)

DATE = $(shell date "+%Y%m%d")

TAR= $(SHORT_NAME)-$(DATE).tar.gz

ZIP= $(SHORT_NAME)-$(DATE).zip

help:
	@echo ''
	@echo 'Geometria Razionale    - Makefile targets'
	@echo ''
	@echo ' help       - Questo messaggio'
	@echo ' pdf        - Crea il file pdf'
	@echo ' clean      - Rimuove tutti i file ausiliari'
	@echo ' clean-dist - Rimuove tutti i file prodotti'
	@echo ' dist-tar   - Crea una distribuzione (tar.gz) del codice sorgente, esclundendo il file pdf'
	@echo ' dist-zip   - Crea una distribuzione (zip) del codice sorgente, esclundendo il file pdf'
	@echo ''

pdf: $(TEX)
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	mv -f $(PDF) $(PDF_DEF)

clean: $(CLEAN_DIRS)
$(CLEAN_DIRS):
	@for i in $(FILE_CLEAN); \
	 do \
		find ./ -type f -name "$$i" -delete ; \
	done

clean-dist: clean
	rm -f $(PDF_DEF)
	rm -f *.tar.gz
	rm -f *.zip
 
dist-zip: clean
	rm -f  $(ZIP)
	zip -r $(ZIP) . -x '$(PDF)' -x '*.zip' -x '*.tar.gz'

dist-tar: clean
	rm -f $(TAR)
	tar -czvf $(TAR) --exclude $(PDF_DEF) --exclude *.tar.gz --exclude *.zip *

# END OF MAKEFILE

