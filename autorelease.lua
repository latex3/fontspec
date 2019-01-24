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

gitbranch = os.capture('git symbolic-ref --short HEAD')
print("Current git branch: "..gitbranch)
if gitbranch ~= "working" then
  error("You must be on the 'working' branch")
end

travis = os.capture("travis status | grep passed")
print("Travis status: "..travis)

exe("git checkout master")

exe("git pull")

exe("git rebase working")

exe("l3build tag foo")

exe("git commit -a -m 'update package info for release'")

exe("l3build ctan")

exe("texlua tagrelease.lua")

exe("l3build upload --file CHANGES-NEW.md")

exe("rm CHANGES-NEW.md")

exe("git push")

exe("git checkout working")

exe("git rebase master")
