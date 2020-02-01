###############################################################################
#
# Argument 1: name of the feature sets
# Argument 2: feature vector dimension
#
###############################################################################

###
# NOTE: To run all of this:
# First run this file
# Then run the testing_script.sh file to get timstamped mlf files in results directory
# Then copy over the timestamps mlf file to top-level directory
# Modify the HRest and HERest code below: change all -I flags to use the new .mlf file that has timestamps
# Then run this same training file again and then run testing again
###

# Training Script for Verification System
# Cheryl Wang

FEATURESET=$1
FVECTOR=$2
# MIXTURE=$3

# Prepare Prototype for hand_pos_3s
python python_scripts/gen_prototype.py 6 ${FVECTOR} models/prototype

echo "-------------- Training HMM --------------"

echo "Training starts now!"
trFile=lists/${FEATURESET}.train
# tsFile=lists/${FEATURESET}.test
echo "after trfile is loaded"
###############################################################################
# HMM training
###############################################################################

# Prepare the folder for model
MODELFOLDER=models/
if [ ! -e "${MODELFOLDER}" ]; then
  mkdir $MODELFOLDER
fi

for((k=0; k<=18; k++))
do
  HMMFOLDER=${MODELFOLDER}/hmm${k}
  if [ ! -e "$HMMFOLDER" ]; then
    mkdir $HMMFOLDER
  fi
done

echo "hcompv will start"
# Initialization of the model (Flat Start)
HCompV -A -T 2 -C configs/hcompv.conf -v 2.0 -f 0.01 -m -S ${trFile} -M ${MODELFOLDER}/hmm0 models/prototype >> log/${FEATURESET}.log
python python_scripts/gen_init_models_each_word.py ${MODELFOLDER}/hmm0 wordList

cat wordList | while read n
do
  # echo $n
  #HRest -i 60 -l $n -C configs/hcompv.conf -m 1 -t -v 0.2 -A -L train-labels -M ${MODELFOLDER}/hmm1 -S ${trFile} -T 1 ${MODELFOLDER}/hmm0/$n >> log/${FEATURESET}.log
  HRest -i 60 -C configs/hcompv.conf -v 0.2 -A -I all_labels.mlf -M ${MODELFOLDER}/hmm1 -S ${trFile} ${MODELFOLDER}/hmm0/$n >> log/${FEATURESET}.log
done

#MODELFOLDER=models
# echo "HERest Iteration 1"
#HERest -d ${MODELFOLDER}/hmm1 -m 1 -v 0.001 -A -L train-labels -M ${MODELFOLDER}/hmm2 -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log
HERest -d ${MODELFOLDER}/hmm1 -v 0.001 -A -I all_labels.mlf -M ${MODELFOLDER}/hmm2 -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log

count=2
# Re-estimate 6 more times
while [[ $count -lt 8 ]]
  do
    # echo "HERest Iterating ${count}"
    #HERest -v 0.001 -m 1 -A -H ${MODELFOLDER}/hmm${count}/newMacros -L train-labels -M ${MODELFOLDER}/hmm$((count+1)) -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log
    HERest -v 0.001 -A -H ${MODELFOLDER}/hmm${count}/newMacros -I all_labels.mlf -M ${MODELFOLDER}/hmm$((count+1)) -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log
    count=$((count+1))
  done

# increase mixture to 2
HHEd -H ${MODELFOLDER}/hmm8/newMacros -M ${MODELFOLDER}/hmm9 configs/hhed.conf wordList

count=9
# Re-estimate 9 more times
while [[ $count -lt 18 ]]
  do
    # echo "HERest Iterating ${count}"
    #HERest -v 0.001 -m 1 -A -H ${MODELFOLDER}/hmm${count}/newMacros -L train-labels -M ${MODELFOLDER}/hmm$((count+1)) -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log
    HERest -v 0.001 -A -H ${MODELFOLDER}/hmm${count}/newMacros -I all_labels.mlf -M ${MODELFOLDER}/hmm$((count+1)) -S ${trFile} -T 1 wordList >> log/${FEATURESET}.log
    count=$((count+1))
  done

echo "Traning complete!"

echo "Now we will create the word net"
HParse -A -D -T 1 -C configs/hp.conf grammar.txt wordNet.txt
