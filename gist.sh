user=onatbas

CONFIG=""
METHOD="POST"
config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

description=""
public="true"
files=""
id=""
while getopts :d:f:x:chpe: option
do
	case "$option" in
	x)
		METHOD="DELETE"
		id="/$OPTARG"
		;;
	e)
		METHOD="PATCH"
		id="/$OPTARG"
		;;
	p)
		public="false"
		;;
	d)
		description="$OPTARG"
		;;
	c)
		METHOD="POST"
		files=",\"files\": { \"example\": {\"content\": \"test\"} }"
		;;
	h)
		echo "Available options:
-x <NAME>	: delete a gist
-e <NAME>	: edit a gist
-p		: set public=false
-d <DESC>	: Set description
-c 		: Create a new gist
-h		: help
"
		exit
		;;
	*)
		echo "Yanlis komut. -h yap haci"
		exit
		;;
	esac
done

body="{
	\"description\": \"$description\",
	\"public\": $public
	$files

}"

result=$(curl -s -X "$METHOD" -d "$body" https://api.github.com/gists"$id" -H "authorization: Bearer $public_token")

echo "$result"
echo "$result" | grep git_pull | sed -E "s/.*\"(.+)\".*/\1/g"
