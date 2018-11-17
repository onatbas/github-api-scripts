user=onatbas

CONFIG=""
METHOD="POST"
config=$(cat ~/.config/hub)
public_token=$(echo $config | sed -E 's/.+onatbas oauth_token: ([a-z0-9]+) .+/\1 /g')

description=""
public="true"
files=""
id=""
while getopts :d:f:x:pe: option
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
	h)
		echo "Available options:"
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
	\"public\": $public,
	\"files\": { \"example\": {\"content\": \"test\"} }
}"

result=$(curl -s -X "$METHOD" -d "$body" https://api.github.com/gists"$id" -H "authorization: Bearer $public_token")

echo "$result"
echo "$result" | grep git_pull | sed -E "s/.*\"(.+)\".*/\1/g"
