.PHONY: all clean md html

NDR     = ndr-v6.0-psd01
NDRMD   = $(NDR).md
NDRHTML = $(NDR).html
NDRPDF  = $(NDR).pdf
NDRSRC  = ndr6src.md

NDR_CSS     = styles/ndr-styles.css
OASIS_CSS   = styles/markdown-styles-v1.7.3a.css
TOC_HTML    = styles/tocTemplate.html
STYLES      = -c $(OASIS_CSS) -c $(NDR_CSS) --template=$(TOC_HTML)
METADATA    = --metadata title="NIEM Naming and Design Rules (NDR) Version 6.0"
PANDOC_ARGS = -f gfm -t html --toc --toc-depth=5 -s $(STYLES) $(METADATA)

all : md html

md:   $(NDRMD)
html: $(NDRHTML)

$(NDRMD) : $(NDRSRC)
	bin/fixmd $(NDRSRC) > $(NDRMD)

# Using pandoc 3.0 to generate HTML from markdown

$(NDRHTML) : $(NDRMD)
	pandoc $(PANDOC_ARGS) $(NDRMD) | bin/moveTOC > $(NDRHTML)

# wkhtmltopdf produces PDF with broken links
# also the font looks wrong
# using Edge and print-to-pdf instead

VMARG   = --margin-top 16mm --margin-bottom 16mm
HMARG   = --margin-left 10mm --margin-right 10mm
PDFARGS = --enable-local-file-access $(VMARG) $(HMARG)

$(NDRPDF) : $(NDRHTML)
	wkhtmltopdf $(PDFARGS) $(NDRHTML) $(NDRPDF)

GENERATED = $(NDRMD) $(NDRHTML) $(NDRPDF)
clean:
	rm -f $(GENERATED)

