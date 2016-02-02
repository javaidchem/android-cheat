#!/usr/bin/env bash
# Use `min` to generate a template with a different package name
# to create multiple minimal cheats may be installed.
#
# Usage:
#
#     ./template.sh NewName
#
# Custom tempalte:
#
#     ./template.sh NewName OldName
set -ex
new="$1"
shift
if [ $# -gt 0 ]; then
  old="$1"
  shift
else
  old='Min'
fi
# http://stackoverflow.com/questions/28795479/awk-sed-script-to-convert-a-file-from-camelcase-to-underscores
new_underscore="$(echo "$new" | sed -r -e 's/([a-z0-9])([A-Z])/\1_\L\2/g' -e 's/([A-Z])/\L\1/')" 
old_underscore="$(echo "$old" | sed -r -e 's/([a-z0-9])([A-Z])/\1_\L\2/g' -e 's/([A-Z])/\L\1/')" 
cp -r "$old_underscore" "$new_underscore"
cd "$new_underscore"
find . -type f -print0 | xargs -0 sed -i "s/\.${old_underscore}/.${new_underscore}/g"
find . -type f -print0 | xargs -0 sed -i "s/${old}/${new}/g"
cd 'src/com/cirosantilli/android_cheat'
mv "$old_underscore" "$new_underscore"
