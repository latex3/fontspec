THE FONTSPEC PACKAGE v2.5a
==========================

The fontspec package provides an automatic and unified interface for loading
fonts in LaTeX. XeTeX and LuaTeX (the latter through the `luaotfload` package)
allows a direct interface to fonts which may be loaded by their name rather
than filename, so no manual font installation is required.

This package also provides access to the large number of font features
available with AAT and OpenType fonts, including upper and lower case numbers,
proportional and monospaced numbers, swash letters, ligature control, and many
others.

See the documentation `fontspec.pdf` for full information.

Release versions of fontspec are available from CTAN:
  <http://www.ctan.org/pkg/fontspec>

Development and historical versions are available from Github:
  <http://github.com/wspr/fontspec>

Please offer suggestions and file bug reports in the issue tracker:
  <http://github.com/wspr/fontspec/issues>


Table of Contents
-----------------

* Summary of user commands
* Change history ("what's new?")
* Installation instructions
* License details


Summary of user commands
------------------------

Font families may be selected individually with the command

    \fontspec{<font name>}[<font options>]

Commands for selecting fonts efficiently through a document are created with

    \newfontfamily\myfamily{<font name>}[<font options>]
    \newfontface\myfont{<font name>}[<font options>]

Default document fonts are selected with

    \setmainfont{<font name>}[<font options>]
    \setsansfont{<font name>}[<font options>]
    \setmonofont{<font name>}[<font options>]

Features to be used for every subsequently defined font are specified with

    \defaultfontfeatures{<default font options>}
    \defaultfontfeatures+{<add to default font options>}
    \defaultfontfeatures[<font name>]{<default font options for "font name">}
    \defaultfontfeatures+[<font name>]{<add to default font options for "font name">}

Features may be added to the font currently in use with

    \addfontfeatures{<font options to add>}
    \addfontfeature{<...>} does the same thing



Change history
--------------

- v2.5a (2016/02/01) "bugs fixed"

    * Rather embarrassing bug fix! (`unicode-math` was broken.)
    * Remember to add the `fontspec.cfg` file to the distribution.
    * Remove `+trep` from `Ligatures=TeX` (no longer necessary).
    * Add some basic tests using `l3build`; more to come.
    * Simplify some internal Lua code and package loading code.

- v2.5 (2016/01/30) "TL2016 release"

    * Provide a new Unicode font encoding ("TU") to replace EU1/EU2 and xunicode. If this causes problems, load fontspec with the `[euenc]` option to revert to the old behaviour.
    * New command `\emfontdeclare` for defining font shapes when arbitrarily nesting the `\emph` command.
    * Allow slanted small caps and better internal methods for "combining" font shapes; this fixes a few bugs.
    * Incorporate "new" font script tags for Indic fonts. E.g., when selecting `Script=Bengali`, fontspec will first query the font for the `bng2` OpenType script, and if not found select `beng`.
    * Restrict some font features from being able to be used within `\addfontfeatures` that were causing some font-loading confusion.
    * Fixed behaviour in which `\baselineskip` and `\f@size` would (possibly) change values after loading the packge.
    * Remove copy of `fixltx2e`'s code for footnote symbols; handled by LaTeX2e now.
    * Deprecate `ExternalLocation` for the simpler (and identical) `Path` option.
    * Improvement to some warnings/info messages.
    * Improve structure of code.

- v2.4e (2015/09/24)

    * Allow `[Path=...]` to be specified for individual font faces.
    * Continue to normalise naming with expl3. (Ongoing.)

- v2.4d (2015/07/22)

    * Rename an internal expl3 function or two.

- v2.4c (2015/03/14)

    * v2.4b was never released, sorry!
    * This time *really* fix `\@fnsymbol` and avoid overwriting it if already fixed.
    * Fix "`Renderer=Graphite`" (off-by-one error).
    * Fix some edge cases for `\aliasfontfeature`.

- v2.4b (2014/08/23)

    * Improve backwards compatibility w.r.t. recent argument order change;
      specifically, if an optional argument is presented before the font name
      then avoid looking for one afterwards.
    * Fix \@fnsymbol; it was defined as a \protected macro, where in fact its internal text-or-math switch needed to be instead.
    * No longer lowercase fontnames internally; this fixes a bug with loading
      mixed-case ".fontspec" files.
    * Fixed some documentation typos/inconsistencies related to recent changes.

- v2.4a (2014/06/21)

    * No longer load fixltx2e.sty -- this package should really be loaded before \documentclass.
    * Avoid deprecated l3fp code.
    * A couple of bugs introduced with v2.4 fixed.

- v2.4 (2014/06/01)

    * Significant change to the user interface: instead of `\setmainfont[features]{font}`, you now write `\setmainfont{font}[features]`.
      Backwards compatibility is of course preserved.

      The reason for this change is to improve the visual comprehension of the font loading syntax with large numbers of font features.

    * Defaults for symbolic font families like this can now be specified with

            \defaultfontfeatures[\rmfamily]{...}

      or

            \defaultfontfeatures[\headingsfont]{...}
            \newfontfamily\headingsfont{...}

    * New `PunctuationSpace=WordSpace` and `PunctuationSpace=TwiceWordSpace` settings, intended for monospaced fonts; these force the space after a period to be exactly one or two spaces wide, respectively, which preserves character alignment across lines.

    * The features above now allow changes to the default settings:

      * `Ligatures=TeX` is enabled by default with `\setmainfont` and `\setsansfont`.
      * `WordSpace={1,0,0}` and `PunctuationSpace=WordSpace` are now enabled by default for `\setmonofont` to produce better monospaced results.
      * (These can be adjusted by created your own `fontspec.cfg` file.)

    * `SizeFeatures` can now be nested inside `ItalicFeatures` (etc.) and behaves correctly. This has been a very long overdue bug!

    * New feature `NFSSFamily=ABC` to set the NFSS family of a font to “`ABC`”. Useful
      when other packages use the `\fontfamily{ABC}\selectfont` interface.

    * New feature `FontFace = {series}{shape}{font}` allows a font face to be loaded with a specific NFSS font series and font shape.
      A more verbose syntax allows arbitrary font features as well (and this also plays nicely with `SizeFeatures`):

            \fontspec{myfont.otf}[
              FontFace = {b}{ui}{Font = myfont-bui.otf, <features>} ,
            ]

      The code above, for example, will allow a bold upright italic font to be selected using the standard NFSS interface: `\fontseries{b}\fontshape{ui}\selectfont`.

    * `\defaultfontfeatures+` (note the `+`) can now be used to append to the default font feature set.

    * Setting the `SmallCapsFont` using the `*`-replacement notation has been improved/fixed.

- v2.3c (2013/05/20)

    * Compatbility with luaotfload 2013/05/20 2.2c, support for older version
      removed.

- v2.3b (2013/05/12)

    * Compatibility with new (and future) version of luaotfload

- v2.3a (2013/03/16)

    * Bug fix update to retain compatibility with new expl3

- v2.3 (2013/02/25)

    * Add support for per-font options in `\defaultfontfeatures`
    * Add support for `<fontname>.fontspec` per-font configuration files
    * Keep up-to-date with expl3 changes

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

If you are running TeX Live, you can get the latest version of this package by running

    tlmgr install fontspec

If you wish to download the latest release version from CTAN, get the pre-built TDS package and extract it into your local texmf tree:

    http://mirror.ctan.org/install/macros/latex/contrib/fontspec.tds.zip

If you wish to use the latest development version from Github, either use git to obtain the bleeding edge version with

    git clone git://github.com/wspr/fontspec.git

or if you don't have git you can download it from

    http://github.com/wspr/fontspec/zipball/master

Having obtained the package from Github, extract the package code by running

    tex fontspec.dtx

and then move the necessary files into your local texmf tree.
The documentation can be compiled by running

    xelatex -shell-escape fontspec.dtx

These steps are automated in the Makefile; run

    texlua build.lua install

to compile the documentation and install all necessary files in your
local texmf tree. Depending how your TeX distribution is configured
you may then need to update the filename database with `texhash`.


License
-------

Copyright 2004--2016 Will Robertson <wspr81@gmail.com>
Copyright 2009--2010 Khaled Hosny <khaledhosny@eglug.org>

Distributable under the LaTeX Project Public License,
version 1.3c or higher (your choice). The latest version of
this license is at: http://www.latex-project.org/lppl.txt

This work is "maintained" (as per LPPL maintenance status)
by Will Robertson.

