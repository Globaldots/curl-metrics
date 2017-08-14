# save as timing.sh
# execute:  ./timing.sh 100

N=$1

TEST=test

URL="https://some.domain.co/library/assets/JsonFile/co.domain.styles.neighborhood.elephant.json?mt=123"
declare -a vars
header=
template=
# this is a list of curl metrics to output
vars=(time_namelookup time_connect time_appconnect time_pretransfer time_redirect time_starttransfer time_total speed_upload speed_download remote_ip http_code)
# set up the log header and the template format
for v in ${vars[@]}; do
	header=${header}\\t${v}
	template=${template}\\t%{${v}}
done	
template=${template}\\n

# initialize the data header
echo -e "${header}"  > $TEST.timing.log
for i in $(seq 1 $N); do 
	echo $TEST $i
	curl -w "${template}" -s -o /dev/null  $URL >> $TEST.timing.log
done
