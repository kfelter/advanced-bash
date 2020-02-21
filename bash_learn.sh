set -e
echo Move to working directory that the script is in
cd "$(dirname "$0")"
SEC=$(date +%s)
echo current time $SEC

echo Create array and loop over the elements
about_me=(\
          "pid $$"\
          "script name $0"\
          "arg count $#"\
          "args $@"\
          "exit status $?"\
          "USER $USER"\
          "HOSTNAME $HOSTNAME"\
          "SECONDS since start $SECONDS"\
          "RANDOM number $RANDOM"\
          "CURRENT LINE $LINENO"\
)

for i in "${about_me[@]}"
do 
   echo $i
done

echo Create a file inline
cat <<EOF > long_sleep.sh
sleep $2
EOF

echo
cat long_sleep.sh

chmod 755 long_sleep.sh

echo Start a background process then clean it up after a number of seconds
END=$1
echo end $END
pids=()
for i in $(seq 1 $END)
do
   echo starting sleep process #$i
   sleep $2 &
   PID=$!
   pids+=( $PID )
done

echo pids
for i in "${pids[@]}"
do
   echo $i
done

# echo processes
# ps

echo create cleanup script
cat <<EOF > cleanup.sh
echo cleanup files
rm long_sleep.sh
echo cleanup all processes related too $0
EOF

chmod 755 cleanup.sh

for i in "${pids[@]}"
do
   echo "echo killing $i; kill -9 $i >/dev/null" >> cleanup.sh
done

echo "echo done cleaning" >> cleanup.sh
