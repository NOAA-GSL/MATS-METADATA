#!/bin/bash

function usage {
  echo "Usage $0 -c credentials-file -d document_id [-o output_file]"
  echo "The credentials-file specifies cb_host, cb_user, and cb_password."
  echo "The document id s the id of the metadata document.
  echo "The optional output_file will cause the metadata to be written to to the output_file."
  echo "If the output_file is not specified the data will be written to standard output."
  exit 1
}
unset out

while getopts 'c:d:o:' param; do
  case "${param}" in
  c)
    credentials_file=${OPTARG}
    if [[ ! -f "${credentials_file}" ]]; then
      echo "${credentials_file} does not exist"
      usage
    fi
    cb_host_line=$(grep cb_host ${credentials_file} | awk '{print $2}')
    # if it is a multinode host split on ',' and take the first one
    IFS=','
    read -ra hostarr <<<"$cb_host_line"
    cb_host_line=${hostarr[0]}
    cb_host=$(echo ${cb_host_line} | awk -F"//" '{print $NF}'  | awk -F":" '{print $1}')
    cb_user=$(grep cb_user ${credentials_file} | awk '{print $2}')
    cb_pwd=$(grep cb_password ${credentials_file} | awk '{print $2}')
    bucket=$(grep cb_bucket ${credentials_file} | awk '{print $2}')
    collection=$(grep cb_collection ${credentials_file} | awk '{print $2}')
    scope=$(grep cb_scope ${credentials_file} | awk '{print $2}')
    cred="${cb_user}:${cb_pwd}"
    ;;
  d)
   document_id=$(echo "${OPTARG}"
   ;;
  o)
    out=$(echo "${OPTARG}" | sed 's|/$||')
    ;;
  *)
    echo "ERROR: wrong parameter, I don't do ${param}"
    usage
    ;;
  esac
done

if [[ "X${out}" == "X" ]]; then
	curl -s ${cb_host}:8093/query/service -H 'Content-Type: application/json' -d "{\"statement\":\"SELECT ${collection}.* FROM ${bucket}._default.${collection} WHERE type='MD';\"}" -u 'avid:pwd_av!d' | jq .results
else
	curl -s ${cb_host}:8093/query/service -H 'Content-Type: application/json' -d "{\"statement\":\"SELECT ${collection}.* FROM ${bucket}._default.${collection} WHERE type='MD';\"}" -u 'avid:pwd_av!d' | jq .results > ${out}
fi
