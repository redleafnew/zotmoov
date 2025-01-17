all: Makefile.in

-include Makefile.in

RELEASE:=$(shell grep version manifest.json | sed '2q;d' | sed -e 's/^ *"version": "//' -e 's/",//')

zotmoov.xpi: FORCE
	rm -rf $@
	zip -FSr $@ bootstrap.js locale manifest.json prefs.js prefs.xhtml zotmoov.js zotmoov_prefs.js zotmoov_menus.js -x \*.DS_Store

zotmoov-%-fx.xpi: zotmoov.xpi
	mv $< $@

Makefile.in: manifest.json
	echo "all: zotmoov-${RELEASE}-fx.xpi" > Makefile.in

FORCE:
