set -e
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
S=$RANDOM
cat <<EOF > long_sleep.sh
echo sleeping for $S s
sleep $S
EOF

echo
cat long_sleep.sh

chmod 755 long_sleep.sh

echo Start a background process then clean it up after a number of seconds
END=$(($S % 100))
echo end $END
pids=()
for i in $(seq 1 $END)
do
   echo starting sleep process #$i
   ./long_sleep.sh &
   PID=$! 
   pids+=( $PID )
done

echo pids
for i in "${pids[@]}"
do
   echo $i
done

echo processes
ps

echo create cleanup script
cat <<EOF > cleanup.sh
echo cleanup all processes related too $0
EOF

chmod 755 cleanup.sh

for i in "${pids[@]}"
do
   echo "echo killing $i; kill $i >/dev/null" >> cleanup.sh
done

echo "echo done cleaning" >> cleanup.sh
