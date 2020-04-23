# Manifest for fontspec

This file is a listing of all files considered to be part of this package.
It is automatically generated with `texlua build.lua manifest`.


## Repository manifest

The following groups list the files included in the development repository of the package.
Files listed with a ‘†’ marker are included in the TDS but not CTAN files, and files listed
with ‘‡’ are included in both.

### Source files

These are source files for a number of purposes, including the `unpack` process which
generates the installation files of the package. Additional files included here will also
be installed for processing such as testing.

* fontspec.ins ‡
* fontspec-code-api.dtx ‡
* fontspec-code-closing.dtx ‡
* fontspec-code-enc.dtx ‡
* fontspec-code-feat-aat.dtx ‡
* fontspec-code-feat-opentype.dtx ‡
* fontspec-code-fontload.dtx ‡
* fontspec-code-graphite.dtx ‡
* fontspec-code-interfaces.dtx ‡
* fontspec-code-internal.dtx ‡
* fontspec-code-keyval.dtx ‡
* fontspec-code-lang.dtx ‡
* fontspec-code-load.dtx ‡
* fontspec-code-math.dtx ‡
* fontspec-code-msg.dtx ‡
* fontspec-code-opening.dtx ‡
* fontspec-code-opentype.dtx ‡
* fontspec-code-scripts.dtx ‡
* fontspec-code-user.dtx ‡
* fontspec-code-vars.dtx ‡
* fontspec-code-xfss.dtx ‡
* fontspec-lua.dtx ‡
* fontspec.dtx ‡
* fontspec-code.ltx ‡
* fontspec.ltx ‡
* fontspec.cfg ‡
* fontspec-doc-api.tex ‡
* fontspec-doc-enc.tex ‡
* fontspec-doc-featset.tex ‡
* fontspec-doc-fontsel.tex ‡
* fontspec-doc-intro.tex ‡
* fontspec-doc-luatex.tex ‡
* fontspec-doc-opentype.tex ‡
* fontspec-doc-xetex.tex ‡
* fontspec-example.tex ‡
* fontspec-doc-style.sty ‡

### Typeset documentation source files

These files are typeset using LaTeX to produce the PDF documentation for the package.

* fontspec.ltx ‡
* fontspec-code.ltx ‡

### Text files

Plain text files included as documentation or metadata.

* README.md ‡
* CHANGES.md ‡
* LICENSE 

### Demo files

Files included to demonstrate package functionality. These files are *not*
typeset or compiled in any way.

* fontspec-example.tex ‡

### Derived files

The files created by ‘unpacking’ the package sources. This typically includes
`.sty` and `.cls` files created from DocStrip `.dtx` files.

* fontspec.sty †
* fontspec-xetex.sty †
* fontspec-luatex.sty †
* fontspec.lua †

### Typeset documents

The output files (PDF, essentially) from typesetting the various source, demo,
etc., package files.

* fontspec.pdf ‡
* fontspec-code.pdf ‡

### Checking-specific support files

Support files for checking the test suite.

* fontspec-testsetup.tex 
* luaotfload.conf 
* regression-test.cfg 

### Test files

These files form the test suite for the package. `.lvt` or `.lte` files are the individual
unit tests, and `.tlg` are the stored output for ensuring changes to the package produce
the same output. These output files are sometimes shared and sometime specific for
different engines (pdfTeX, XeTeX, LuaTeX, etc.).

* 0-pkg-load.lvt 
* 00-pkg-load-babel.lvt 
* 00-pkg-load-eu.lvt 
* 00-pkg-load-tu.lvt 
* 02-pkg-load-predocclass.lvt 
* aff-group.lvt 
* aff-italic-only.lvt 
* aff-numbers.lvt 
* aff-sc-repeated.lvt 
* api-assorted.lvt 
* api-font-if-exist.lvt 
* api-if-current-feature.lvt 
* api-if-feature.lvt 
* api-if-font-feature-active.lvt 
* api-if-small-caps.lvt 
* api-script.lvt 
* api-tag-too-long.lvt 
* colour-basic.lvt 
* colour-opacity.lvt 
* em-declare.lvt 
* em-innershape.lvt 
* em.lvt 
* enc-T1-default.lvt 
* enc-new-enc.lvt 
* feat-LocalForms.lvt 
* feat-hyphenchar.lvt 
* feat-number-multichoice.lvt 
* feat-punctspace.lvt 
* feat-reset.lvt 
* feat-scale-again.lvt 
* feat-scale-match.lvt 
* feat-ss06.lvt 
* feat-wordspace.lvt 
* fontface-overwrite.lvt 
* fontface-spaces.lvt 
* fontload-defaults-adding.lvt 
* fontload-defaults-change.lvt 
* fontload-defaults.lvt 
* fontload-fontface-1.lvt 
* fontload-fontface-2-sc.lvt 
* fontload-fontface-3-sizing.lvt 
* fontload-fontspec-file-case.lvt 
* fontload-fontspec-file.lvt 
* fontload-mainsans.lvt 
* fontload-mathetc.lvt 
* fontload-nfssfamily-1.lvt 
* fontload-nfssfamily-2.lvt 
* fontload-onesize-nosc.lvt 
* fontload-scfeat-nesting.lvt 
* fontload-sizefeatures-1.lvt 
* fontload-sizefeatures-2-nesting.lvt 
* fontload-sl-fsfile.lvt 
* fontload-sl.lvt 
* fontload-ttc-fontindex.lvt 
* fontload-ttc.lvt 
* italicfeatures-concat.lvt 
* luatex-subs.lvt 
* mergeshapes.lvt 
* newfontfamily.lvt 
* polyglossia-add-script.lvt 
* polyglossia-cyrl.lvt 
* primitive-if-exist.lvt 
* script-lang-trk.lvt 
* script-lang.lvt 
* script-no-script.lvt 
* script.lvt 
* strong-fontface.lvt 
* unicode-math.lvt 
* user-alias-feature-option.lvt 
* user-alias-feature.lvt 
* user-new-ot-feature.lvt 
* user-nums-junicode.lvt 
* user-nums-textcomp.lvt 
* user-nums.lvt 
* xetex-mapping-lig.lvt 
* 0-pkg-load.luatex.tlg 
* 0-pkg-load.xetex.tlg 
* 00-pkg-load-babel.luatex.tlg 
* 00-pkg-load-babel.xetex.tlg 
* 00-pkg-load-eu.luatex.tlg 
* 00-pkg-load-eu.xetex.tlg 
* 00-pkg-load-tu.luatex.tlg 
* 00-pkg-load-tu.xetex.tlg 
* 02-pkg-load-predocclass.luatex.tlg 
* 02-pkg-load-predocclass.xetex.tlg 
* aff-group.luatex.tlg 
* aff-group.xetex.tlg 
* aff-italic-only.luatex.tlg 
* aff-italic-only.xetex.tlg 
* aff-numbers.luatex.tlg 
* aff-numbers.xetex.tlg 
* aff-sc-repeated.luatex.tlg 
* aff-sc-repeated.xetex.tlg 
* api-assorted.luatex.tlg 
* api-assorted.xetex.tlg 
* api-font-if-exist.luatex.tlg 
* api-font-if-exist.xetex.tlg 
* api-if-current-feature.luatex.tlg 
* api-if-current-feature.xetex.tlg 
* api-if-feature.luatex.tlg 
* api-if-feature.xetex.tlg 
* api-if-font-feature-active.luatex.tlg 
* api-if-font-feature-active.xetex.tlg 
* api-if-small-caps.luatex.tlg 
* api-if-small-caps.xetex.tlg 
* api-script.luatex.tlg 
* api-script.xetex.tlg 
* api-tag-too-long.luatex.tlg 
* api-tag-too-long.xetex.tlg 
* colour-basic.luatex.tlg 
* colour-basic.xetex.tlg 
* colour-opacity.luatex.tlg 
* colour-opacity.xetex.tlg 
* em-declare.luatex.tlg 
* em-declare.xetex.tlg 
* em-innershape.luatex.tlg 
* em-innershape.xetex.tlg 
* em.luatex.tlg 
* em.xetex.tlg 
* enc-T1-default.luatex.tlg 
* enc-T1-default.xetex.tlg 
* enc-new-enc.luatex.tlg 
* enc-new-enc.xetex.tlg 
* feat-LocalForms.luatex.tlg 
* feat-LocalForms.xetex.tlg 
* feat-hyphenchar.luatex.tlg 
* feat-hyphenchar.xetex.tlg 
* feat-number-multichoice.luatex.tlg 
* feat-number-multichoice.xetex.tlg 
* feat-punctspace.luatex.tlg 
* feat-punctspace.xetex.tlg 
* feat-reset.luatex.tlg 
* feat-reset.xetex.tlg 
* feat-scale-again.luatex.tlg 
* feat-scale-again.xetex.tlg 
* feat-scale-match.luatex.tlg 
* feat-scale-match.xetex.tlg 
* feat-ss06.luatex.tlg 
* feat-ss06.xetex.tlg 
* feat-wordspace.luatex.tlg 
* feat-wordspace.xetex.tlg 
* fontface-overwrite.luatex.tlg 
* fontface-overwrite.xetex.tlg 
* fontface-spaces.luatex.tlg 
* fontface-spaces.xetex.tlg 
* fontload-defaults-adding.luatex.tlg 
* fontload-defaults-adding.xetex.tlg 
* fontload-defaults-change.luatex.tlg 
* fontload-defaults-change.xetex.tlg 
* fontload-defaults.luatex.tlg 
* fontload-defaults.xetex.tlg 
* fontload-fontface-1.luatex.tlg 
* fontload-fontface-1.xetex.tlg 
* fontload-fontface-2-sc.luatex.tlg 
* fontload-fontface-2-sc.xetex.tlg 
* fontload-fontface-3-sizing.luatex.tlg 
* fontload-fontface-3-sizing.xetex.tlg 
* fontload-fontspec-file-case.luatex.tlg 
* fontload-fontspec-file-case.xetex.tlg 
* fontload-fontspec-file.luatex.tlg 
* fontload-fontspec-file.xetex.tlg 
* fontload-mainsans.luatex.tlg 
* fontload-mainsans.xetex.tlg 
* fontload-mathetc.luatex.tlg 
* fontload-mathetc.xetex.tlg 
* fontload-nfssfamily-1.luatex.tlg 
* fontload-nfssfamily-1.xetex.tlg 
* fontload-nfssfamily-2.luatex.tlg 
* fontload-nfssfamily-2.xetex.tlg 
* fontload-onesize-nosc.luatex.tlg 
* fontload-onesize-nosc.xetex.tlg 
* fontload-scfeat-nesting.luatex.tlg 
* fontload-scfeat-nesting.xetex.tlg 
* fontload-sizefeatures-1.luatex.tlg 
* fontload-sizefeatures-1.xetex.tlg 
* fontload-sizefeatures-2-nesting.luatex.tlg 
* fontload-sizefeatures-2-nesting.xetex.tlg 
* fontload-sl-fsfile.luatex.tlg 
* fontload-sl-fsfile.xetex.tlg 
* fontload-sl.luatex.tlg 
* fontload-sl.xetex.tlg 
* fontload-ttc-fontindex.luatex.tlg 
* fontload-ttc-fontindex.xetex.tlg 
* fontload-ttc.luatex.tlg 
* fontload-ttc.xetex.tlg 
* italicfeatures-concat.luatex.tlg 
* italicfeatures-concat.xetex.tlg 
* luatex-subs.luatex.tlg 
* luatex-subs.xetex.tlg 
* mergeshapes.luatex.tlg 
* mergeshapes.xetex.tlg 
* newfontfamily.luatex.tlg 
* newfontfamily.xetex.tlg 
* polyglossia-add-script.luatex.tlg 
* polyglossia-add-script.xetex.tlg 
* polyglossia-cyrl.luatex.tlg 
* polyglossia-cyrl.xetex.tlg 
* primitive-if-exist.luatex.tlg 
* primitive-if-exist.xetex.tlg 
* script-lang-trk.luatex.tlg 
* script-lang-trk.xetex.tlg 
* script-lang.luatex.tlg 
* script-lang.xetex.tlg 
* script-no-script.luatex.tlg 
* script-no-script.xetex.tlg 
* script.luatex.tlg 
* script.xetex.tlg 
* strong-fontface.luatex.tlg 
* strong-fontface.xetex.tlg 
* unicode-math.luatex.tlg 
* unicode-math.xetex.tlg 
* user-alias-feature-option.luatex.tlg 
* user-alias-feature-option.xetex.tlg 
* user-alias-feature.luatex.tlg 
* user-alias-feature.xetex.tlg 
* user-new-ot-feature.luatex.tlg 
* user-new-ot-feature.xetex.tlg 
* user-nums-junicode.luatex.tlg 
* user-nums-junicode.xetex.tlg 
* user-nums-textcomp.luatex.tlg 
* user-nums-textcomp.xetex.tlg 
* user-nums.luatex.tlg 
* user-nums.xetex.tlg 
* xetex-mapping-lig.luatex.tlg 
* xetex-mapping-lig.xetex.tlg 


## TDS manifest

The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.

### Source files (TDS)

All files included in the `fontspec/source` directory.

* fontspec-code-api.dtx 
* fontspec-code-closing.dtx 
* fontspec-code-enc.dtx 
* fontspec-code-feat-aat.dtx 
* fontspec-code-feat-opentype.dtx 
* fontspec-code-fontload.dtx 
* fontspec-code-graphite.dtx 
* fontspec-code-interfaces.dtx 
* fontspec-code-internal.dtx 
* fontspec-code-keyval.dtx 
* fontspec-code-lang.dtx 
* fontspec-code-load.dtx 
* fontspec-code-math.dtx 
* fontspec-code-msg.dtx 
* fontspec-code-opening.dtx 
* fontspec-code-opentype.dtx 
* fontspec-code-scripts.dtx 
* fontspec-code-user.dtx 
* fontspec-code-vars.dtx 
* fontspec-code-xfss.dtx 
* fontspec-code.ltx 
* fontspec-doc-api.tex 
* fontspec-doc-enc.tex 
* fontspec-doc-featset.tex 
* fontspec-doc-fontsel.tex 
* fontspec-doc-intro.tex 
* fontspec-doc-luatex.tex 
* fontspec-doc-opentype.tex 
* fontspec-doc-style.sty 
* fontspec-doc-xetex.tex 
* fontspec-example.tex 
* fontspec-lua.dtx 
* fontspec.dtx 
* fontspec.ins 
* fontspec.ltx 

### TeX files (TDS)

All files included in the `fontspec/tex` directory.

* fontspec-luatex.sty 
* fontspec-xetex.sty 
* fontspec.cfg 
* fontspec.lua 
* fontspec.sty 

### Doc files (TDS)

All files included in the `fontspec/doc` directory.

* CHANGES.md 
* README.md 
* fontspec-code.pdf 
* fontspec-example.tex 
* fontspec.pdf 


## CTAN manifest

The following group lists the files included in the CTAN package.

### CTAN files

* CHANGES.md 
* README.md 
* fontspec-code-api.dtx 
* fontspec-code-closing.dtx 
* fontspec-code-enc.dtx 
* fontspec-code-feat-aat.dtx 
* fontspec-code-feat-opentype.dtx 
* fontspec-code-fontload.dtx 
* fontspec-code-graphite.dtx 
* fontspec-code-interfaces.dtx 
* fontspec-code-internal.dtx 
* fontspec-code-keyval.dtx 
* fontspec-code-lang.dtx 
* fontspec-code-load.dtx 
* fontspec-code-math.dtx 
* fontspec-code-msg.dtx 
* fontspec-code-opening.dtx 
* fontspec-code-opentype.dtx 
* fontspec-code-scripts.dtx 
* fontspec-code-user.dtx 
* fontspec-code-vars.dtx 
* fontspec-code-xfss.dtx 
* fontspec-code.ltx 
* fontspec-code.pdf 
* fontspec-doc-api.tex 
* fontspec-doc-enc.tex 
* fontspec-doc-featset.tex 
* fontspec-doc-fontsel.tex 
* fontspec-doc-intro.tex 
* fontspec-doc-luatex.tex 
* fontspec-doc-opentype.tex 
* fontspec-doc-style.sty 
* fontspec-doc-xetex.tex 
* fontspec-example.tex 
* fontspec-lua.dtx 
* fontspec.cfg 
* fontspec.dtx 
* fontspec.ins 
* fontspec.ltx 
* fontspec.pdf 
