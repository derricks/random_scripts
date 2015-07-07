# Various commands to query the number of PRs for a given repo or repos within an org
curl -s 'https://github.va.opower.it/api/v3/search/issues?q=type:pr+user:chef+user:releng+state:open' | \
  jq '.items | .[] | [.url, .title, .user.login, .updated_at] | @csv' | tr -d '"\\' | sort | \
  awk -f ~/format-repo-output.awk

curl -s "https://github.va.opower.it/api/v3/repos/opower/archmage/pulls" | \
    jq '.[] | [.url, .title, .user.login, .updated_at] | @csv' | tr -d '"\\' | \
    awk -f ~/format-repo-output.awk
