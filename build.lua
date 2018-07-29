#!/usr/bin/env texlua

module = "fontspec"

sourcefiles  = {"*.ins","*.dtx","*.ltx","*.cfg","*.tex","fontspec-doc-style.sty"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
typesetfiles = {"fontspec.ltx","fontspec-code.ltx"}
demofiles    = {"fontspec-example.tex"}
textfiles    = {"README.md","CHANGES.md","LICENSE"}
tagfiles     = {"fontspec.dtx","CHANGES.md"}

typesetopts = " -shell-escape -interaction=errorstopmode "
unpackopts  = " -interaction=batchmode "

checkengines = {"xetex","luatex"}

typesetexe = "xelatex"

recordstatus = true
packtdszip = true


--[[
     TAGGING
--]]

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
pkgversion = string.match(changeslisting,"## (%S+) %(.-%)")
print('Current version (from first entry in CHANGES.md): '..pkgversion)


function update_tag(file, content, tagname, tagdate)
  local date = string.gsub(tagdate, "%-", "/")

  if string.match(content, "{%d%d%d%d/%d%d/%d%d}%s*{[^}]+}%s*{[^}]+}") then
    print("Found expl3 version line in file: "..file)
    content = content:gsub("{%d%d%d%d/%d%d/%d%d}(%s*){[^}]+}(%s*){([^}]+)}",
    "{"..date.."}%1{"..pkgversion.."}%2{%3}")
  end
  if string.match(content, "\\def\\filedate{%d%d%d%d/%d%d/%d%d}") then
    print("Found filedate line in file: "..file)
    content = content:gsub("\\def\\filedate{[^}]+}", "\\def\\filedate{"..date.."}")
  end
  if string.match(content, "\\def\\fileversion{[^}]+}") then
    print("Found fileversion line in file: "..file)
    content = content:gsub("\\def\\fileversion{[^}]+}", "\\def\\fileversion{"..pkgversion.."}")
  end

  if string.match(content, "## (%S+) %([^)]+%)") then
    print("Found changes line in file: "..file)
    content = content:gsub("## (%S+) %([^)]+%)","## %1 ("..date..")",1)
  end

  return content
end


