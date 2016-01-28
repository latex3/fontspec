#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.dtx","doc-files/*"}
unpackfiles  = {"fontspec.dtx"}
installfiles = {"*.sty","fontspec.lua","*.fd","*.def"}
typesetfiles = {"fontspec.dtx"}
typesetsuppfiles = {"doc-files/"}
docfiles     = {"fontspec-doc.tex","doc-files/*"}
demofiles    = {"fontspec-example.tex"}

checkopts   = " -interaction=errorstopmode -halt-on-error "
typesetopts = " -shell-escape -interaction=errorstopmode "

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
