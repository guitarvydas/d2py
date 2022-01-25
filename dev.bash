#echo use run.bash
#exit

clear
echo dev.bash
ductA=ductA_$RANDOM
ductB=ductB_$RANDOM
ductC=ductC_$RANDOM
ductD=ductD_$RANDOM
ductE=ductE_$RANDOM
mkfifo $ductA $ductB $ductC $ductD $ductE
root=`realpath ../`

# # for d2f 
# $root/d2py/d2f.comp 3<$ductA 4<$ductB 5>$ductC &
# echo $root >$ductA &
# echo helloworld.drawio >$ductB &
# cat <$ductC >d2f.fb.pl
# cat d2f.fb.pl

# for das2f
./das2f.comp 3<$ductA 4<$ductB 5<$ductC 6>$ductD &
pid1=$!
echo $root >$ductA &
echo helloworld.drawio >$ductB &
realpath ./d2f.comp >$ductC &
cat <$ductD >das2f.fb.pl

# # for das2j
# ./das2j.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7>$ductE &
# pid1=$!
# echo $root >$ductA &
# echo helloworld.drawio >$ductB &
# realpath ./d2f.comp >$ductC &
# realpath ./das2f.comp >$ductD &
# cat <$ductE >out.json
# echo JSON output...
# cat out.json

# # for das2py
# ./das2py.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7<$ductE &
# pid1=$!
# echo $root >$ductA &
# echo helloworld.drawio >$ductB &
# realpath ./d2f.comp >$ductC &
# realpath ./das2f.comp >$ductD &
# realpath ./das2j.comp >$ductE &
# wait $pid

# rm -f $ductA $ductB $ductC $ductD $ductE
