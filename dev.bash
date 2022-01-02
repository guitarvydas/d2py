./d2f.comp `realpath ~/app` helloworld 5>&1 &
pid1=$!
wait $pid1
