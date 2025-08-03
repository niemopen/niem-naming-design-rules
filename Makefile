.PHONY: all clean md html

NDR     = ndr-v6.0-ps01
NDRHTML = $(NDR).html
NDRPDF  = $(NDR).pdf
SRC     = ndr6src.md
TITLE   = NIEM Naming and Design Rules (NDR) Version 6.0


TEMPLATE    = --template=styles/tocTemplate.html
METADATA    = --metadata title="$(TITLE)"
PANDOC_ARGS = -f gfm -t html --toc --toc-depth=5 \
	      -f gfm-autolink_bare_uris -s $(TEMPLATE) $(METADATA)

all : html pdf

html: $(NDRHTML)
pdf:  $(NDRPDF)

# Using pandoc 3.0 to generate HTML from markdown

$(NDRHTML) : $(SRC)
	bin/fixmd $(SRC) | pandoc $(PANDOC_ARGS) $(NDRMD) | bin/moveTOC > $(NDRHTML)

PDFARGS = \
  --enable-local-file-access \
  --page-size Letter \
  -T 25 \
  -B 20 \
  --header-spacing 6 \
  --header-font-size 10 \
  --footer-line \
  --footer-spacing 4 \
  --footer-left '' \
  --footer-center 'fCopyright © OASIS Open 2025. All Rights Reserved.' \
  --footer-right 'f{formatted_date}  - Page [page] of [topage]' \
  --footer-font-size 8 \
  --footer-font-name LiberationSans

$(NDRPDF) : $(NDRHTML)
	wkhtmltopdf $(PDFARGS) $(NDRHTML) $(NDRPDF)

GENERATED = $(NDRMD) $(NDRHTML) $(NDRPDF)

clean:
	rm -f $(GENERATED)

