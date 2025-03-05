#!/bin/sh

function usage {
  echo "Usage $0 -c credentials-file -d destination directory"
  echo "The credentials-file specifies cb_host, cb_user, and cb_password."
  echo "The destination directory is where the program write the result"
  echo "This script requires jq to be installed - https://jqlang.github.io/jq/"
  exit 1
}

if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit 1
fi

while getopts 'c:d:' param; do
  case "${param}" in
  c)
    credentials_file=${OPTARG}
    if [[ ! -f "${credentials_file}" ]]; then
      echo "${credentials_file} does not exist"
      usage
    fi
    cb_host=$(grep cb_host ${credentials_file} | awk -F"//" '{print $2}')
    # if it is a multinode host split on ',' and take the first one
    IFS=','
    read -ra hostarr <<<"$cb_host"
    cb_host=${hostarr[0]}
    cb_user=$(grep cb_user ${credentials_file} | awk '{print $2}')
    cb_pwd=$(grep cb_password ${credentials_file} | awk '{print $2}')
    bucket=$(grep cb_bucket ${credentials_file} | awk '{print $2}')
    collection=$(grep cb_collection ${credentials_file} | awk '{print $2}')
    scope=$(grep cb_scope ${credentials_file} | awk '{print $2}')
    cred="${cb_user}:${cb_pwd}"
    ;;
  d)
    # remove the last '/' if it is there
    export destination_dir=$(echo "${OPTARG}" | sed 's|/$||')
    if [[ ! -d "${destination_dir}" ]]; then
      echo "ERROR: destination directory ${destination_dir} does not exist"
      usage
    fi
    ;;
  *)
    echo "ERROR: wrong parameter, I don't do ${param}"
    usage
    ;;
  esac
done

if [[ -z $cb_user ]] || [[ -z $destination_dir ]]; then
    usage
fi

cred="${cb_user}:${cb_pwd}"

curl -s -k --user ${cred} "https://${cb_host}:18091/indexStatus" | jq -r '.indexes | .[] .definition' > "${destination_dir}/indexes.sql"
