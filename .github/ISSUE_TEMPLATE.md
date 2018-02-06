## Description
A sentence or two describing the issue.

## Check/indicate
- [ ] Relevant for XeTeX
- [ ] Relevant for LuaTeX
- [ ] Issue tracker has been searched for similar issues?
- [ ] Links to <tex.stackexchange.com> discussion if appropriate

## Minimal example demonstrating the issue
```
\documentclass{article}
\usepackage{unicode-math}
\setmainfont{texgyrepagella}[
  Extension = .otf ,
  UprightFont = *-regular.otf ,
  ItalicFont  = *-italic.otf  ,
]
\begin{document}
hello \emph{hello}
\end{document}
```

## Further details
