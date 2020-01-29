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
  ./install-tl --profile=../testsetup/texlive.profile

  cd ..
fi

# make sure tlmgr is up to date
tlmgr update --self

# l3build itself and LuaTeX: need for texlua
tlmgr install l3build luatex texlive-scripts

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
  iftex         \
  luaotfload    \
  oberdiek      \
  ltxcmds       \
  kvsetkeys     \
  ucharcat      \
  filehook      \
  xcolor        \
  babel         \
  babel-english \
  unicode-math  \
  polyglossia   \
  hyph-utf8     \
  epstopdf-pkg  \
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
  cm-unicode    \
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
  inconsolata \
  kurier      \
  microtype   \
  oberdiek    \
  psnfss      \
  standalone  \
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

