BEGIN {
  FS = ","
  OFS = "\t"
  cur_url = ""
}

{
  sub("/issues/[0-9]+", "", $1)
  sub("[^ ]*/repos/","",$1)
  repo_path = $1
}

cur_url == $1 {
  gsub(".", " ", repo_path)
}

cur_url != $1 {
  cur_url = $1
}

repo_path !~ /^[ ]+$/ {
  print ""
}

{print repo_path, $2, $3, $4}
