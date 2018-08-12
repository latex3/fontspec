#!/usr/bin/env texlua

module = "fontspec"

--[[
      PARAMETERS
--]]

sourcefiles  = {"*.ins","*.dtx","*.ltx","*.cfg","*.tex","fontspec-doc-style.sty"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
demofiles    = {"fontspec-example.tex"}
textfiles    = {"README.md","CHANGES.md","LICENSE"}
tagfiles     = {"fontspec.dtx","CHANGES.md"}

typesetfiles = {"fontspec.ltx","fontspec-code.ltx"}
typesetexe   = "xelatex"
typesetopts  = " -shell-escape -interaction=errorstopmode "

unpackopts  = " -interaction=batchmode "

checkengines = {"xetex","luatex"}
recordstatus = true

packtdszip = true


--[[
      VERSION
--]]

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
pkgversion = string.match(changeslisting,"## v(%S+) %(.-%)")
print('Current version (from first entry in CHANGES.md): '..pkgversion)



--[[
     TAGGING
--]]

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
  content = content:gsub("version       = \"[^\"]+\",", "version       = \""..pkgversion.."\",")
  content = content:gsub("date          = \"[^\"]+\",", "date          = \""..date.."\",")

  if string.match(content, "## (%S+) %([^)]+%)") then
    print("Found changes line in file: "..file)
    content = content:gsub("## (%S+) %([^)]+%)","## %1 ("..date..")",1)
  end

  return content
end



--[[
     CTAN UPLOAD
--]]

-- ctan upload settings
ctan_pkg     = module
ctan_version = pkgversion
ctan_author  = "Will Robertson"

local handle = io.popen('git config user.email')
ctan_email = string.gsub(handle:read("*a"),'%s*$','')
handle:close()

ctan_uploader = ctan_author
ctan_ctanPath = [[]]
ctan_license  = "lppl"

-- ctan_sumary  is mandatory: not setting it will trigger interaction

ctan_announcement='ask'  -- this is optional: setting it to "ask" forces interaction

ctan_update=true

ctan_note=[[
This has been uploaded automatically using l3build.
Please let me know if there seems to be anything amiss -- and apologies if so!
]]

ctan_file = module..".zip"
ctanupload="ask"
