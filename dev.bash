# ./d2f.comp `realpath ~/app` helloworld 5>&1 &
# pid1=$!
# wait $pid1


# ./das2f.comp `realpath ~/app` helloworld `realpath ./d2f.comp` 6>&1
# pid1=$!
# wait $pid1

# ./das2j.comp `realpath ~/app` helloworld xxx `realpath ./das2f.comp` 7>&1
# pid1=$!
# wait $pid1


# # using ducts
# set -x
# duct1=duct1_$RANDOM
# duct2=duct2_$RANDOM
# duct3=duct3_$RANDOM
# mkfifo $duct1
# mkfifo $duct2
# mkfifo $duct3

# ./d2f.comp 3<$duct1 4<$duct2 5>$duct3 &

# str=`realpath ~/app`
# echo $str >$duct1 &
# echo helloworld >$duct2 &
# cat <$duct3

clear
echo dev.bash
duct1=duct1_$RANDOM
duct2=duct2_$RANDOM
duct3=duct3_$RANDOM
duct4=duct4_$RANDOM
mkfifo $duct1
mkfifo $duct2
mkfifo $duct3
mkfifo $duct4

./das2f.comp 3<$duct1 4<$duct2 5<$duct3 6>$duct4 &
pid1=$!

realpath ~/app >$duct1 &
echo helloworld >$duct2 &
realpath ./d2f.comp >$duct3 &
cat <$duct4
