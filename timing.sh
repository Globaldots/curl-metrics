#!/bin/bash -

# save as timing.sh
# execute:  ./timing.sh 100
# 
#  To add a 2 second pause between invocations: 
#           ./timing.sh 100  2s

# define variables
N=$1

# used as a prefix to the output file
TEST=test

URL="https://some.domain.co/library/assets/JsonFile/co.domain.styles.neighborhood.elephant.json?mt=123"
URL="https://my.globaldots.com/"

declare -a vars
# this is a list of curl metrics to output
vars=(time_namelookup time_connect time_appconnect time_pretransfer time_redirect time_starttransfer time_total speed_upload speed_download remote_ip http_code)


# nothing to modify down below
if [ -z "$2"  ]
then
  pause=0
else
  pause=$2
fi

header=
template=
# set up the log header and the template format
for v in ${vars[@]}; do
	header=${header}\\t${v}
	template=${template}\\t%{${v}}
done	
template=${template}\\n

# initialize the data header
# add timestamp
header=timestamp\\t${header}
echo -e "${header}"  > $TEST.timing.log
for i in $(seq 1 $N); do 
	echo $TEST $i
	timestamp=$(date +"%Y-%m-%d %T")
	response=`curl -w "${template}" -s -o /dev/null  $URL`
	echo -e "${timestamp}\\t${response}" >> $TEST.timing.log
	sleep $pause
done
