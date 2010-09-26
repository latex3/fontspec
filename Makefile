# Makefile for fontspec.

#### MAKEFILE CONFIG ####

SHELL = /bin/sh
.SUFFIXES:
.SILENT:

#### BEGIN ####

help:
	@echo 'FONTSPEC makefile targets:'
	@echo ' '
	@echo '                  help  -  (this message)'
	@echo '                unpack  -  extracts all files'
	@echo '                   doc  -  compile documentation'
	@echo '                gendoc  -  compile documentation including external examples'
	@echo '                  ctan  -  generate archive for CTAN'
	@echo '                   all  -  unpack & doc'
	@echo '                 world  -  all & ctan'
	@echo '                 clean  -  remove all generated and built files'
	@echo ' '
	@echo '                   install  -  install the package into your home texmf tree'
	@echo ' install TEXMFROOT=<texmf>  -  install the package into the path <texmf>'
	@echo ' '
	@echo '                 check  -  run the test suite'
	@echo '               initest  -  initialise any new tests'
	@echo '            <testname>  -  run only this test'
	@echo ' '
	@echo 'I recommend `make -j4 check` or thereabouts to parallelise'
	@echo 'the testing.'


NAME = fontspec
DOC = $(NAME).pdf
DTX = $(NAME).dtx

# Redefine this to print output if you need:
REDIRECT = > /dev/null

# Files grouped by generation mode
COMPILED = $(DOC) fontspec-testsuite.pdf
EXAMPLES = fontspec-example.tex
UNPACKED = fontspec.sty fontspec-patches.sty fontspec.lua fontspec.cfg $(EXAMPLES)
SOURCE = $(DTX) Makefile README
GENERATED = $(COMPILED) $(UNPACKED)

TESTS = $(shell ls testsuite/*.cls testsuite/*.tex testsuite/*.ltx)

DOC_EXAMPLES = $(shell ls doc/*.pdf)

CTAN_FILES = $(SOURCE) $(COMPILED) $(EXAMPLES) $(DOC_EXAMPLES)

# Files grouped by installation location
UNPACKED_DOC = fontspec-example.tex

RUNFILES = $(filter-out $(UNPACKED_DOC), $(UNPACKED))
DOCFILES = $(COMPILED) README $(UNPACKED_DOC)
SRCFILES = $(DTX) Makefile

ALL_FILES = $(RUNFILES) $(DOCFILES) $(SRCFILES)

# Installation locations
FORMAT = latex
RUNDIR = $(TEXMFROOT)/tex/$(FORMAT)/$(NAME)
DOCDIR = $(TEXMFROOT)/doc/$(FORMAT)/$(NAME)
SRCDIR = $(TEXMFROOT)/source/$(FORMAT)/$(NAME)
TEXMFROOT = $(shell kpsewhich --var-value TEXMFHOME)

CTAN_ZIP = $(NAME).zip
TDS_ZIP = $(NAME).tds.zip
ZIPS = $(CTAN_ZIP) $(TDS_ZIP)

DO_PDFLATEX = pdflatex --interaction=batchmode $< >/dev/null
DO_PDFLATEX_WRITE18 = pdflatex --shell-escape --interaction=batchmode $< >/dev/null
DO_TEX = tex --interaction=batchmode $< >/dev/null
DO_MAKEINDEX = makeindex -s gind.ist $(subst .dtx,,$<) >/dev/null 2>&1

all: $(GENERATED)
doc: $(COMPILED)
unpack: $(UNPACKED)
ctan: $(CTAN_ZIP)
tds: $(TDS_ZIP)
world: all ctan

gendoc: $(DTX)
	$(DO_PDFLATEX_WRITE18)

$(DOC): $(DTX)
	$(DO_PDFLATEX)
	$(DO_MAKEINDEX)
	$(DO_PDFLATEX)
	$(DO_PDFLATEX)

$(UNPACKED): $(DTX)
	@$(DO_TEX)

$(CTAN_ZIP): $(CTAN_FILES) $(TDS_ZIP)
	@echo "Making $@ for CTAN upload."
	@$(RM) -- $@
	@zip -9 $@ $^ >/dev/null

define run-install
@mkdir -p $(RUNDIR) && cp $(RUNFILES) $(RUNDIR)
@mkdir -p $(DOCDIR) && cp $(DOCFILES) $(DOCDIR)
@mkdir -p $(SRCDIR) && cp $(SRCFILES) $(SRCDIR)
@mkdir -p $(SRCDIR)/testsuite/ && cp $(TESTS) $(SRCDIR)/testsuite/
endef

$(TDS_ZIP): TEXMFROOT=./tmp-texmf
$(TDS_ZIP): $(ALL_FILES)
	@echo "Making TDS-ready archive $@."
	@$(RM) -- $@
	$(run-install)
	@cd $(TEXMFROOT) && zip -9 ../$@ -r . >/dev/null
	@$(RM) -r -- $(TEXMFROOT)

# Rename the README for CTAN
README: README.markdown
	cp $< $@

# lazy:
fontspec-testsuite.pdf: $(DTX)
	@echo 'Compiling test suite.'
	$(DO_PDFLATEX)
	xelatex --interaction=batchmode fontspec-testsuite.tex

.PHONY: install manifest clean mrproper

install: $(ALL_FILES)
	@if test ! -n "$(TEXMFROOT)" ; then \
		echo "Cannot locate your home texmf tree. Specify manually with\n\n    make install TEXMFROOT=/path/to/texmf\n" ; \
		false ; \
	fi ;
	@echo "Installing in '$(TEXMFROOT)'."
	$(run-install)

manifest: 
	@echo "Source files:"
	@for f in $(SOURCE); do echo $$f; done
	@echo ""
	@echo "Derived files:"
	@for f in $(GENERATED); do echo $$f; done

clean:
	@$(RM) -- *.log *.aux *.toc *.idx *.ind *.ilg *.glo *.gls *.example *.out *.synctex* *.tmp fontspec-style.sty *.ins fontspec*.pdf
	@$(RM) -- $(GENERATED) $(ZIPS)


#############
# TESTSUITE #
#############

#### Needed to compile and make stuff ####

builddir=build
testdir=testsuite
lprefix=L
xprefix=X
both=F

COPY = cp -a
MOVE = mv -f
COMPARE_OPTS = -density 300x300 -metric ae -fuzz 35%

LTXSOURCE = $(NAME).sty $(NAME).cfg $(NAME)-patches.sty

TESTLIST = testsuite-listing.tex

SUITESOURCE = \
  $(testdir)/testsuite.cls \
  $(testdir)/$(TESTLIST)

TESTOUT = $(shell ls $(testdir)/*.*safe.pdf)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.ltx,$(TESTOUT)))
BUILDTESTTARGET = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.diff.pdf,$(TESTOUT)))

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(subst $(testdir)/,$(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

#### All tests ####

check: $(TESTLIST)

$(TESTLIST): $(BUILDFILES) $(BUILDTESTTARGET)
	@cd $(testdir); \
	ls *.ltx | sed -e 's/\(.*\).ltx/\\TEST{\1}/g' > $(TESTLIST)

$(builddir)/%: $(testdir)/%
	@mkdir -p $(builddir); \
	$(COPY) $< $@

$(builddir)/%: %
	@mkdir -p $(builddir); \
	$(COPY) -f $< $@


#### Generating new tests ####

lonelystub = $(shell cd $(testdir); ls | egrep '($(xprefix)|$(lprefix))(.*\.ltx)|($(xprefix)|$(lprefix))(.*\.safe.pdf)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.pdf,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .pdf,$(lonelystub)))

Xlonelystub = $(shell cd $(testdir); ls | egrep '($(both).*\.ltx)|($(both).*.Xsafe.pdf)' | cut -d . -f 1 | uniq -u)
Xlonelyfile = $(addsuffix .Xsafe.pdf,$(Xlonelystub))
Xlonelypath = $(addprefix $(testdir)/,$(Xlonelyfile))
Xlonelytest = $(addprefix $(builddir)/,$(addsuffix -X.pdf,$(Xlonelystub)))

Llonelystub = $(shell cd $(testdir); ls | egrep '($(both).*\.ltx)|($(both).*.Lsafe.pdf)' | cut -d . -f 1 | uniq -u)
Llonelyfile = $(addsuffix .Lsafe.pdf,$(Llonelystub))
Llonelypath = $(addprefix $(testdir)/,$(Llonelyfile))
Llonelytest = $(addprefix $(builddir)/,$(addsuffix -L.pdf,$(Llonelystub)))

initest: $(lonelypath) $(Xlonelypath) $(Llonelypath)

$(lonelypath): $(lonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.safe.pdf/.pdf/`  $@

$(Xlonelypath): $(Xlonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.Xsafe.pdf/-X.pdf/`  $@

$(Llonelypath): $(Llonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.Lsafe.pdf/-L.pdf/`  $@


#### TESTS FOR BOTH ENGINES ####

$(builddir)/$(both)%-L.diff.pdf: $(builddir)/$(both)%-$(lprefix).pdf
	@echo '$(both)$*: Comparing PDF from LuaLaTeX against reference output.'
	@if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/$(both)$*-$(lprefix).pdf \
	                $(testdir)/$(both)$*.$(lprefix)safe.pdf \
	                $(builddir)/$(both)$*-$(lprefix).diff.pdf 2>&1) -le 1 ; then \
	  echo '$(both)$*: Test passed.' ; \
	else \
	  echo '$(both)$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/$(both)%-X.diff.pdf: $(builddir)/$(both)%-$(xprefix).pdf
	@echo '$(both)$*: Comparing PDF from LuaLaTeX against reference output.'
	@if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/$(both)$*-$(xprefix).pdf \
	                $(testdir)/$(both)$*.$(xprefix)safe.pdf \
	                $(builddir)/$(both)$*-$(xprefix).diff.pdf 2>&1) -le 1 ; then \
	  echo '$(both)$*: Test passed.' ; \
	else \
	  echo '$(both)$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/$(both)%-$(lprefix).pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/$(both)%-L.ltx
	@echo '$(both)$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode $(both)$*-L.ltx  $(REDIRECT)

$(builddir)/$(both)%-$(xprefix).pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/$(both)%-X.ltx
	@echo '$(both)$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode $(both)$*-X.ltx   $(REDIRECT)

$(builddir)/$(both)%-$(lprefix).ltx: $(builddir)/$(both)%.ltx
	$(COPY) $< $@

$(builddir)/$(both)%-$(xprefix).ltx: $(builddir)/$(both)%.ltx
	$(COPY) $< $@


#### TEST FOR EACH ENGINE INDIVIDUALLY ####

$(builddir)/$(lprefix)%.diff.pdf: $(builddir)/$(lprefix)%.pdf
	@echo '$(lprefix)$*: Comparing PDF against reference output.'
	@if test $(shell compare $(COMPARE_OPTS) \
	          $(builddir)/$(lprefix)$*.pdf $(testdir)/$(lprefix)$*.safe.pdf \
	          $(builddir)/$(lprefix)$*.diff.pdf 2>&1) -le 1 ; then \
	  echo '$(lprefix)$*: Test passed.' ; \
	else \
	  echo '$(lprefix)$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/$(xprefix)%.diff.pdf: $(builddir)/$(xprefix)%.pdf
	@echo '$(xprefix)$*: Comparing PDF against reference output.'
	@if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/$(xprefix)$*.pdf \
	                $(testdir)/$(xprefix)$*.safe.pdf \
	                $(builddir)/$(xprefix)$*.diff.pdf 2>&1) -le 1 ; then \
	  echo '$(xprefix)$*: Test passed.' ; \
	else \
	  echo '$(xprefix)$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/$(xprefix)%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/$(xprefix)%.ltx
	@echo '$(xprefix)$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode $(xprefix)$*.ltx $(REDIRECT)

$(builddir)/$(lprefix)%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/$(lprefix)%.ltx
	@echo '$(lprefix)$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode $(lprefix)$*.ltx $(REDIRECT)

#### HACK: allow `make <foobar>` run that test.

%: build/%.ltx
	make build/$*.diff.pdf