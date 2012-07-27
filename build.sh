#!/bin/bash

SCRIPT_PATH=$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

COMMAND="$1"
ADDITIONAL="$2"

# Support functions

function cleanup {
    # End timer and print elapsed time
    if [ ! -z "$START" ]; then
        END=$(date +%s)
        ELAPSED=$((END - START))
        E_MIN=$((ELAPSED / 60))
        E_SEC=$((ELAPSED - E_MIN * 60))
        printf "Elapsed: "
        [ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
        printf "%d sec(s)\n " $E_SEC
    fi

    popd >/dev/null
    exit
}

function findup {
    local locatefile=$1
    local currentpath=$2
    local match=''
    [ -z "$currentpath" ] && currentpath=$(pwd)
    match=$(find "${currentpath}/" -maxdepth 1 -name "${locatefile}" 2>/dev/null)
    if [ ! -z "$match" ]; then
        echo $match
    else
        if [[ "${currentpath}" != "/" ]]; then
            findup "${locatefile}" "$(dirname "${currentpath}")"
        fi
    fi
}

function die {
    echo -e $* >&2
    exit 1
}

trap cleanup INT TERM EXIT

REPO_PATH=`dirname $(findup '.repo') 2>/dev/null`
[ -z "${REPO_PATH}" ] && die "Unable to find repo"
pushd "${REPO_PATH}" >/dev/null

# Starting timer
START=$(date +%s)

# Device specific settings
    case "$COMMAND" in
        clean)
                make clobber
                ;;
        prepare)
                repo sync -j8
                ;;

        skyrocket | hercules | quincyatt)
                if [ -f "${SCRIPT_PATH}/cm10-${COMMAND}-apply.sh" ]; then
                    ${SCRIPT_PATH}/cm10-${COMMAND}-apply.sh
                fi
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                brunch cm_${COMMAND}-userdebug
                ;;
        *)
                unset START
                echo -e "Usage: $0 DEVICE ADDITIONAL"
                echo -e "Example: ./build.sh skyrocket"
                echo -e "Use: ./build.sh clean to make clobber"
                echo -e "Use: ./build.sh prepare to repo sync"
                exit 2
                 ;;
esac
