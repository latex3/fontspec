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
	@echo '                   install  -  install the complete package into your home texmf tree'
	@echo '               sty-install  -  install the package code only'
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
UNPACKED = fontspec.sty fontspec-xetex.sty fontspec-luatex.sty fontspec-patches.sty fontspec.lua fontspec.cfg $(EXAMPLES)
SOURCE = $(DTX) Makefile README
GENERATED = $(COMPILED) $(UNPACKED)

TESTS = $(wildcard testsuite/*.cls testsuite/*.tex testsuite/*.ltx)

DOC_DIR = doc-files
DOC_EXAMPLES = $(shell ls $(DOC_DIR)/*.pdf)

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

DO_PDFLATEX = pdflatex --interaction=nonstopmode $<  $(REDIRECT)
DO_PDFLATEX_WRITE18 = pdflatex --shell-escape --interaction=nonstopmode $<  $(REDIRECT)
DO_TEX = tex --interaction=nonstopmode $<  $(REDIRECT)
DO_MAKEINDEX = makeindex -s gind.ist $(subst .dtx,,$<)  $(REDIRECT)  2>&1

all: $(GENERATED)
doc: $(COMPILED)
unpack: $(UNPACKED)
ctan: $(CTAN_ZIP)
tds: $(TDS_ZIP)
world: all ctan

gendoc: $(DTX)
	@mkdir -p $(DOC_DIR)
	$(DO_PDFLATEX_WRITE18)

$(DOC): $(DTX)
	@echo "Compiling documentation"
	$(DO_PDFLATEX)
	$(DO_MAKEINDEX)
	@echo "Re-compiling documentation"
	$(DO_PDFLATEX)
	@echo "Re-re-compiling documentation"
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

define run-sty-install
@mkdir -p $(RUNDIR) && cp $(RUNFILES) $(RUNDIR)
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
	xelatex --interaction=nonstopmode fontspec-testsuite.tex  $(REDIRECT)

.PHONY: install manifest clean mrproper

install: $(ALL_FILES)
	@if test ! -n "$(TEXMFROOT)" ; then \
		echo "Cannot locate your home texmf tree. Specify manually with\n\n    make install TEXMFROOT=/path/to/texmf\n" ; \
		false ; \
	fi ;
	@echo "Installing in '$(TEXMFROOT)'."
	$(run-install)

sty-install: $(RUNFILES)
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
	@$(RM) -- $(builddir)/*


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

LTXSOURCE = $(NAME).sty $(NAME)-xetex.sty $(NAME)-luatex.sty $(NAME).cfg $(NAME)-patches.sty

TESTLIST = testsuite-listing.tex

SUITESOURCE = \
  $(testdir)/testsuite.cls \
  $(testdir)/$(TESTLIST)

TESTOUT = $(wildcard $(testdir)/*.*safe.pdf)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.ltx,$(TESTOUT)))
BUILDTESTTARGET1 = $(TESTOUT)
BUILDTESTTARGET2 = $(subst $(testdir)/,$(builddir)/,$(BUILDTESTTARGET1))
BUILDTESTTARGET3 = $(subst .Xsafe.pdf,-X.diff.pdf,$(BUILDTESTTARGET2))
BUILDTESTTARGET4 = $(subst .Lsafe.pdf,-L.diff.pdf,$(BUILDTESTTARGET3))
BUILDTESTTARGET = $(BUILDTESTTARGET4)

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

lonelystub = $(shell cd $(testdir); ls | egrep '(X|L)(.*\.ltx)|(X|L)(.*\.safe.pdf)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.pdf,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .pdf,$(lonelystub)))

Xlonelystub = $(shell cd $(testdir); ls | egrep '(F.*\.ltx)|(F.*.Xsafe.pdf)' | cut -d . -f 1 | uniq -u)
Xlonelyfile = $(addsuffix .Xsafe.pdf,$(Xlonelystub))
Xlonelypath = $(addprefix $(testdir)/,$(Xlonelyfile))
Xlonelytest = $(addprefix $(builddir)/,$(addsuffix -X.pdf,$(Xlonelystub)))

Llonelystub = $(shell cd $(testdir); ls | egrep '(F.*\.ltx)|(F.*.Lsafe.pdf)' | cut -d . -f 1 | uniq -u)
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

$(builddir)/F%-L.diff.pdf: $(builddir)/F%-L.pdf
	@echo 'F$*: Comparing PDF from LuaLaTeX against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/F$*-L.pdf \
	                $(testdir)/F$*.Lsafe.pdf \
	                $(builddir)/F$*-L.diff.pdf 2>&1) -le 1 ; then \
	  echo 'F$*: Test passed.' ; \
	else \
	  echo 'F$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/F%-X.diff.pdf: $(builddir)/F%-X.pdf
	@echo 'F$*: Comparing PDF from XeLaTeX against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/F$*-X.pdf \
	                $(testdir)/F$*.Xsafe.pdf \
	                $(builddir)/F$*-X.diff.pdf 2>&1) -le 1 ; then \
	  echo 'F$*: Test passed.' ; \
	else \
	  echo 'F$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/F%-L.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/F%-L.ltx
	@echo 'F$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode F$*-L.ltx  $(REDIRECT)

$(builddir)/F%-X.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/F%-X.ltx
	@echo 'F$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode F$*-X.ltx   $(REDIRECT)

$(builddir)/F%-L.ltx: $(builddir)/F%.ltx
	$(COPY) $< $@

$(builddir)/F%-X.ltx: $(builddir)/F%.ltx
	$(COPY) $< $@


#### TEST FOR EACH ENGINE INDIVIDUALLY ####

$(builddir)/L%.diff.pdf: $(builddir)/L%.pdf
	@echo 'L$*: Comparing PDF against reference output.'
	if test $(shell compare $(COMPARE_OPTS) \
	          $(builddir)/L$*.pdf $(testdir)/L$*.safe.pdf \
	          $(builddir)/L$*.diff.pdf 2>&1) -le 1 ; then \
	  echo 'L$*: Test passed.' ; \
	else \
	  echo 'L$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/X%.diff.pdf: $(builddir)/X%.pdf
	@echo 'X$*: Comparing PDF against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/X$*.pdf \
	                $(testdir)/X$*.safe.pdf \
	                $(builddir)/X$*.diff.pdf 2>&1) -le 1 ; then \
	  echo 'X$*: Test passed.' ; \
	else \
	  echo 'X$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/X%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/X%.ltx
	@echo 'X$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode X$*.ltx $(REDIRECT)

$(builddir)/L%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/L%.ltx
	@echo 'L$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode L$*.ltx $(REDIRECT)

#### HACK: allow `make <foobar>` run that test.

L%: build/L%.ltx
	make build/L$*.diff.pdf

X%: build/X%.ltx
	make build/X$*.diff.pdf

F%: build/F%.ltx
	make build/F$*-L.diff.pdf
	make build/F$*-X.diff.pdf


###### NIGHTLY BUILDS ######

UNAME_S := $(shell uname -s)

# Mac OS X:
ifeq ($(UNAME_S),Darwin)
	MD5 = md5
endif

# Linux:
ifeq ($(UNAME_S),Linux)
	MD5 = md5sum
endif

BRANCH = tds-build

TDS = $(TDS_ZIP)
TMP = /tmp
LOG =  $(TMP)/gitlog.tmp


checkbranch:
	@if  git branch | grep $(BRANCH) > /dev/null ; \
	then echo "TDS branch exists"; \
	else \
	  echo "TDS branch does not exist; doing so will remove all untracked files from your working directory. Create the TDS branch with\n    make createbranch"; \
	  false; \
	fi;

createbranch: $(TDS)
	cp -f $(TDS) $(TMP)/
	git symbolic-ref HEAD refs/heads/$(BRANCH)
	rm .git/index
	git clean -fdx
	unzip -o $(TMP)/$(TDS) -d .
	rm $(TMP)/$(TDS)
	git add --all
	git commit -m "Initial TDS commit"
	git checkout master
	git push origin $(BRANCH) master
	@echo "\nTDS branch creation was successful.\n"
	@echo "Now create a new package at TLContrib: http://tlcontrib.metatex.org/"
	@echo "Use the following metadata:"
	@echo "    Package ID: $(NAME)"
	@echo "        BRANCH: $(BRANCH)"
	@echo "\nAfter this process, use \`make tdsbuild\` to"
	@echo "    (a) push your recent work on the master branch,"
	@echo "    (b) automatically create a TDS snapshot,"
	@echo "    (c) send the TDS snapshot to TLContrib."


ifeq ($(UNAME_S),Darwin)
  nightly:  USERNAME = $(shell security find-internet-password -s tlcontrib.metatex.org | grep "acct" | cut -f 4 -d \")
  nightly:  PASSWORD = $(shell security 2>&1 >/dev/null find-internet-password -gs tlcontrib.metatex.org | cut -f 2 -d ' ')
endif

ifeq ($(UNAME_S),Linux)
  nightly:  USERNAME = ""
  nightly:  PASSWORD = ""
endif

nightly:  VERSION = $(shell date "+%Y-%m-%d@%H:%M")

nightly:  CHECKSUM = $(shell echo $(USERNAME)/$(PASSWORD)/$(VERSION) | $(MD5) )

nightly: tdsbuild checkbranch checkpw
	@echo "Pushing TDS and master branch"
	git push origin $(BRANCH) master
	@echo "Pinging TLContrib for automatic update"
	curl http://tlcontrib.metatex.org/cgi-bin/package.cgi/action=notify/key=$(NAME)/check=$(CHECKSUM)?version=$(VERSION) > /dev/null 2>&1

tdsbuild: $(TDS)
	cp -f $(TDS) $(TMP)/
	@echo "Constructing commit history for snapshot build"
	date "+TDS snapshot %Y-%m-%d %H:%M" > $(LOG)
	echo '\n\nApproximate commit history since last snapshot:\n' >> $(LOG)
	git log --after="`git log -b $(BRANCH) -n 1 --pretty=format:"%aD"`" --pretty=format:"%+H%+s%+b" >> $(LOG)
	@echo "Committing TDS snapshot to separate branch"
	git checkout $(BRANCH)
	unzip -o $(TMP)/$(TDS) -d .
	rm $(TMP)/$(TDS)
	git commit --all --file=$(LOG)
	git checkout master
	@echo "Branches 'master' and '$(BRANCH)' should now be pushed."

checkpw:
	@if test ! -n "$(PASSWORD)" ; then \
		echo "Error: Password cannot be found for TLContrib." ; \
		false ; \
	fi ;
	@echo "Username: $(USERNAME)"
	@echo "Password: [omitted]"
	@echo "Version: $(VERSION)"
	@echo "Checksum: $(CHECKSUM)"

