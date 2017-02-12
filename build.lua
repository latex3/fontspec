#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.dtx","*.fd","*.def","*.cfg","fontspec-doc*.tex","fontspec-doc-style.sty"}
unpackfiles  = {"fontspec.dtx"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
typesetfiles = {"fontspec.dtx"}
demofiles    = {"fontspec-example.tex"}

typesetopts = " -shell-escape -interaction=errorstopmode "
unpackopts  = " -interaction=batchmode"

checkengines = {"xetex","luatex"}

typesetexe = "xelatex"

packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
