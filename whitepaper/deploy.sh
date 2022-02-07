#!/bin/bash

echo "Deploy"
echo

[[ -z $1 ]] && {
    echo "`basename $0` <env>"
    echo "where <env> is the name of the environment to use, a file named <env>.env in the script directory"
    exit 1
}

[[ -e $1.env ]] || {
    echo "Couldn't find $1.env"
    exist 1
}

SCRIPT=`dirname $0`
SCRIPT=`realpath $SCRIPT`

cd "$SCRIPT" || exit 1
source "$1.env"

[[ -d site ]] || {
    echo "site subdirectory doesn't exist"
    exit 1
}

cd site || exit 1

echo "********** Building..."
echo
yarn run build || exit 1

echo "********** Uploading..."
echo
aws s3 sync \
    build/ \
    s3://$BUCKET \
    --profile $PROFILE \
    --region $REGION \
    --quiet \
    || exit 1

echo
echo "Site can be tested here: $DISTRIBUTION_URL"

echo Done.
