#!/bin/bash

# Various commands to query the number of PRs for a given repo or repos within an org
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
