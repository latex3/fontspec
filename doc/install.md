
Manual package installation
---------------------------

If you are running TeX Live, you can update to the latest version of this package by running

    tlmgr install fontspec

If you wish to manually download the latest release version from CTAN, get the pre-built TDS package and extract it into your local texmf tree:

    http://mirror.ctan.org/install/macros/latex/contrib/fontspec.tds.zip

If you wish to use the latest development version from Github, use git to obtain the latest repository code with

    git clone git://github.com/latex3/fontspec.git

See the `develop` branch for changes that have not been released to CTAN yet (no guarantees the code in that branch will always be fully functional). Having obtained the package from Github, install the package code by running

    l3build install

This will compile the documentation and install all necessary files in your
local texmf tree. Depending how your TeX distribution is configured
you may then need to update the filename database with `texhash`.
