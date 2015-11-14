#!/usr/bin/env bash
#2015-10-13 dorsch sebastian
#set -eux

function warn {
    echo >&2 ERROR. ${*}
    exit 1
}

[[ ${#} -ne 2 ]] && {
    warn "Usage: ${0} PATH SEARCHSTRING"
}

[[ ! -d "${1}" ]] && {
    warn "${1} not existent."
}

typeset -a search_result=($(gfind "${1}" -type f | gxargs -r grep -l "${2}"))

[[ ${#search_result[@]} -eq 0 ]] && {
    warn "Query returned no results."
}

i=1
while read -d" " file ; do
    [[ $((i++ % 10)) -eq 0 ]] && sep="\n\n" || sep=", "
    printf "%s%b" "${file##*/}" "$sep"
done <<< "${search_result[@]}"
