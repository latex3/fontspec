#!/bin/sh

cd ..
rm testsuite/build/*

tex fontspec.dtx
mv  fontspec.sty testsuite/build/
mv  fontspec-xetex.sty testsuite/build/
mv  fontspec-luatex.sty testsuite/build/
mv  fontspec-patches.sty testsuite/build/

cp testsuite/tests/*.ltx  testsuite/build/
cp testsuite/testsuite.cls testsuite/build/

cd testsuite/build
for tst in *.ltx
do
    xelatex $tst
done

ls *.ltx | sed -e 's/\(.*\).ltx/\\TEST{\1}/g' > testsuite-listing.tex

cd ..
xelatex fontspec-testsuite.tex

