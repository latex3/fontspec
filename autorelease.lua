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
    error("ABORT")
  end
end

function usercheck()
  print("Happy? [y/n]")
  ans = io.read()
  if not(string.lower(ans,1,1)=="y") then
    error("USER ABORTED")
  end
end

gitbranch = os.capture('git symbolic-ref --short HEAD')
print("Current git branch: "..gitbranch)
if gitbranch ~= "working" then
  error("You must be on the 'working' branch")
end

--[=========[
     START
--]=========]

aheadmaybe = os.capture('git branch -vv | grep `git symbolic-ref --short HEAD` | grep ahead')
if aheadmaybe ~= "" then
  exe("git push")
end

exe("git checkout master")
exe("git pull")
exe("git rebase working")

print("\n\n\n")
print("**************************")
print("** REVIEW THE FOLLOWING **")
print("**************************")

travis = os.capture("travis status")
print("Travis status: "..travis)

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
currentchanges = string.match(changeslisting,"(## %S+ %(.-%).-)%s*## %S+ %(.-%)")

print("******************")
print(currentchanges)
print("******************")

pkgversion = string.match(currentchanges,"## (%S+) %(.-%)")
print('New version: '..pkgversion)

print('Current tag:')
os.execute('git tag --contains | head -n1')

usercheck()

--[============[
     CONTINUE
--]============]

exe("l3build tag foo")

exe([===[
  if [[ `git status --porcelain` ]]; then
    git commit -a -m 'update package info for release

    [ci-skip]';
  fi
]===])

exe("l3build ctan")

exe("texlua tagrelease.lua")

exe("l3build upload --file CHANGES-NEW.md")

--[============[
       END
--]============]

exe("rm CHANGES-NEW.md")

exe("git push")

exe("git checkout working")

exe("git rebase master")

exe("git push")

print("Great success! Now time to fix some more bugs.")
