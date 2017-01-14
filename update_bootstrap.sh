#!/usr/bin/sh

cd modules/bootstrap

# Undo any changes
git reset --hard
rm scss/customvars.scss

# Fetch updates
git checkout master
git pull --rebase
git checkout v4.0.0-alpha.6

# Link and import our custom variables
echo '@import "customvars";' >> scss/_custom.scss
ln -s ../../../sass/customvars.scss scss/

# Rebuild Bootstrap
grunt dist
