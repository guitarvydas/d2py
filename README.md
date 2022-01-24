Diagram To Python Transpiler

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
## Run.bash
