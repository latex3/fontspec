#!/usr/bin/env texlua

module = "fontspec"

--[================[
      PARAMETERS
--]================]

sourcefiles  = {"*.ins","*.dtx","*.ltx","*.cfg","*.tex","fontspec-doc-style.sty"}
installfiles = {"fontspec.sty","fontspec-xetex.sty","fontspec-luatex.sty","fontspec.lua","fontspec.cfg"}
demofiles    = {"fontspec-example.tex"}
textfiles    = {"README.md","doc/CHANGES.md","LICENSE"}
tagfiles     = {"fontspec.dtx","doc/CHANGES.md"}

typesetfiles = {"fontspec.ltx","fontspec-code.ltx"}
typesetexe   = "xelatex"
typesetopts  = " -shell-escape -interaction=errorstopmode "

unpackopts  = " -interaction=batchmode "

checkengines = {"xetex","luatex"}
recordstatus = true

packtdszip = true

checksuppfiles = {"texmf.cnf"}

--[===[
   DEV
--]===]

function os.capture(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

gitbranch = os.capture('git rev-parse --abbrev-ref HEAD')
specialformats = specialformats or {}
if os.getenv'TEST_DEV_FORMATS' then
  specialformats.latex = {
    xetex  = {binary = "xetex",    format = "xelatex-dev"},
    luatex = {binary = "luahbtex", format = "lualatex-dev"},
  }
end

--[=============[
      VERSION
--]=============]

changeslisting = nil
do
  local f = assert(io.open("doc/CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
pkgversion = string.match(changeslisting,"## v(%S+) %(.-%)")
gittag = 'v'..pkgversion

print('Current version (from first entry in CHANGES.md): '..pkgversion)



--[============[
     TAGGING
--]============]

function update_tag(file, content, tagname, tagdate)
  check_status()

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


status_bool = false

function check_status()
  if status_bool then
    return true
  end

  local handle = io.popen('git status --porcelain --untracked-files=no')
  local gitstatus = string.gsub(handle:read("*a"),'%s*$','')
  handle:close()
  if gitstatus=="" then
    print("Checking git status: clean")
    status_bool = true
    return status_bool
  else
    print("ABORTING, git status is not clean:")
    print(gitstatus)
    status_bool = false
    return status_bool
  end
end

--[=================[
  Fetching / updating test font repository
--]=================]

local function ensure_test_fonts()
  local repo_mode = lfs.attributes('fontspec-test-fonts', 'mode')
  if repo_mode == nil then
    assert(os.execute'git clone --depth 1 https://github.com/wspr/fontspec-test-fonts fontspec-test-fonts')
  elseif repo_mode == 'directory' then
    assert(os.execute'git -C fontspec-test-fonts pull --ff-only')
  else
    error'Unexpected mode of fontspec-test-fonts'
  end
end
ensure_test_fonts()

--[=================[
      CTAN UPLOAD
--]=================]

uploadconfig = {
  version     = pkgversion,
  author      = "Will Robertson",
  license     = "lppl1.3c",
  summary     = "Advanced font selection in XeLaTeX and LuaLaTeX",
  ctanPath    = "/macros/unicodetex/latex/fontspec",
  repository  = "https://github.com/latex3/fontspec/",
  bugtracker  = "https://github.com/latex3/fontspec/issues",
}

local function prequire(m) -- from: https://stackoverflow.com/a/17878208
  local ok, err = pcall(require, m)
  if not ok then return nil, err end
  return err
end

prequire("l3build-wspr.lua")


