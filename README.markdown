
THE FONTSPEC PACKAGE
====================

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


Requirements
------------

The `fontspec` package requires an up-to-date TeX Live 2011 or MiKTeX 2.9,
including the most recent version of the `l3kernel` package which provides
the LaTeX3 programming interface known as `expl3`.


Summary of user commands
------------------------

Font families may be selected individually with the command

    \fontspec[<font options>]{<font name>}

Commands for selecting fonts efficiently through a document are created with

    \newfontfamily\myfamily[<font options>]{<font name>}
    \newfontface\myfont[<font options>]{<font name>}

Default document fonts are selected with

    \setmainfont[<font options>]{<font name>}
    \setsansfont[<font options>]{<font name>}
    \setmonofont[<font options>]{<font name>}

Fonts to be used in text strings in maths are defined with

    \setmathrm[<font options>]{<font name>}
    \setmathsf[<font options>]{<font name>}
    \setmathtt[<font options>]{<font name>}
    \setboldmathrm[<font options>]{<font name>}

Features to be used for every subsequently defined font are specified with

    \defaultfontfeatures{<default font options>}

Features may be added to the font currently in use with

    \addfontfeatures{<font options to add>}
    \addfontfeature{<...>} does the same thing



Change history
--------------

- v2.2b (2012/05/06) "TL2012 version"

    * Fix error with AutoFakeSlant/Bold (#113) and when used with external fonts (#128)
    * Add warning when using FakeBold in LuaLaTeX, where it's not supported
    * Fix slshape misassignment introduced in v2.2
    * Allow fontspec to be loaded before \documentclass
      (or rather fix the regression that broke this)
    * Avoid using the calc package now that it's no longer loaded by expl3
    * Allow multiple values to StylisticSet and Alternate font options

- v2.2a (2011/09/14)

    * Bug fix: improve backwards compatibility for packages that use old
      fontspec internals such as mathspec.

- v2.2  (2011/09/13)

    * Support alternate selections in CharacterVariant (cvxx in OpenType)
      using new syntax `[CharacterVariant=5:2]`.
    * Add `fontspec`-compatible `\oldstylenums` and `\liningnums` commands.
    * New programmer's function `\fontspec_set_fontface:NNnn` (for use when
      `\zf@basefont` might previously have been queried).
    * Log file output is slightly tidier.
    * Some old lingering bugs squashed:
      - Small caps font selection was broken in some cases.
        (Thanks Enrico Gregorio.)
      - Fonts loaded by filename with under-specified shapes threw an error
        (e.g., asking explicitly for bold but not italic).
        (Thanks Vafa Khalighi.)
    * Documentation improvements largely due to Markus Böhning.
    * Many internal changes, among which:
      - `xkeyval` package no longer used for option processing;
        `expl3`'s `l3keys` used instead.
        This allows `fontspec` to be loaded before `\documentclass`
        (thanks Heiko Oberdiek for reporting the issue)
        and fixes a potential conflict with the `preview` package
        (thanks again Vafa).
      - Internal names changed; avoid "\zf@basefont", "\zf@family", etc.
        from now on -- there are public interfaces now to get access to the
        same information
      - Update `expl3` support to latest CTAN version.

- v2.1g (2011/08/02)

    * No longer uses the binhex package, avoiding some name clashes with TIPA

- v2.1f (2011/02/26)

    * Finally add a real error message when a font cannot be found!
    * Add "Letters=Random" feature.
    * Fix bug in which "Unknown feature `'..." warnings
      were shown in the log file.
    * Some small documentation improvements.

- v2.1e (2010/11/17)

    * Internal changes for luatexbase v0.3.

- v2.1d (2010/11/07)

    * Bug fix when \itdefault is "sl" rather than "it".
      E.g., when using the "slides" class.
    * Minor internal changes, including merging some code from unicode-math.

- v2.1c (2010/10/13)

    * New documentation for defining custom kerning and ligatures
      when using LuaLaTeX.
    * Fix bug when defining bold italic fonts by filename.
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

