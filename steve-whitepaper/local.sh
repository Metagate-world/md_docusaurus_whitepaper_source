#!/bin/bash

echo "Local View"
echo

SCRIPT=`dirname $0`
SCRIPT=`realpath $SCRIPT`
export DOCU_VERSION=`date '+%y%m%d-%H%M'`

cd "$SCRIPT" || exit 1

[[ -d site ]] || {
    echo "site subdirectory doesn't exist"
    exit 1
}

cd site || exit 1

npx docusaurus start
