.PHONY: all clean

VERSION	= 6.0ps01


REF	= refTarget-$(VERSION)
REFSCH	= $(REF).sch
REFXSL  = $(REF).xsl

EXT	= extTarget-$(VERSION)
EXTSCH	= $(EXT).sch
EXTXSL  = $(EXT).xsl

SUB	= subTarget-$(VERSION)
SUBSCH	= $(SUB).sch
SUBXSL  = $(SUB).xsl

SCH	= $(REFSCH) $(EXTSCH) $(SUBSCH)
XSL     = $(REFXSL) $(EXTXSL) $(SUBXSL)

$(REFSCH) : $(addprefix src/, hdr.sch all.sch ref.sch) 
	cat $+ > $@
	echo '</schema>' >>$@

$(EXTSCH) : $(addprefix src/, hdr.sch all.sch ext.sch) 
	cat $+ > $@
	echo '</schema>' >>$@

$(SUBSCH) : $(addprefix src/, hdr.sch all.sch sub.sch) 
	cat $+ > $@
	echo '</schema>' >>$@

%.xsl: %.sch
	scheval --compile -s "$<" > TEMPfile
	xsltproc xsl/xsltpp.xsl TEMPfile > "$@"
	rm -f TEMPfile

all: sch xsl

sch: $(SCH)

xsl: $(XSL)

clean:
	rm -f $(SCH) $(XSL)
