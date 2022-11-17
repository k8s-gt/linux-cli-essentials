#!/bin/bash -e

: "${TARGET_YEAR:=$(date '+%Y')}"

usage() {
  echo "usage: $0 [-y <year>] [-h] <GitHub handle> ... [<GitHub handle>]
  -y    set target year to compare
  -h    show help

Examples
  $0 octocat
  $0 k8s-gt octocat"
}

setup_tmp() {
  TMP_DIR=$(mktemp -d)

  cleanup() {
    code=$?
    set +e
    # Clear traps from EXIT
    trap - EXIT
    rm -rf "${TMP_DIR}"
    exit $code
  }
  # Trap INT SIGNAL and EXIT "event"
  trap cleanup INT EXIT

  export TMP_DIR
}

function main () {
  [ -e "${TMP_DIR}" ] || setup_tmp

  for GH_HANDLE in "$@"; do
    curl -L "https://github.com/users/${GH_HANDLE}/contributions?tab=overview&from=${TARGET_YEAR}-01-01T00:00:00.000+00:00" 2>/dev/null | \
      grep -v 'data-level="0"' | \
      grep -c 'data-date' | \
      xargs echo "${GH_HANDLE} " >>"${TMP_DIR}/carry.txt"
  done

  sort -n -r -k2 <"${TMP_DIR}"/carry.txt
}

while getopts 'hy:' c; do
  case "${c}" in
  h)
    usage
    exit 0
    ;;
  y)
    TARGET_YEAR="${OPTARG}"
    ;;
  *)
    usage
    exit 1
    ;;
  esac
done

shift $((OPTIND - 1))

if [ "${#@}" -eq 0 ]; then
  usage
  exit 1
fi

main "$@"
