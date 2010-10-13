
THE FONTSPEC PACKAGE
====================

This is the initial generation of the fontspec package with support for
LuaLaTeX. (Previously, fontspec was XeLaTeX-only.)

The fontspec package provides an automatic and unified interface for loading
fonts in LaTeX. XeTeX and LuaTeX (the latter through the luaotfload package)
allows a direct interface to fonts which may be loaded by their name rather
than filename, so no manual font installation is required.

This package also provides access to the large number of font features
available with AAT and OpenType fonts, including upper and lower case numbers,
proportional and monospaced numbers, swash letters, ligature control, and many
others.

See the documentation `fontspec.pdf` for full information.

Release versions of fontspec are available from CTAN:  
  <http://tug.ctan.org/pkg/fontspec>
  
Development and historical versions are available from Github:  
  <http://github.com/wspr/fontspec>
  
Please offer suggestions and file bug reports in the issue tracker:  
  <http://github.com/wspr/fontspec/issues>


LuaTeX requirements
-------------------

TeXLive 2010 is recommended for running this package under LuaTeX.

This package requires the luaotfload package in order to load fonts in LuaTeX.
Version 1.10 or greater is recommended for this release. Please see
instructions in that package for font setup. That package, in turn, requires
a version of LuaTeX greater than that shipped with TeX Live 2009.


Summary of user commands
------------------------

Font families may be selected individually with the command

    \fontspec[<font options>]{<font name>}

Commands for selecting fonts efficiently can be created with

    \newfontfamily\myfamily[<font options>]{<font name>}
    \newfontface\myfont[<font options>]{<font name>}

Default document fonts are selected with

    \setmainfont[<font options>]{<font name>}
    \setsansfont[<font options>]{<font name>}
    \setmonofont[<font options>]{<font name>}

Fonts to be used in maths are defined with

    \setmathrm[<font options>]{<font name>}
    \setmathsf[<font options>]{<font name>}
    \setmathtt[<font options>]{<font name>}
    \setboldmathrm[<font options>]{<font name>}

Features to be used for every subsequently defined font are specified with

    \defaultfontfeatures{<default font options>}

Features may be added to the font currently in use with

    \addfontfeatures{<font options to add>}
    \addfontfeature{<...>} does the same thing

Features not provided for out of the box may be defined with

    \newAATfeature{<feature tag>}{<feature code>}{<selector code>}
    \newICUfeature{<feature tag>}{[+|-]<4 letter feature string>}
    \newfontfeature{<feature tag>}{<arbitrary XeTeX font options>}

Features can be renamed and feature options can be renamed with

    \aliasfontfeature{<current feature>}{<new feature>}
    \aliasfontfeatureoption{<feature>}{<current option>}{<new option>}



Installation
------------

If you are running TeX Live 2010, you can get the latest version
of this package by running

    tlmgr install fontspec

  * * *

If you wish to download the latest release version from CTAN, get
the pre-built TDS package and extract it into your local texmf tree:

    http://mirror.ctan.org/install/macros/latex/contrib/fontspec.tds.zip

  * * *

If you wish to use the latest development version from Github,
either use git to obtain the bleeding edge version with

    git clone git://github.com/wspr/fontspec.git

or if you don't have git you can download it from

    http://github.com/wspr/fontspec/zipball/master

Having obtained the package from Github, run

    tex fontspec.dtx

to extract the source then and move the necessary files into your
local texmf tree. The documentation can be compiled by running

    pdflatex fontspec.dtx

These steps are automated in the Makefile; run

    make install

to compile the documentation and install all necessary files in your
local texmf tree. Depending how your TeX distribution is configured
you may then need to update the filename database with `texhash`.


Test suite
----------

Towards the end of the development process of version 2, we started
to add a test suite to ensure stability with any future changes. The
output of each test is included in the distributed documentation file
`fontspec-testsuite.pdf`.

There aren't many tests yet, but we'll slowly add to them in time.
If you would like to help put some tests together, contributions are
gladly accepted!


Change history
--------------

- v2.1c (2010/10/13)

    * Fix bug when defining bold italic fonts by filename
    * Avoid infinite loop when the Latin script is requested for a font
      that does not contain it. TODO: a suitable fallback script should be
      chosen; right now we just ignore the script selection.

- v2.1b (2010/09/29)

    * Fix for bug introduced in the last release:
      small caps weren't being automatically selected correctly

- v2.1a (2010/09/27)

    * Fix for colours bug introduced in the last update
    * Fix for for bad interaction with LuaLaTeX and fallback fonts
      (such as using \slshape when no slanted font specified)
    * Behaviour/messaging improvement when scripts/languages are requested
      that do not exist in the font
    * Fix bug with detecting font features/scripts in some cases with:

        - `\fontspec_if_feature:n(TF)`
        - `\fontspec_if_language:n(TF)`
        - `\fontspec_if_current_script:n(TF)`
        - `\fontspec_if_current_language:n(TF)`

    * Some messages in the log file are improved
    * Code for "visible space" fixed for LuaLaTeX use
    * Lots of internal changes to bring the implementation closer
      to being "native expl3".

- v2.1 (2010/09/19)
  
    * Now load xunicode internally for consistent behaviour in
      XeLaTeX and LuaLaTeX.
    * Font commands now include \fontencoding internally, easing their
      use together with legacy TeX fonts.
    * Colour & Opacity now behave a little better.
    * Nested emphasis with \emph now also occurs inside a "slanted" shape.
    * Some compatibility commands/options added that were removed.
      in the transition to v2.
    * Bug fix for a problem triggered after counters got too high.

- v2.0c (2010/08/01)  
  Bug fix and documentation tune-up.

    * Significant bug fix reported simultaneously by Enrico Gregorio and
      Don Hosek.
    * Many documentation improvements and additions due to David Perry.
    * Documentation typo thanks to John McChesney-Young

- v2.0b (2010/07/14)  
  *Actually* the final release before TeX Live 2010.

    * Improved examples in the documentation, with fewer proprietary fonts
    * All font examples are included as separate images on CTAN, so the
      manual can be compiled (with pdfLaTeX) by anyone, anywhere
    * LuaLaTeX fixes for the StylisticSet and Annotation features
    * New OpenType feature `CharacterVariant` now supported
    * Minor change: `Ligatures=Historical` is now `Ligatures=Historic` for consistency

- v2.0a (2010/07/11)  
  Final release before TeX Live 2010.
  
    * Bug fix for the Language setting being ignored
    * Add programmer's command `\fontspec_glyph_if_exist:NnTF`
    * Many documentation improvements, especially for LuaTeX features
      `FeatureFile=...` and `Numbers=Arabic`.
    * Add `Parsi` and `Persian` synonyms for `Language=Farsi`

Manifest
--------

Source files:
        fontspec.dtx               single file source & doc for the package
        Makefile                   script for extracting and installing

Derived files:
        fontspec.pdf               documentation
        fontspec.sty               LaTeX style file
        fontspec.lua               Lua functions for LuaTeX
        fontspec-patches.sty       redefinitions of various LaTeX internals
        fontspec.cfg               default configuration file
        fontspec-xetex.tex         example file for XeTeX
        fontspec-luatex.tex        example file for LuaTeX
        fontspec-testsuite.tex     test suite documentation file

Test suite: (within testsuite/)
        testsuite.cls              class file for each test
        testsuite-listing.tex      listing of each test in the suite
        L*.ltx                     LuaLaTeX test file
        X*.ltx                     XeLaTeX test file
        F*.ltx                     Test file for both engines

Documentation sources:
        doc/*.pdf                  These are pre-generated example outputs for 
                                   direct inclusion in the documentation

License
-------

Copyright 2004--2010 Will Robertson <wspr81@gmail.com>
Copyright 2009--2010 Khaled Hosny <khaledhosny@eglug.org>

Distributable under the LaTeX Project Public License,
version 1.3c or higher (your choice). The latest version of
this license is at: http://www.latex-project.org/lppl.txt

This work is "maintained" (as per LPPL maintenance status)
by Will Robertson.

