The FONTSPEC package
====================

The `fontspec` package provides an automatic and unified interface for loading
fonts in LaTeX. XeTeX and LuaTeX (the latter through the `luaotfload` package)
allows a direct interface to fonts which may be loaded by their name or filename,
so no manual font installation is required.

This package also provides access to the large number of font features
available with OpenType (and other) fonts, including upper and lower case numbers,
proportional and monospaced numbers, swash letters, ligature control, and many
many others.

See the documentation `fontspec.pdf` for full information.


Summary of user commands
------------------------

To define commands for selecting fonts efficiently through a document:

    \newfontfamily\<font switch>{<font name>}[<font options>]
    \newfontface  \<font switch>{<font name>}[<font options>]

To select the default document fonts:

    \setmainfont{<font name>}[<font options>]
    \setsansfont{<font name>}[<font options>]
    \setmonofont{<font name>}[<font options>]

To define an ad hoc font family individually:

    \fontspec{<font name>}[<font options>]

To specify features to be used for every subsequently defined font:

    \defaultfontfeatures{<default font options>}
    \defaultfontfeatures+{<add to default font options>}

To specify features to be used for specific fonts:

    \defaultfontfeatures[<font name or switch>]{<default font options>}
    \defaultfontfeatures+[<font name or switch>]{<add to defaults>}

To add features to the font family currently in use:

    \addfontfeatures{<font options to add>}


Package details
---------------

Release versions of fontspec are available from CTAN:
  <http://www.ctan.org/pkg/fontspec>

Development and historical versions are available from Github:
  <http://github.com/wspr/fontspec>

Please offer suggestions and file bug reports in the issue tracker:
  <http://github.com/wspr/fontspec/issues>

If you are running TeX Live, you can update to the latest version of this package by running

    tlmgr install fontspec

If you wish to manually download the latest release version from CTAN, get the pre-built TDS package and extract it into your local texmf tree:

    http://mirror.ctan.org/install/macros/latex/contrib/fontspec.tds.zip

If you wish to use the latest development version from Github, either use git to obtain the bleeding edge version with

    git clone git://github.com/wspr/fontspec.git

(For bleeding edge versions, see the `working` branch.)
Having obtained the package from Github, install the package code by running

    texlua build.lua install

This will compile the documentation and install all necessary files in your
local texmf tree. Depending how your TeX distribution is configured
you may then need to update the filename database with `texhash`.


