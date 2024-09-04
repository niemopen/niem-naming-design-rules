.PHONY: all clean html pdf

NDR     = ndr-v6.0-psd01
NDRHTML = $(NDR).html
NDRPDF  = $(NDR).pdf
NDRSRC  = ndr6src.md

NDR_CSS     = styles/ndr-styles.css
OASIS_CSS   = styles/markdown-styles-v1.7.3a.css
STYLES      = -c $(OASIS_CSS) -c $(NDR_CSS)
METADATA    = --metadata title="NIEM Naming and Design Rules (NDR) Version 6.0"
PANDOC_ARGS = -f gfm -t html --toc --toc-depth=5 -s $(STYLES) $(METADATA)

all : html pdf

html: $(NDRHTML)

$(NDRHTML) : $(NDRSRC)
	bin/linkdefs $(NDRSRC) | pandoc $(PANDOC_ARGS) -o $(NDRHTML)

VMARG   = --margin-top 16mm --margin-bottom 16mm
HMARG   = --margin-left 10mm --margin-right 10mm
PDFARGS = --enable-local-file-access $(VMARG) $(HMARG)

$(NDRPDF) : $(NDRHTML)
	wkhtmltopdf $(PDFARGS) $(NDRHTML) $(NDRPDF)

GENERATED = $(NDRHTML) $(NDRPDF)
clean:
	rm -f $(GENERATED)

