clear
echo dev.bash
ductA=ductA_$RANDOM
ductB=ductB_$RANDOM
ductC=ductC_$RANDOM
ductD=ductD_$RANDOM
ductE=ductE_$RANDOM
mkfifo $ductA $ductB $ductC $ductD $ductE

# # for d2f 
# set -x
# ./d2f.comp 3<$ductA 4<$ductB 5>$ductC &
# str=`realpath ~/app`
# echo $str >$ductA &
# echo helloworld >$ductB &
# cat <$ductC

# # for das2f
# ./das2f.comp 3<$ductA 4<$ductB 5<$ductC 6>$ductD &
# pid1=$!
# realpath ~/app >$ductA &
# echo helloworld >$ductB &
# realpath ./d2f.comp >$ductC &
# cat <$ductD

# for das2j
./das2j.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7>$ductE &
pid1=$!
realpath ~/app >$ductA &
echo helloworld >$ductB &
realpath ./d2f.comp >$ductC &
realpath ./das2f.comp >$ductD &
cat <$ductE

# # for das2py
# ./das2py.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7<$ductE &
# pid1=$!
# realpath ~/app >$ductA &
# echo helloworld >$ductB &
# realpath ./d2f.comp >$ductC &
# realpath ./das2f.comp >$ductD &
# realpath ./das2j.comp >$ductE &
# wait $pid

rm -f $ductA $ductB $ductC $ductD $ductE
