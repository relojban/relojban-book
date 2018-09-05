builddir = $(if $(BUILDDIR), $(BUILDDIR), $(PWD)/build)
copydir = $(COPYDIR)

.PHONY: all
all: xhtml xhtml_nochunks pdf

.PHONY: clean
clean:
	rm -f $(builddir)/*.xml $(builddir)/*.out $(builddir)/*.done
	rm -rf $(builddir)/xhtml $(builddir)/xhtml_nochunks $(builddir)/pdf

#*******
# Preparation
#*******

$(builddir)/relojban-book-merged.xml: src/*.xml
	mkdir -p $(builddir)/
	xmllint --loaddtd --nonet --xinclude --output $(builddir)/relojban-book-merged.xml src/main.xml

$(builddir)/relojban-book-processed.xml: $(builddir)/relojban-book-merged.xml scripts/xml_preprocess.rb
	ruby scripts/xml_preprocess.rb $(builddir)/relojban-book-merged.xml >$(builddir)/relojban-book-processed.xml 2>$(builddir)/xml_preprocess.out || (tail $(builddir)/xml_preprocess.out && false)
	xmllint --relaxng xml/docbookxi.rng --noout $(builddir)/relojban-book-processed.xml 2>$(builddir)/xml_validation.out || (tail $(builddir)/xml_validation.out && false)
	# alternative validator
	#rnv xml/docbookxi.rnc $(builddir)/relojban-book-processed.xml 2>$(builddir)/xml_validation.out || (tail $(builddir)/xml_validation.out && false)

#*******
# XHTML, chunked
#*******
.PHONY: xhtml
xhtml: $(builddir)/xhtml.done

$(builddir)/xhtml.done: $(builddir)/relojban-book-processed.xml xml/docbook2html_config_xhtml.xsl xml/docbook2html_config_common.xsl scripts/master.css
	rm -rf $(builddir)/xhtml
	mkdir -p $(builddir)/xhtml
	ln -nsf $(PWD)/media $(builddir)/xhtml/media
	xmlto --skip-validation -m xml/docbook2html_config_xhtml.xsl -o $(builddir)/xhtml/ xhtml $(builddir)/relojban-book-processed.xml 2>&1 | grep -v 'No localization exists'
	cp scripts/master.css $(builddir)/xhtml/final.css
	touch $(builddir)/xhtml.done
ifneq ($(copydir),)
	mkdir -p $(copydir)
	rm -rf $(copydir)/relojban-book-xhtml
	cp -pLr $(builddir)/xhtml $(copydir)/relojban-book-xhtml
endif

#*******
# XHTML, one single file
#*******
.PHONY: xhtml_nochunks
xhtml_nochunks: $(builddir)/xhtml_nochunks.done

$(builddir)/xhtml_nochunks.done: $(builddir)/relojban-book-processed.xml xml/docbook2html_config_xhtml_nochunks.xsl xml/docbook2html_config_common.xsl scripts/master.css
	rm -rf $(builddir)/xhtml_nochunks
	mkdir -p $(builddir)/xhtml_nochunks
	ln -nsf $(PWD)/media $(builddir)/xhtml_nochunks/media
	xmlto --skip-validation -m xml/docbook2html_config_xhtml_nochunks.xsl -o $(builddir)/xhtml_nochunks/ xhtml-nochunks $(builddir)/relojban-book-processed.xml 2>&1 | grep -v 'No localization exists'
	mv $(builddir)/xhtml_nochunks/relojban-book-processed.html $(builddir)/xhtml_nochunks/index.html
	cp scripts/master.css $(builddir)/xhtml_nochunks/final.css
	touch $(builddir)/xhtml_nochunks.done
ifneq ($(copydir),)
	mkdir -p $(copydir)
	rm -rf $(copydir)/relojban-book-xhtml-nochunks
	cp -pLr $(builddir)/xhtml_nochunks $(copydir)/relojban-book-xhtml-nochunks
endif

#*******
# Prince PDF
#*******
.PHONY: pdf
pdf: $(builddir)/pdf.done
$(builddir)/pdf.done: $(builddir)/relojban-book-processed.xml xml/docbook2html_config_prince.xsl xml/docbook2html_config_common.xsl scripts/master.css
	rm -rf $(builddir)/pdf
	mkdir -p $(builddir)/pdf
	ln -nsf $(PWD)/media $(builddir)/pdf/media
	xmlto --skip-validation -m xml/docbook2html_config_prince.xsl -o $(builddir)/pdf/ xhtml-nochunks $(builddir)/relojban-book-processed.xml 2>&1 | grep -v 'No localization exists'
	cp scripts/master.css $(builddir)/pdf/final.css
	ruby scripts/xml_prince_postprocess.rb $(builddir)/pdf/relojban-book-processed.html >$(builddir)/pdf/relojban-book-pdf.html 2>$(builddir)/xml_prince_postprocess.out

	prince --verbose --no-network --script=scripts/prince_check_margins.js --script=scripts/prince_shave_index.js $(builddir)/pdf/relojban-book-pdf.html -o $(builddir)/pdf/relojban-book.pdf
	touch $(builddir)/pdf.done
ifneq ($(copydir),)
	mkdir -p $(copydir)
	cp $(builddir)/pdf/relojban-book.pdf $(copydir)/relojban-book.pdf
endif
