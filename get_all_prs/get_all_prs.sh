#!/bin/bash

if [[ $# -eq 0 ]]
then
  echo "Usage: get_all_prs.sh [org|repo]"
  exit 1
fi

# build up query for github
GH_QUERY="type:pr state:open"

for query_term in "$@"
do
  if [[ $query_term =~ \/ ]]
  then
    GH_QUERY="$GH_QUERY repo:$query_term"
  else
    GH_QUERY="$GH_QUERY user:$query_term"
  fi
done

curl -G -s 'https://github.va.opower.it/api/v3/search/issues' --data-urlencode "q=$GH_QUERY" --data-urlencode "per_page=100" | \
   jq '.items | .[] | [.url, .title, .user.login, .updated_at] | @csv' | tr -d '"\\' | sort
