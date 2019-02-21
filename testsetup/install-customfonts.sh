#!/usr/bin/env sh

ls -la /tmp/fontspec-test-fonts

# Install custom fontspec fonts
if [ -d "/tmp/fontspec-test-fonts/.git" ]; then
  cd /tmp/fontspec-test-fonts ;
  git pull --rebase ;
  cd -;
else
  git clone https://github.com/wspr/fontspec-test-fonts.git /tmp/fontspec-test-fonts ;
fi

sh /tmp/fontspec-test-fonts/install.sh
