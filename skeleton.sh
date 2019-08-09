# Setup
# Add env info to the debug log
debug_log=./debug_log
ID=`date +%s`
echo " ------------- RUN ID $ID -------------- " >> $debug_log
echo "startup info" >> $debug_log
date >> $debug_log
about=(\
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

for i in "${about[@]}"
do 
   echo $i >> $debug_log
done

printenv >> $debug_log


# script starts here
echo Hello, World!


# CREATE FILE INLINE LOGIC
# cat <<EOF > long_sleep.sh
# sleep 100
# EOF
# chmod 755 long_sleep.sh

# SUBPROCESS START LOGIC
# echo Start a background process then clean it up after a number of seconds
# END=$1
# echo end $END
# pids=()
# for i in $(seq 1 $END)
# do
#    echo starting sleep process #$i
#    sleep 100 &
#    PID=$!
#    pids+=( $PID )
# done

# echo pids
# for i in "${pids[@]}"
# do
#    echo $i
# done

# CREATE SUBPROCESS CLEANUP SCRIPT
# cat <<EOF > cleanup.sh
# echo cleanup files
# rm long_sleep.sh
# echo cleanup all processes related too $0
# EOF

# chmod 755 cleanup.sh

# for i in "${pids[@]}"
# do
#    echo "echo killing $i; kill -9 $i >/dev/null" >> cleanup.sh
# done

# echo "echo done cleaning" >> cleanup.sh

echo "########################################" >> $debug_log
