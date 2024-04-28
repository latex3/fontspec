Development notes
=================

This package uses l3build as a build system.

## File structure

This package uses l3doc in a literate programming style to generate the LaTeX package files

* fontspec.sty,
* fontspec-luatex.sty, and
* fontspec-xetex.sty,

from the series of `fontspec-code-*.dtx` files in the base directory. These files are also typeset to PDF with the driver file `fontspec-code.ltx`

Likewise, the package documentation is contained within the `fontspec-doc-*.tex` files which are typeset with `fontspec.ltx`.

The PDF documentation are built using

    l3build doc


## Dependencies

To typeset the documentation and run the test suite, a number of TeX Live packages are assumed to be installed. 

These are listed in the file [`.github/tl_packages`](https://github.com/latex3/fontspec/blob/develop/.github/tl_packages).

There are (significantly) more dependencies for building the package compared with installing and running it.


## Test and doc fonts

A separate repository is used to store freely available fonts used for the test suite and documentation build:

<https://github.com/wspr/fontspec-test-fonts>

The build system will automatically pull and access these fonts. You may wish to manually do so if you prefer to compile documentation manually:

    git clone https://github.com/wspr/fontspec-test-fonts.git
    cd fontspec-test-fonts
    sh install.sh

The results of the installation will be echoed to the terminal so you can see what is happening.


## Test suite

The fontspec package runs in two differing engines (XeTeX and LuaTeX). For the most part these engines produce distinct log files, so each fontspec test produces two output files. 

    l3build save <test name>
    l3build save -e luatex <test name>

After changes to the package are made, they can be checked in both engines with

    l3build check <test name>

When running all test files, I often like to use

    l3build check --shuffle --halt

This set of options randomises the order of the tests and stops after the first failure. 

