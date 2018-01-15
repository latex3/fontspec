
Change history
==============

- v2.6h ()

    * `\fontspec_set_family:Nnn` and `\fontspec_set_fontface:NNnn` are now *global* operations. (Previously the behaviour was undefined.) This creates consistency with how the underlying NSFSS assigns the font families, which was being done globally regardless.

- v2.6g (2017-11-09)

    * Bugfix for clash introduced with last version. When loading `babel`
      before `fontspec` the following error arose:

          ! Control sequence \latinencoding already defined.


- v2.6f (2017-11-05)

    * Fix loading of Graphite fonts and add a little documentation (a better interface is needed, though)
    * Correct and simplify some internal code that fixes a bug in the way some fonts are displayed in `\tracingoutput` mode.
    * This also fixes an obscure bug using the API in which a query for a selected font feature
      would test against the upright font in the current family regardless of the face/shape actually in use.
    * This package now complies with the `expl3` option `check-declarations`.


- v2.6e (2017/09/22)

    * Re-enable use of `HyphenChar=None` in LuaLaTeX. (Hyphenation and font choice are
      decoupled in LuaTeX, except for this one setting.)
    * Some internal changes needed by `unicode-math` to fix some cross-over code.


- v2.6d (2017/08/14)

    * Update Scripts to Unicode 1.8.2 (thanks Werner)
    * Remove `HyphenChar` feature when running LuaTeX — use `\prehyphenchar` LuaTeX primitive instead.
    * Rewrite test suite so that automated testing actually functions correctly and automatically. Thanks to Joseph for introducing me to Travis CI.


- v2.6c (2017/07/23)

    * Emergency bug-fix.


- v2.6b (2017/07/16)

    * Fix conflict with Polyglossia and `Scale=MatchLowercase`.
    * New feature `IgnoreFontspecFile` to avoid loading the `.fontspec` file for a font.
    * Fix regression with `\fontspec_if_feature:nTF`
      (which broke `realscripts`, oops — must improve my test suite)


- v2.6a (2017/03/31)

    * Fix crashing bug with `..Reset` and `ResetAll` keys.
    * Fix crashing bug with `\newfontface`.

- v2.6 (2017/02/12)

    * Change the new behaviour of `\emph` (and `\emfontdeclare`) to act only on the NFSS font shape; using the series as well was too fragile.
    * Add `\strong` as the "weight" analogy to `\emph`. This will need some extra syntactic sugar from `fontspec` before it becomes truly useful.
    * Add `Numbers=Tabular` alias for `Numbers=Monospaced`.
    * Fix occasional bug with "chained" keyval choices such as `Numbers={Lining,Proportional}` in which only the first choice would be recognised.
    * Fix interaction with `RawFeature` and "proper" `fontspec` features.
    * Fix regression in which `C:\...` file paths in Windows couldn't be used.
    * Fix regression in XeTeX in which `Ligatures=TeX` overrode `Mapping=..` regardless of where the former was declared in the feature list.
    * Fix bug (sorry!) in `\newopentypefeature`.
    * Improve monospace font in documentation.

    * N.B. There is currently a known issue with TTC fonts and LuaTeX; currently they cannot be loaded through the `fontspec` interface, but this issue should soon be addressed by the `luaotfload` package.

- v2.5d (2017/01/24) "oops"

    * Add `\fontspec_if_small_caps:TF`
    * Fix bug in `\emph` (!!)

- v2.5c (2017/01/20) "Christmas 2016 release"

    * `TU` font encoding now default, with encoding files provided by the kernel.
    * Experimental interface added for customising encodings.
    * Add feature `Ornament=`*n* corresponding to OpenType feature `+ornm=`*n*.
    * Add feature `FontIndex=`*n* to support TrueType Collection (TTC) files.
    * Nested `\emph` is now much smarter and will cleverly nest even if manual font changes are made.
    * Tries to resolve situations when font features clash.
      E.g., `Numbers={Uppercase,Lowercase}` will define only `+onum` rather than the previous behaviour of `+lnum;+onum` to let the engine sort things out. Coverage may still be preliminary.
    * Add API function `\fontspec_if_current_feature:nTF` for querying selected features based on their OpenType tag.
    * Add user function `\IfFontFeatureActiveTF` for querying selected features based on their `fontspec` specification.
    * All "tag-based" OpenType features are now provided in `Feat`/`FeatOff`/`FeatReset` forms to disable and reset them.
    * `ResetAll` provided for all "tag-based" OpenType feature keys. (E.g., `Ligatures=ResetAll`.)
    * Big table of OpenType feature tags to help cross-reference which fontspec feature (if any) corresponds to which OpenType feature.
    * Bug fixed for `Script` selection.

- v2.5b (2016/05/14) "More bugs" (somehow never released)

    * Fixed bug with garbage text printed in certain "verbatim" situations under LuaTeX.
    * Improve interaction between optical sizes and small caps.
    * Remove documentation for `FeatureFile`, since this is no longer supported under LuaLaTeX
      (there are other methods to perform the same thing, but no "easy" user interface that `fontspec` can provide at this stage).
    * Fix regression causing an error message if `fontspec` loaded before `\documentclass'.

- v2.5a (2016/02/01) "Bugs fixed"

    * Rather embarrassing bug fix! (`unicode-math` was broken.)
    * Remember to add the `fontspec.cfg` file to the distribution.
    * Remove `+trep` from `Ligatures=TeX` (no longer necessary).
    * Add some basic tests using `l3build`; more to come.
    * Simplify some internal Lua code and package loading code.

- v2.5 (2016/01/30) "TL2016 release"

    * Provide a new Unicode font encoding ("TU") to replace EU1/EU2 and xunicode.
    * Activate with package option `[tuenc]'; once it becomes the default (later this year), `[euenc]` option will revert to the old behaviour.
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
