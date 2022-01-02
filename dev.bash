# ./d2f.comp `realpath ~/app` helloworld 5>&1 &
# pid1=$!
# wait $pid1


./das2f.comp `realpath ~/app` helloworld `realpath ./d2f.comp` 6>&1
pid1=$!
wait $pid1
