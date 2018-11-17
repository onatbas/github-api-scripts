user=onatbas
config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

url="https://api.github.com/user/repos"

while getopts :pgsh option
do
	case "$option" in
	p)
		visibility="&visibility=public"
		;;
	s)
		visibility="&visibility=private"
		;;
	g)
		url="https://api.github.com/gists"
		;;
	h)
		echo "default: list all repos
g:	work on gists
p: 	get only public repos
s:	get only private repos"
		exit
		;;
	*)
		echo "olmadi... Use -h for help"
		exit
		;;
	esac
done

# Get correct api tokens


curl -s "$url?affiliation=owner$visibility" -H "authorization: Bearer $public_token"

