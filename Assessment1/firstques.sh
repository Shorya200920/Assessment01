# !/bin/bash


IFS=','

while read -r Time mail task
do
	#ignoring the first line of file
	email=$mail
	dummy="emailIds"
	if [ "$email" = "$dummy" ]; then
	       	continue
	fi

	#username creation
	UserName=$(echo "$email" | cut -d '@' -f1)

	echo "username: $UserName"

	#Creating directory
	directory="$UserName"
	mkdir -p "$directory"

	#Counting the txt file in a particular directory and incrementing it
	count=$(ls "$directory" | wc -l)
	new_count=$((count+1))
	echo "$new_count"


	#receiver emailId
	echo "MailSendTo: $mail"

	ti=$Time
	ta=$task

	#creating subject of the mail
	sub="$ta
       	at
       	$ti"

	echo " Subject: $sub"

	#Subtracting 30Min From Given time to access Sending time
	t="$Time"
	TimeInSec=$(date -d "$t" +%s)
	TimeInSecMin30=$((TimeInSec - 1800))
	SendingTime=$(date -d @$TimeInSecMin30 +'%H:%M')
	
	

	#Sending Time
	echo "MailSendAt: $SendingTime"

	#body of the mail
	Body="This is the body"


	#creating a txt file
	file_name="Notification${new_count}.txt"
	echo "$file_name"

	#inserting our subject into txt file and moving txt file into a particular directory
	echo "$sub"> "$file_name"


	#setting timer
	at "$SendingTime" <<EOF
        mv "$file_name" "$directory"
EOF

	
	#Sending the mail
        #echo "$Body" | mail -s "$sub" "$mail"

	echo "------------------------------------------"




done<Book1.csv
