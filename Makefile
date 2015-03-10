#!/usr/bin/make

FILES:=${wildcard *.md}
OUTDIR:=output

.PHONY: default slides pdf latex all clean

default: slides

slides: $(FILES:%.md=$(OUTDIR)/%/index.html)
pdf:    $(FILES:%.md=$(OUTDIR)/%/presentation.pdf)
latex:  $(FILES:%.md=$(OUTDIR)/%/presentation.tex)

all: clean slides pdf latex

PANDOC=pandoc $< -o $@

$(OUTDIR)/%/index.html: %.md
	mkdir -p $(OUTDIR)/$*
	cp -r reveal.js output/$*/
	$(PANDOC) -t revealjs -s -V theme:solarized

$(OUTDIR)/%/presentation.pdf: %.md
	mkdir -p $(OUTDIR)/$*
	$(PANDOC) --toc

$(OUTDIR)/%/presentation.tex: %.md
	mkdir -p $(OUTDIR)/$*
	$(PANDOC)

$(OUTDIR):
	mkdir -p $(OUTDIR)

clean:
	rm -rf $(OUTDIR) &> /dev/null

