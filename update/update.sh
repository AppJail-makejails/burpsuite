#!/bin/sh

BASEDIR=`dirname -- "$0"` || exit $?
BASEDIR=`realpath -- "${BASEDIR}"` || exit $?

. "${BASEDIR}/update.conf"

set -xe
set -o pipefail

cat -- "${BASEDIR}/build.makejail.template" |\
    sed -Ee "s/%%VERSION%%/${VERSION}/g" > "${BASEDIR}/../build.makejail"

cat -- "${BASEDIR}/README.md.template" |\
    sed -E \
        -e "s/%%VERSION%%/${VERSION}/g" \
        -e "s/%%OSVERSION%%/${OSVERSION}/g" > "${BASEDIR}/../README.md"
