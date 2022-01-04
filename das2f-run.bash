# usage: run-fb-pipeline.bash pipe
das2fdir=$1

echo '** factbase pipeline **' 1>&2

# # Layer 0. Convert helloword.drawio into factbase format using d2f.
# echo '** layer 0 (helloworld.drawio --> fb.pl) **' 1>&2
## lifted ... # d2f $1 >fb.pl

# We will store the factbase in a file called fb.pl
# We will augment fb.pl in each step along the way.
# Future: we might be able to rewrite this script to use a pipeline instead of intermediate files (e.g. fb.pl)


# Layer 1. Infer low-hanging fruit information.
echo '** layer 1 **' 1>&2
${das2fdir}/layerkind ${das2fdir} 1>&2 # <<>>fb.pl

# #############
# # input from fb.pl
# # output augments fb.pl
# set -x
# temp=_temp_${RANDOM}
# temp2=_temp_${RANDOM}

# ### move result into fb.pl (without overwrite problems)
# temp=temp_${RANDOM}

# # old ./layer3-body >${temp}
# # new
# ${das2fdir}/layerkind_query.bash >${temp}

# ${das2fdir}/appendToFb ${temp}

# rm -f ${temp}

# #############


echo early early exit
exit 1

${das2fdir}/layername ${das2fdir} 1>&2 # <<>>fb.pl
${das2fdir}/layercolor ${das2fdir} 1>&2 # <<>>fb.pl
${das2fdir}/layerboundingbox ${das2fdir} 1>&2 # <<>>fb.pl

# # Layer 2. Names, port directions
echo '** layer 2 **' 1>&2
${das2fdir}/layerdirection ${das2fdir} 1>&2 # <<>>fb.pl
#${das2fdir}/layer2  1>&2 #<<>>fb.pl



# Layer 3. Rectangle Containment relationships.
echo '** layer all contains **'  1>&2
${das2fdir}/layerallcontains ${das2fdir} 1>&2 #<<>>fb.pl


# Layer 4. Rectangle contains Port.
echo '** layer 4 **' 1>&2
${das2fdir}/layer4 ${das2fdir} 1>&2 #<<>>fb.pl

# Layer 5. indirect containment
echo '** layer 5 - indirect containment **' 1>&2
${das2fdir}/layer5 ${das2fdir} 1>&2 #<<>>fb.pl

# Layer 6. direct containment
echo '** layer 6 - direct containment **' 1>&2
${das2fdir}/layer6 ${das2fdir} 1>&2 #<<>>fb.pl

# Layer edge containment 1
echo '** layer edge containment 1 **' 1>&2
${das2fdir}/layeredgecontainment1 ${das2fdir} 1>&2 #<<>>fb.pl

# Layer edge containment 2
echo '** layer edge containment 2 **' 1>&2
${das2fdir}/layeredgecontainment2 ${das2fdir} 1>&2 #<<>>fb.pl
# Layer edge containment 3
echo '** layer edge containment 3 **' 1>&2
${das2fdir}/layeredgecontainment3 ${das2fdir} 1>&2 #<<>>fb.pl



# Layer Synccode.
echo '** layer synccode **' 1>&2
${das2fdir}/layersynccode ${das2fdir} 1>&2 #<<>>fb.pl

# Layer Connections.
echo '** layer connections **' 1>&2
${das2fdir}/layerconnection ${das2fdir} 1>&2 #<<>>fb.pl




echo '** checking design rule **' 1>&2


# # Design Rule - all ports (ellipses) must have a direction
# echo '** design rule for layer 2 **'
# ./design_rule_layer2  1>&2

dr=~/projects/dr
mdfile=${dr}/dr-edgecontainment.md
fname=`basename -s '.md' $mdfile`
temp=temp_${RANDOM}

${das2fdir}/a-${fname} | ${das2fdir}/b-${fname} 2> $temp

#./check-errors.bash
if grep -q failure <$temp
then
    echo
    cat $temp 1>&2
    echo quitting 1>&2
    rm $temp
    exit 1
fi
rm $temp

echo '** finished checking design rule **' 1>&2

