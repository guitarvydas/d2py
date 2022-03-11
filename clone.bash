#!/bin/bash

rm -rf node_modules
rm -rf prep
rm -rf d2f
rm -rf dr
rm -rf das2f
rm -rf das2j
rm -rf d2py


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
