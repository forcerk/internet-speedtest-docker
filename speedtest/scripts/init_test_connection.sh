#!/bin/sh
FILE="/app/speedtest/test_connection.log"

while true 
do 
	TIMESTAMP=$(date '+%s')

	/app/speedtest/speedtest-cli > $FILE

	DOWNLOAD=$(cat $FILE | grep "Download:" | awk -F " " '{print $2}')
	UPLOAD=$(cat $FILE | grep "Upload:" | awk -F " " '{print $2}')
	PING=$(ping -qc1 google.com 2>&1 | awk -F'/' 'END{ print (/^round-trip/? $4:"-100") }')
	echo "Ping: $PING   $TIMESTAMP"
	echo "Download: $DOWNLOAD Upload: $UPLOAD Ping: $PING   $TIMESTAMP"
	curl -i -XPOST 'http://db:8086/write?db=speedtest' --data-binary "download,host=local value=$DOWNLOAD"
	curl -i -XPOST 'http://db:8086/write?db=speedtest' --data-binary "upload,host=local value=$UPLOAD"
	curl -i -XPOST 'http://db:8086/write?db=speedtest' --data-binary "ping,host=local value=$PING"
	sleep $TEST_INTERVAL

done
