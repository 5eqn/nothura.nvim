SCRIPT1 ?= "nothura-md"
SCRIPT2 ?= "nothura-pdf"

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin

install:
	install -D -m 755 -o root -g root $(SCRIPT1).sh $(DESTDIR)$(BINPREFIX)/$(SCRIPT1)
	install -D -m 755 -o root -g root $(SCRIPT2).sh $(DESTDIR)$(BINPREFIX)/$(SCRIPT2)

uninstall:
	rm -rf "$(DESTDIR)$(BINPREFIX)/$(SCRIPT1)"
	rm -rf "$(DESTDIR)$(BINPREFIX)/$(SCRIPT2)"
