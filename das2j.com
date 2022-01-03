# in: [ root name drawio das2f ]
# out: [ json ]

root=$1
name=$2
drawio=/dev/fd/5
das2f=$4
fb=/dev/fd/7

p1=pipe_$RANDOM
mkfifo $p1
p2=pipe_$RANDOM
mkfifo $p2

$das2f $root $name $das2f 6>$p2 &
pid=$!
cat $drawio >$p1
cat <$p2 >$fb
wait $pid
rm -f $p1
rm -f $p2
