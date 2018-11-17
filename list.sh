user=onatbas
config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

while getopts :psh option
do
	case "$option" in
	p)
		visibility="&visibility=public"
		;;
	s)
		visibility="&visibility=private"
		;;
	h)
		echo "default: list all repos
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


curl -s "https://api.github.com/user/repos?affiliation=owner$visibility" -H "authorization: Bearer $public_token"

