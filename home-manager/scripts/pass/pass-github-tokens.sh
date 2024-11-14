url=$(git config --get remote.origin.url)
name=$(expr "$url" : '.*\(/.*\)')
name=${name#/}
name=${name%.git}
token=$(multipass github-tokens show "$name")
if [ $? != 0 ]; then
  exit 1
fi

echo https://$token@${url#https://}