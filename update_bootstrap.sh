#!/usr/bin/sh

cd modules/bootstrap

git reset --hard
git pull

sed -i -e '1i@import "../../../sass/customvars";\' scss/_variables.scss

grunt dist
