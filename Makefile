ECLIPSE      :=	eclipse

ECLS         := $(wildcard *.ecl)
ECIS         := $(ECLS:.ecl=.eci)
ECOS         := $(ECLS:.ecl=.eco)

all: $(ECOS) docs

%.eco: %.ecl
	$(ECLIPSE) -e 'compile($*, [output: eco])'

%.eci: %.ecl
	$(ECLIPSE) -e 'lib(document), icompile($*)'

docs: $(ECIS)
	$(ECLIPSE) -e 'lib(document), get_flag(installation_directory, Home), concat_string(["<A HREF=\"", Home, "/doc/bips/index.html\">Reference Manual</A>"], Link), ecis_to_htmls(".", "doc", Link)'

clean:
	$(RM) $(ECOS) $(ECIS) *~
	$(RM) -r doc
