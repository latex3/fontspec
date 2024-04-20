
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


