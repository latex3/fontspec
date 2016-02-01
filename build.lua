#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.dtx","*.fd","*.def","fontspec-doc.tex","*.cfg"}
unpackfiles  = {"fontspec.dtx"}
installfiles = {"*.sty","fontspec.lua","*.fd","*.def","*.cfg"}
typesetfiles = {"fontspec.dtx"}
typesetsuppfiles = {"doc-files/"}
demofiles    = {"fontspec-example.tex"}

checkopts   = " -interaction=errorstopmode -halt-on-error "
typesetopts = " -shell-escape -interaction=errorstopmode "

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
