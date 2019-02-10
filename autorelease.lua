#!/usr/bin/env texlua

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
  if e > 0 then
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

gitbranch = os.capture('git symbolic-ref --short HEAD')
if gitbranch ~= "working" then
  print("Current git branch: "..gitbranch)
  error("You must be on the 'working' branch")
else
  print("Current git branch: "..gitbranch.." ... correct!")
end

gitstatus = os.capture('git status --porcelain')
if gitstatus ~= "" then
  error("Files have been edited; please commit all changes.")
end

--[=========[
     START
--]=========]

exe("git fetch")

aheadmaybe = os.capture('git branch -vv | grep `git symbolic-ref --short HEAD` | grep ahead')
if aheadmaybe ~= "" then
  exe("git push")
end

exe("git checkout master")
exe("git pull")
exe("git rebase working")

print("***************************")
print("  REVIEW THE FOLLOWING     ")
print("***************************")

travis = os.capture("travis status")
print("Travis status: "..travis)

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
currentchanges = string.match(changeslisting,"(## %S+ %(.-%).-)%s*## %S+ %(.-%)")

print("***************************")
print("  CURRENT CHANGES          ")
print("***************************")
print(currentchanges)
print("***************************")

pkgversion = string.match(currentchanges,"## (%S+) %(.-%)")
print('New version: '..pkgversion)

print('Current tag:')
os.execute('git tag --contains | head -n1')

usercheck()

gitclean = os.capture('git clean -nx')
if gitclean ~= "" then
  print("Before we start, the following files are about to be deleted. Please check.")
  exe('git clean -nx')
  usercheck()
end

--[============[
     CONTINUE
--]============]

exe("git clean -fx")

exe("l3build tag foo")

gitstatus = os.capture('git status --porcelain')
if gitstatus ~= "" then
  exe([===[
git commit -a -m 'update package info for release

[ci-skip]';
      ]===])
end

exe("l3build ctan")

--[===========[
     TAGGING
--]===========]

do
  local f = assert(io.open("CHANGES-NEW.md", "w"))
  f:write(currentchanges)
  f:close()
end

exe("git tag -a '"..pkgversion.."' -F CHANGES-NEW.md")

--[=======================[
     UPLOAD and CLEAN UP
--]=======================]

exe("l3build upload --file CHANGES-NEW.md")

exe("rm CHANGES-NEW.md")

exe("git push")
exe("git checkout working")
exe("git rebase master")
exe("git push")

print("Great success! Now time to fix some more bugs.")
