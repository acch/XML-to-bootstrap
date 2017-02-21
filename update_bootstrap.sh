#!/usr/bin/sh

# Undo any changes
git submodule deinit -f .
git submodule update --init

cd modules/bootstrap

# Fetch updates
git checkout master # Still needed?
#git pull --rebase # Not needed any longer?
git checkout v4.0.0-alpha.6

# Link and import our custom variables
echo '@import "customvars";' >> scss/_custom.scss
ln -s ../../../sass/customvars.scss scss/

# Rebuild Bootstrap
npm install && grunt dist
