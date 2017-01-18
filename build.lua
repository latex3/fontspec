#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.dtx","*.fd","*.def","*.cfg","fontspec-doc*"}
unpackfiles  = {"fontspec.dtx"}
installfiles = {"*.sty","fontspec.lua","*.fd","*.def","*.cfg"}
typesetfiles = {"fontspec.dtx"}
demofiles    = {"fontspec-example.tex"}

typesetopts = " -shell-escape -interaction=errorstopmode "
unpackopts  = " -interaction=batchmode"

checkengines = {"xetex","luatex"}

typesetexe = "xelatex"

packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
