#!/usr/bin/sh

cd modules/bootstrap

# Undo any changes
git reset --hard
rm scss/customvars.scss

# Fetch updates
git checkout master
git pull
git checkout v4.0.0-alpha.2

# Link and import our custom variables
sed -i -e '1i@import "customvars";\' scss/_variables.scss
ln -s ../../../sass/customvars.scss scss/

# Rebuild Bootstrap
grunt dist
