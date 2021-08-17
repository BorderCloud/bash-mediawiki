#!/usr/bin/env bash

# Needs curl and jq

# You can create a new bot with this command:
# php maintenance/createBotPassword.php --grants basic,createeditmovepage,editdata,delete,editpage,uploadeditmovefile,uploadfile,highvolume --appid mediawiki1 UserData ff38s9u4feh07vjs2s6t88dh2pv5cfgv
# You can login in using username:'UserData@mediawiki1' and password:'ff38s9u4feh07vjs2s6t88dh2pv5cfgv'.

USERNAME="UserData@mediawiki1"
USERPASS="ff38s9u4feh07vjs2s6t88dh2pv5cfgv"
WIKI="http://serverdev-mediawiki2/"
WIKIAPI="http://serverdev-mediawiki2/w/api.php"
folder="/tmp"

PAGE="Title of an article"
PAGETEXT="{{nocat|2017|01|31}}"

//wget https://www.mediawiki.org/static/images/project-logos/mediawikiwiki.png
FILENAME="mediawikiwiki.png"
FILEPATH="./mediawikiwiki.png"
FILECOMMENT="comment"
FILETEXT="text"

cookie_jar="${folder}/wikicj"
rm $cookie_jar

#Will store file in wikifile
echo "UTF8 check: ☠"
#################login
echo "Logging into $WIKIAPI as $USERNAME..."

###############
#Login part 1
#printf "%s" "Logging in (1/2)..."
echo "Get login token..."
CR=$(curl -S \
	--location \
	--retry 2 \
	--retry-delay 5 \
	--cookie-jar $cookie_jar \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--request "GET" "${WIKIAPI}?action=query&meta=tokens&type=login&format=json")

echo "$CR" | jq .

rm ${folder}/login.json
echo "$CR" > ${folder}/login.json
TOKEN=$(jq --raw-output '.query.tokens.logintoken'  ${folder}/login.json)

if [ "$TOKEN" == "null" ]; then
	echo "Getting a login token failed."
	exit
else
	echo "Login token is $TOKEN"
	echo "-----"
fi

###############
#Login part 2
echo "Logging"
CR=$(curl -S \
	--location \
	--cookie $cookie_jar \
	--cookie-jar $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--form "action=login" \
	--form "lgname=${USERNAME}" \
	--form "lgpassword=${USERPASS}" \
	--form "lgtoken=${TOKEN}" \
	--form "format=json" \
	--request "POST" "${WIKIAPI}")

echo "$CR" | jq .

STATUS=$(echo $CR | jq '.login.result')
if [[ $STATUS == *"Success"* ]]; then
	echo "Successfully logged in as $USERNAME, STATUS is $STATUS."
	echo "-----"
else
	echo "Unable to login, is logintoken ${TOKEN} correct?"
	exit
fi

#########
echo "Get right of bot..."
CR=$(curl -S \
	--location \
	--retry 2 \
	--retry-delay 5 \
	--cookie $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--request "GET" "${WIKIAPI}?action=query&meta=userinfo&uiprop=rights&format=json")

echo "$CR" | jq .

#############
# Get edit token
echo "Fetching edit token..."

CR=$(curl -S \
	--location \
	--cookie $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--request "GET" "${WIKIAPI}?action=query&meta=tokens&format=json")

echo "$CR" | jq .
echo "$CR" > ${folder}/edittoken.json
EDITTOKEN=$(jq --raw-output '.query.tokens.csrftoken' ${folder}/edittoken.json)
rm ${folder}/edittoken.json

# Remove carriage return!
if [[ $EDITTOKEN == *"+\\"* ]]; then
	echo "Edit token is: $EDITTOKEN"
else
	echo "Edit token not set."
	exit
fi

#############
echo "Make a test edit"
CR=$(curl -S \
	--location \
	--cookie $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--form "action=edit" \
	--form "format=json" \
	--form "title=${PAGE}" \
	--form "appendtext=${PAGETEXT}" \
	--form "token=${EDITTOKEN}" \
	--request "POST" "${WIKIAPI}")

echo "$CR" | jq .

#############

# Get a new edit token
echo "Fetching edit token..."

CR=$(curl -S \
	--location \
	--cookie $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--compressed \
	--request "GET" "${WIKIAPI}?action=query&meta=tokens&format=json")

echo "$CR" | jq .
echo "$CR" > ${folder}/edittoken.json
EDITTOKEN=$(jq --raw-output '.query.tokens.csrftoken' ${folder}/edittoken.json)
rm ${folder}/edittoken.json

# Remove carriage return!
if [[ $EDITTOKEN == *"+\\"* ]]; then
	echo "Edit token is: $EDITTOKEN"
else
	echo "Edit token not set."
	exit
fi

############
echo "Make a test upload"

CR=$(curl -S \
	--location \
	--cookie $cookie_jar_login \
	--user-agent "Curl Shell Script" \
	--keepalive-time 60 \
	--header "Accept-Language: en-us" \
	--header "Connection: keep-alive" \
	--header "Expect:" \
	--form "action=upload" \
	--form "format=json" \
	--form "token=${EDITTOKEN}" \
	--form "filename=${FILENAME}" \
	--form "text=${FILETEXT}" \
	--form "comment=${FILECOMMENT}" \
	--form "file=@${FILEPATH}" \
	--form "ignorewarnings=yes" \
	--request "POST" "${WIKIAPI}")

echo "$CR" | jq .
