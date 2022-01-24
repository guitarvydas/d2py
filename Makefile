all: clean
	clean
	./build.bash

clean:
	rm -f layer*
	rm -f preprocessed*
	rm -f out.json

npmstuff: ../node_modules/ohm-js ../node_modules/yargs ../node_modules/yargs-parser ../node_modules/atob ../node_modules/pako
	cd ..
	npm install ohm-js yargs atob pako

