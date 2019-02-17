#!/usr/bin/env sh

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# As such, the nature of the system is hard-coded
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached verson of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive.profile

  cd ..
fi

# l3build itself and LuaTeX: need for texlua
tlmgr install l3build luatex

# Required to build plain and LaTeX formats:
# TeX90 plain for unpacking
tlmgr install cm etex knuth-lib latex-bin tex tex-ini-files unicode-data \
  xetex

# Dependencies
tlmgr install   \
  geometry      \
  graphics      \
  graphics-def  \
  luatexbase    \
  ctablestack   \
  ifluatex      \
  ifxetex       \
  luaotfload    \
  oberdiek      \
  ucharcat      \
  filehook      \
  xcolor        \
  babel         \
  babel-english \
  unicode-math  \
  polyglossia   \
  hyph-utf8     \
  mathspec

# Fonts
tlmgr install   \
  sourcecodepro \
  Asana-Math    \
  lm-math       \
  ebgaramond    \
  tex-gyre      \
  tex-gyre-math \
  gfsporson     \
  libertine     \
  stix2-otf     \
  fira          \
  tempora       \
  fandol

# for docs
tlmgr install \
  amsmath     \
  booktabs    \
  caption     \
  colortbl    \
  csquotes    \
  docmute     \
  enumitem    \
  fancyvrb    \
  framed      \
  hyperref    \
  microtype   \
  oberdiek    \
  psnfss      \
  symbol      \
  tocloft     \
  tools       \
  underscore  \
  url         \
  varwidth    \
  zapfding

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install

ls -la /tmp/fontspec-test-fonts

# Install custom fontspec fonts
if [ -d "/tmp/fontspec-test-fonts/.git" ]; then
  cd /tmp/fontspec-test-fonts ;
  git pull --rebase ;
  cd -;
else
  git clone https://github.com/wspr/fontspec-test-fonts.git /tmp/fontspec-test-fonts ;
fi

sh /tmp/fontspec-test-fonts/install.sh
