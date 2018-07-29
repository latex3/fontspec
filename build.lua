#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.ins","*.dtx","*.ltx","*.cfg","*.tex","fontspec-doc-style.sty"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
typesetfiles = {"fontspec.ltx","fontspec-code.ltx"}
demofiles    = {"fontspec-example.tex"}
textfiles    = {"README.md","CHANGES.md"}

typesetopts = " -shell-escape -interaction=errorstopmode "
unpackopts  = " -interaction=batchmode "

checkengines = {"xetex","luatex"}

typesetexe = "xelatex"

recordstatus = true
packtdszip = true
