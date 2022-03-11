Diagram To Python Transpiler
## Synopsis
Transpile a drawing to running Python code.

The drawing is `helloworld.drawio`.

The generated code is run by `./top.py` on the command line.

The rest of this README describes 
1. how to read the diagram
2. how to use `run.bash` to transpile the diagram to Python.

## Install and Run
```
sudo apt-get install swi-prolog
sudo apt-get install git
nvm install 14.9.0
```
```
cp d2py/clone.bash .
chmod a+x clone.bash
./clone.bash
cd d2py
make
```

This should generate a bunch of things, then use them and culminate in running `top.py`.

(clone.bash should do the following:
```
npm install ohm-js yargs atob pako
git clone git@github.com:guitarvydas/dr.git
git clone git@github.com:guitarvydas/prep.git
git clone git@github.com:guitarvydas/d2f.git
git clone git@github.com:guitarvydas/das2f.git
git clone git@github.com:guitarvydas/das2j.git
git clone git@github.com:guitarvydas/d2py.git
```
)

To view the source code diagram:
- start up a browser
- go to diagrams.net
- open, choose start, save to device
- open existing diagram d2py/helloworld.drawio

## HelloWorld .drawio
![[helloworld.svg]]
The `app` is called `helloworld`.
It contains two `Components`.`
Components` are `asynchronous` by default - they run at any time and in any order.
`Components` have inputs and outputs. 
Inputs are green round circles and outputs are yellow round circles.
Red boxes are used for defining `synchronous` instructions.  Synchronous boxes run instructions run from the top to the bottom, sequentially and cannot be interrupted.
Arrows show `message` flows between outputs and inputs.

## Example
In this example diagram
- We create two Components called `hello` and `world`.
- We put Python code inside the `Components`.
- We string the two `Components` together with an `arrow`.  The `arrow` flows from `hello/out` to `world/in`.
- The `app` is called `helloworld`.  It has one input called `start`.
- When we send a message (any message) to `helloworld/start`
	1. The message is forwarded to `hello/in`.
	2. `Hello` does its thing, then sends a message to it `hello/out` port.
	3. When a message arrives at the `world/in` port, `world` does its thing.
	4. Then the app stops.  (Nothing else happens).

## Layers
### Top
![[helloworld-Top Level.svg]]
### Two Components
![[helloworld-Two Components.svg]]
### Inside Hello
![[helloworld-Inside Hello.svg]]
### Inside World
![[helloworld-Inside World.svg]]
### Message Routing
The routing table belongs to `helloworld`.

`Hello` cannot send messages directly to `world` and v.v.
![[helloworld-Message Routing.svg]]
## Run.bash
![[run.svg]]
Green circles are inputs.
Purple circles are functions/scripts (names of scripts).
The red box is synchronous code.
The purple box is an `Apply` operator that invokes the various input scripts (C,D and E)
Gray boxes are hard-wired inputs witten into run.bash[^1].
[^1]: In essence, run.bash is like a test-harness that runs the component *das2py*.
The Gray database ("out.json") is a JSON file created by the `@das2j` process.
The yellow databases are the generated files[^2].
[^2]: In a fully-componentized system, these would probably be outputs, but this example is a POC (Proof of Concept) which used existing tools (e.g. *bash* and the filesystem)
The letters A/B/C/D/E are notes-to-self that relate to the text code of run.bash.
Arrows are `ducts` that connect ports and operators.  In `bash`, we can implement `ducts` as pipes (see `mkfifo`) and in other cases, we might implement ducts as sockets.  Sometimes, we might choose to implement `ducts` as function calls[^3].
[^3]: But! Be careful.  Ducts are asynchronous message paths and functions are synchronous.  For ideas on how to implement asynchronous messaging using function calls see [Call/Return Spaghetti](https://guitarvydas.github.io/2020/12/09/CALL-RETURN-Spaghetti.html)
## Bash Code
```

clear
ductA=ductA_$RANDOM
ductB=ductB_$RANDOM
ductC=ductC_$RANDOM
ductD=ductD_$RANDOM
ductE=ductE_$RANDOM
mkfifo $ductA $ductB $ductC $ductD $ductE
root=`realpath ../`

./das2py.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7<$ductE &
pid1=$!
echo $root >$ductA &
echo helloworld.drawio >$ductB &
realpath ./d2f.comp >$ductC &
realpath ./das2f.comp >$ductD &
realpath ./das2j.comp >$ductE &
wait $pid

rm -f $ductA $ductB $ductC $ductD $ductE

echo
echo RUNNING top.py '...'
chmod +x top.py
./top.py
```
The above code implements the diagram.

Note:
- ducts are implemented as pipes using `mkfifo`. We give each duct a RANDOM name.
- We must use `&` to spin off the `das2py.comp` component.  To send data to the `das2py` component, we must, also, use `&`[^4].
[^4]: This is, actually an illustration of how wiring non-atomic concepts into basic technology results in bloatware.  Rendezvous is a molecule, not an atom.  Bash has Rendezvous hard-wired into it, and, this means that we had to imagine clever ways to circumvent the unwanted molecule to get at the atomic construct (asynchronous processes).

The real work is done in 1 line - 
```
./das2py.comp 3<$ductA 4<$ductB 5<$ductC 6<$ductD 7<$ductE &
```
This line invokes the `Component` called *das2py.comp*.  This line connects 5 ducts as inputs (A-E) and connects 0 outputs.  The `Component` is spun off in a fork (`&`), then we send data to the component by writing it to the appropriate ducts[^5].
[^5]: Each data send is suffixed by `&` lest `run.bash` gets hung waiting for the `das2py.comp` to start.  This circuments the problem of automatically getting synchronous behaviour when we didn't want it.

## Github
[d2py (branch main)](https://github.com/guitarvydas/d2py)

[design rule checker](https://github.com/guitarvydas/dr)
[d2f](https://github.com/guitarvydas/d2f)
[das2f](https://github.com/guitarvydas/das2f)
[das2j](https://github.com/guitarvydas/das2j)
[prep](https://github.com/guitarvydas/prep)
npm install ohm-js atob pako yargs

The documentation starts at README.md.

Use Obsidian to view README.md.

Pull all of the above directories into the same working directory.  

- cd into the `d2py` directory.
- Run `make`
- Run `make exec`

### Get.bash
```
#!/bin/bash
npm install ohm-js yargs atob pako
# prep - pattern matching tool
git clone git@github.com:guitarvydas/prep.git
# d2f - diagrams to factbase
git clone git@github.com:guitarvydas/d2f.git
# dr - design rule checker
git clone git@github.com:guitarvydas/dr.git
# das2f - diagrams, parsed to factbase
git clone git@github.com:guitarvydas/das2f.git
# das2j - diagrams, parsed to JSON
git clone git@github.com:guitarvydas/das2j.git
# d2py - diagrams, parsed to Python
git clone git@github.com:guitarvydas/d2py.git
```

## Auxiliary Files
`mpos.py` and `dispatcher.py` were manually written for this POC.

`Mpos.py` (message-passing O/S) implements `Component` details.

`Dispatcher.py` implements multi-tasking between components.  The article [Call/Return Spaghetti](https://guitarvydas.github.io/2020/12/09/CALL-RETURN-Spaghetti.html) can be used to understand the basics of what is going on.  Notice that `multi-tasking` does *not* have to mean *isolation* between `Components`.  *Isolation* is a feature of multi-purpose operating systems like Linux, Windows and MacOS[^6].
[^6]: A program that contains bugs contains bugs.  It doesn't matter if the bug was caused by multi-tasking or a typo or anything else.  During Design, programmers would prefer to Isolate components to help Design and to help in tracking down bugs.  In Production Engineering, programmers might remove Isolation to gain speed and to reduct hardware costs.

## Version
This documentation relates to the tagged version `rel1.0` and is further documented in [blog](https://guitarvydas.github.io/2022/01/25/Diagram-to-Python-Transpiler.html)
