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


