import sys

if len(sys.argv) != 3:
    print "Usage: gen_init_models.py hmm0Folder wordlist"
    exit

# read prototype file
prototypeFile = open(sys.argv[1] + '/prototype', 'r')
prototypeStr = prototypeFile.read().strip("\r\n")

wordListFile = open(sys.argv[2], 'r')


for word in wordListFile:
    word = word.strip("\r\n")
    hmmFile = open(sys.argv[1] + "/" + word, 'w')
    print >> hmmFile, prototypeStr.replace("prototype", word)