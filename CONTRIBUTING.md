# Guidelines for issues and pull requests

## Issues

Thanks for taking the time to report an issue!
Any apologies that I take longer, sometimes *way longer*, than I should to address them.

There are two important key points for submitting an issue:

* When submitting an issue, please include a *complete* minimal example.
* When loading fonts, please do so by *filename* only, where possible.
* If you are using a proprietary/unusual font, please try a font in TeX Live to see
  if it exhibits the same behaviour; it's obviously much harder for me to test with fonts
  I don't yet have or can't access.

For example, this is a good minimal example:

    \documentclass{article}
    \usepackage{fontspec}
    \setmainfont{texgyrepagella-regular.otf}
    \begin{document}
    Hello
    \end{document}

This is an example of a *bad* example:

    \setmainfont{TeX Gyre Pagella}

    % later:
    Hello


## Branches and Pull Requests

There are two main branches in this repository: `master` and `working`.
Development happens on the `working` branch; once a release is sent to CTAN,
the `master` branch is rebased to bring it up to date.

The `working` branch should be considered only semi-public; it may have broken
code and/or use force-pushing to rewrite history on occasions.

If you wish to make a contribution, please start from the `master` branch.

If you are changing documentation only (i.e., no code changes), you can add
`[ci skip]` to the commit message and the test suite won't be run to check that
the changes haven't broken anything.


## Copyright

Copyright statements in most package files are updated en masse by the bash script
`update-copyright.sh` using the file COPYRIGHT as a template.
(The updating script has been tested on macOS only.)

Contributors are listed in the copyright statement if they have more than one
entry in the following list:

    git log --all --date=short --format='%cN %ad'  | sed 's/\(.*[0-9]*\)-[0-9]*-[0-9]*/\1/' | sort -u

Contributors are added to the COPYRIGHT file manually, so please prompt if you would like to be added.
If you have contributed but your name doesn't appear in that list, you might need to check your Git setup.
