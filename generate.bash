#!/bin/bash
#clear
ductA=ductA_$RANDOM
ductB=ductB_$RANDOM
ductC=ductC_$RANDOM
ductD=ductD_$RANDOM
ductE=ductE_$RANDOM
mkfifo $ductA $ductB $ductC $ductD $ductE
root=`realpath ../`

echo $root >$ductA &
echo helloworld.drawio >$ductB &
realpath ./d2f.comp >$ductC &
realpath ./das2f.comp >$ductD &
realpath ./das2j.comp | tee /tmp/ductE >$ductE &

./das2py.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7<$ductE &
pid1=$!
wait $pid

rm -f $ductA $ductB $ductC $ductD $ductE
