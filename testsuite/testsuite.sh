#!/bin/sh

cd ..
rm testsuite/build/*

tex fontspec.dtx
cp  fontspec.sty testsuite/build/
cp  fontspec-xetex.sty testsuite/build/
cp  fontspec-luatex.sty testsuite/build/
cp  fontspec.cfg testsuite/build/

cp testsuite/tests/*.ltx  testsuite/build/
cp testsuite/testsuite.cls testsuite/build/

cd testsuite/build
for tst in *.ltx
do
    rm *.fontspec
    xelatex $tst
done

ls *.ltx | sed -e 's/\(.*\).ltx/\\TEST{\1}/g' > testsuite-listing.tex

rm *.ltx *.aux *.log *.fontspec

cd ..
xelatex fontspec-testsuite.tex

