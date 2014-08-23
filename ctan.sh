#!/bin/sh

PKG='fontspec'

pdflatex -shell-escape $PKG.dtx
pdflatex $PKG.dtx
pdflatex $PKG.dtx

mkdir -p -v   CTAN-TMPDIR/source/latex/$PKG/
mkdir -p -v   CTAN-TMPDIR/tex/latex/$PKG/
mkdir -p -v   CTAN-TMPDIR/doc/latex/$PKG/
mkdir -p -v   CTAN-TMPDIR/$PKG/doc-files/

cp $PKG.dtx   CTAN-TMPDIR/source/latex/$PKG/
cp fontspec-luatex.sty     CTAN-TMPDIR/tex/latex/$PKG/
cp fontspec-patches.sty    CTAN-TMPDIR/tex/latex/$PKG/
cp fontspec-xetex.sty      CTAN-TMPDIR/tex/latex/$PKG/
cp fontspec.cfg            CTAN-TMPDIR/tex/latex/$PKG/
cp fontspec.lua            CTAN-TMPDIR/tex/latex/$PKG/
cp fontspec.sty            CTAN-TMPDIR/tex/latex/$PKG/

cp $PKG.pdf   CTAN-TMPDIR/doc/latex/$PKG/
cp $PKG-example.tex   CTAN-TMPDIR/doc/latex/$PKG/
cp README.markdown CTAN-TMPDIR/doc/latex/$PKG/README

cp $PKG.dtx   CTAN-TMPDIR/$PKG/
cp $PKG.pdf   CTAN-TMPDIR/$PKG/
cp $PKG-example.tex   CTAN-TMPDIR/$PKG/
cp README.markdown CTAN-TMPDIR/$PKG/README

cp -R doc-files/*.pdf              CTAN-TMPDIR/$PKG/doc-files/
cp -R CTAN-TMPDIR/$PKG/example/      CTAN-TMPDIR/doc/latex/$PKG/

cd CTAN-TMPDIR
zip -r $PKG.tds.zip source/ tex/ doc/   -x *.DS_Store
zip -r $PKG.zip   $PKG $PKG.tds.zip     -x *.DS_Store

cd ..
mv CTAN-TMPDIR/$PKG.zip $PKG.zip
rm -rf CTAN-TMPDIR
