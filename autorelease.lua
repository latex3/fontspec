#!/usr/bin/env texlua

--[==========================================[--

     AUTOMATON for performing CTAN releases
     ======================================

     * Save the `main` branch for releases only; this allows hotfixes to releases to be 
       organised easily with a minimal number of branches to keep things simple. 
     * Changes over time go into the `develop` branch.
     * Records of changes which deserve to be included in the release notes should be added
       CHANGES.md. Follow the formatting of the file.
     * The topmost entry of CHANGES.md is used to populate the new version number
       (but the date will be updated automatically by the build script).
     * The topmost entry of the CHANGES.md file is extracted and used in the git tagging
       and in the CTAN release notes.
     * To commence a release, be in the `develop` branch, fully committed.
     * This file will query a couple of times to make sure all is well.
     * If so, it sends the package off to CTAN and the `main` branch is rebased and tagged.
     * TODO: add Github release zip file as well.

--]==========================================]--


--[=============[--
     FUNCTIONS
--]=============]--

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function exe(s)
  print('=====================')
  print('> '..s..'\n')
  local e = os.execute(s)
  if not(e) then
    error("EXECUTION FAILED: ABORT")
  end
end

function usercheck()
  print("\nHappy? [y/n]")
  ans = io.read()
  if not(string.lower(ans,1,1)=="y") then
    error("USER ABORTED")
  end
end

--[==================[--
     INITIAL CHECKS
--]==================]--

reqbranch = "develop"
gitbranch = os.capture('git symbolic-ref --short HEAD')
if gitbranch ~= reqbranch then
  print("Current git branch: "..gitbranch)
  error("You must be on the '"..reqbranch.."' branch")
else
  print("Current git branch: "..gitbranch.." ... correct!")
end

gitstatus = os.capture('git status --porcelain')
if gitstatus ~= "" then
  error("Files have been edited; please commit all changes.")
end

--[=========================[--
     MOVE TO MAIN BRANCH
--]=========================]--

exe("git fetch")

aheadmaybe = os.capture('git branch -vv | grep `git symbolic-ref --short HEAD` | grep ahead')
if aheadmaybe ~= "" then
  exe("git push")
end

exe("git checkout main")
exe("git pull")
exe("git rebase develop")

--[=====================[--
     CLEAN UP
--]=====================]--

gitclean = os.capture('git clean -nx')
if gitclean ~= "" then
  print("Before we start, the following files are about to be deleted. Please check.")
  exe('git clean -nx')
  usercheck()
end

exe("git clean -fx")

--[===============[--
     UPDATE DATE
--]===============]--

exe("l3build tag")

gitstatus = os.capture('git status --porcelain')
if gitstatus ~= "" then
  exe([===[
git commit -a -m 'update package info for release';
      ]===])
end

--[=====================[--
     START THE RELEASE
--]=====================]--

changeslisting = nil
do
  local f = assert(io.open("doc/CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
currentchanges = string.match(changeslisting,"(## %S+ %(.-%).-)%s*## %S+ %(.-%)")
if string.len(currentchanges) > 8192 then
  local trunctext = "[...and more; see package for full details.]"
  currentchanges = string.sub(currentchanges,1,8192-string.len(trunctext)-1) .. trunctext
end

print("***************************")
print("  CURRENT CHANGES          ")
print("***************************")
print(currentchanges)
print("***************************")

pkgversion = string.match(currentchanges,"## (%S+) %(.-%)")
print('    New version: '..pkgversion)

oldversion = os.capture('git describe $(git rev-list --tags --max-count=1)')
print('Most recent tag: '..oldversion)

usercheck()

--[=================[--
     BUILD and TAG
--]=================]--

exe("l3build ctan")

do
  local f = assert(io.open("CHANGES-NEW.md", "w"))
  f:write(currentchanges)
  f:close()
end

exe("git tag -a '"..pkgversion.."' -F CHANGES-NEW.md")

--[=======================[--
     UPLOAD and CLEAN UP
--]=======================]--

exe("l3build upload --file CHANGES-NEW.md")

exe("rm CHANGES-NEW.md")

exe("git push")
exe("git checkout develop")
exe("git rebase main")
exe("git push")

exe("rm fontspec-ctan.curlopt")

print("Great success! Now time to fix some more bugs.")
