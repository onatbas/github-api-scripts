user=onatbas
config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')



curl -s "https://api.github.com/user/repos?affiliation=owner" -H "authorization: Bearer $public_token"

