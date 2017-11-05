#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.dtx","*.ltx","*.cfg","fontspec-doc*.tex","fontspec-doc-style.sty"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
typesetfiles = {"*.ltx"}
demofiles    = {"fontspec-example.tex"}

typesetopts = " -shell-escape -interaction=errorstopmode "
unpackopts  = " -interaction=batchmode "

checkengines = {"xetex","luatex"}

typesetexe = "xelatex"

recordstatus = true
packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
