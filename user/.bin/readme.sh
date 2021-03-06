#!/usr/bin/env bash
# status: needs_review
#
# ---------------------------------------------------------------------
#
#   Summary:     Detect and open readme file in browser.
#   Author:      Nikhil Gupta
#   Usage:       readme <readme-file|dir-with-readme-file>
#   Description: Script that searches through the current directory for
#                a README file, and opens its preview in the browser
#                using Pandoc and a beautiful CSS.
#
#                If more than one README files exist in the directory,
#                one with the highest number of lines count will be opened.
#
#   Usage:       readme ~/Code/dotcastle => opens ~/Code/dotcastle/README.md
#                readme ~/Code/dotcastle/README.textile
#                readme => opens README.* in current directory
#
# ---------------------------------------------------------------------
#

src="${1:-$(pwd)}"
font_url="https://fonts.googleapis.com/css?family=PT+Sans"
css_path="${HOME}/Code/dotcastle/miscelleneous/github-pandoc.css"
css_url="https://gist.githubusercontent.com/dashed/6714393/raw/ae966d9d0806eb1e24462d88082a0264438adc50/github-pandoc.css"

which pandoc &>/dev/null || sudo apt install pandoc
[[ -f "${css_path}" ]] || wget "${css_url}" -o "${css_path}"

if [[ -d "${src}" ]]; then
    src=$(find "${src}" -type f -maxdepth 1 -iregex '.*\/readme..*' -exec wc -l {} +)
    src=$(echo $src | sort -rn | tac | tail -2 | head -1)
    src=$(echo $src | tr -s ' ' ' ' | rev | cut -d ' ' -f 1 | rev)
fi

if [[ -f "${src}" ]]; then
    title="$(basename $(dirname $src))/$(basename $src)"

    case "${src}" in
    *.rdoc)
        dst="/tmp/readme.$$"
        rdoc "${src}" -o "${dst}" -t "${title}"
        dst="${dst}/index.html"
        ;;
    *)
        dst="/tmp/readme.$$.html"
        title="<title>${title}</title><link rel='stylesheet' href='${font_url}' type='text/css'>"
        pandoc --css "${css_path}" "${src}" | sed -e "s#<title></title>#${title}#" >"${dst}"
        ;;
    esac

    eval "${BROWSER} ${dst}"
elif [[ -z "${src}" ]]; then
    echo "No readme file found inside: ${1:-$(pwd)}"
else
    echo "Invalid input path specified!"
fi
