config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

curl -X DELETE https://api.github.com/repos/onatbas/$1 -H 'authorization: Bearer $public_token'
  

