user=onatbas

CONFIG=""

config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

NAME="test"

while getopts :n:i:p:w: option
do
	case "$option" in
	i)
		CONFIG=", \"has_issues\": $OPTARG $CONFIG"	
		;;
	p)
		CONFIG=", \"has_projects\": $OPTARG $CONFIG"	
		;;
	w)
		CONFIG=", \"has_wiki\": $OPTARG $CONFIG"	
		;;
	n)
		NAME="$OPTARG"
		;;
	*)
		echo "yanlis biseyler oldu haci"
		;;
	esac
done


obj="{ \"name\": \"$NAME\" $CONFIG }"


echo $obj

curl -X PATCH -d "$obj" https://api.github.com/repos/$user/$NAME -H "authorization: Bearer $public_token"
