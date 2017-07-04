#!/usr/bin/sh

# Undo any changes
git submodule deinit -f .
git submodule update --init

cd modules/bootstrap

# Fetch updates
git checkout master # Still needed?
#git pull --rebase # Not needed any longer?
git checkout v4.0.0-alpha.6

cd ../..

# Link and import our custom variables, rebuild Bootstrap
grunt init
