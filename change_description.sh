user=onatbas
newName="{\"description\": \"$2\", \"name\": \"$1\"}"
oldName="$1"

config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')


curl -X PATCH -d "$newName" https://api.github.com/repos/$user/$oldName -H "authorization: Bearer $public_token"

