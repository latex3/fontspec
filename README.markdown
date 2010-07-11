
THE FONTSPEC PACKAGE v2.0a
==========================

This is the initial release of the fontspec package with support for LuaTeX.
(Previously, fontspec was XeTeX-only.)

The fontspec package provides an automatic and unified interface for loading
fonts in LaTeX. XeTeX and LuaTeX (the latter through the luaotfload package)
allows a direct interface to fonts which may be loaded by their name rather
than filename, so no manual font installation is required.

This package also provides access to the large number of font features
available with AAT and OpenType fonts, including upper and lower case numbers,
proportional and monospaced numbers, swash letters, ligature control, and many
others.

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

- v2.0a (2010 July 11)  
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


License
-------

Copyright 2004--2010 Will Robertson <wspr81@gmail.com>
Copyright 2009--2010 Khaled Hosny <khaledhosny@eglug.org>

Distributable under the LaTeX Project Public License,
version 1.3c or higher (your choice). The latest version of
this license is at: http://www.latex-project.org/lppl.txt

This work is "maintained" (as per LPPL maintenance status)
by Will Robertson.

