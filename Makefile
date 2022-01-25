NODEMODULES=\
	../node_modules/ohm-js \
	../node_modules/yargs \
	../node_modules/atob \
	../node_modules/pako

all: $(NODEMODULES) build

../node_modules/ohm-js:
	(cd .. ; npm install ohm-js)
../node_modules/yargs:
	(cd .. ; npm install yargs)
../node_modules/atob:
	(cd .. ; npm install atob)
../node_modules/pako:
	(cd .. ; npm install pako)

build:
	(cd ../dr ; make)
	(cd ../prep ; make)
	(cd ../d2f ; make)
	(cd ../das2f ; make)
	(cd ../das2j ; make)
	./generate.bash

exec:
	./top.py

clean:
	(cd ../dr ; make clean)
	(cd ../prep ; make clean)
	(cd ../d2f ; make clean)
	(cd ../das2f ; make clean)
	(cd ../das2j ; make clean)
	rm -f layer*
	rm -f preprocessed*
	rm -f duct?_*
	rm -f out.json
	rm -rf _*
	rm -f *~

npmstuff: ../node_modules/ohm-js ../node_modules/yargs ../node_modules/yargs-parser ../node_modules/atob ../node_modules/pako
	cd ..
	npm install ohm-js yargs atob pako

