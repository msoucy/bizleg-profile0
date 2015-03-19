#!/usr/bin/make

FILES:=${wildcard *.md}
OUTDIR:=output

.PHONY: default slides pdf latex all clean

default: slides

slides: $(FILES:%.md=$(OUTDIR)/%/index.html)
slides: $(OUTDIR)/reveal.js
pdf:    $(FILES:%.md=$(OUTDIR)/%/presentation.pdf)
latex:  $(FILES:%.md=$(OUTDIR)/%/presentation.tex)

all: clean slides pdf latex

PANDOC=pandoc $< -o $@

$(OUTDIR)/reveal.js:
	cp -r reveal.js $(OUTDIR)/

$(OUTDIR)/%/index.html: %.md
	mkdir -p $(OUTDIR)/$*
	$(PANDOC) -t revealjs -s -V theme:solarized -V revealjs-url:../reveal.js --slide-level 2 --data-dir=.

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

