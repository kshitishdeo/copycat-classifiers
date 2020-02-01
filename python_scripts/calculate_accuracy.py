import sys
import re

if len(sys.argv) != 2:
    print "Usage: calAccuCrossVal.py resFileFromHResults"
    exit

resFile = open(sys.argv[1], "r")

corr = []
sub = []
delrate = []
ins = []
phraseErr = []
sentErr = []

wordList = ["bed", "snak", "unde"]

# Initialization
countDict = {}
for i in range(len(wordList)):
    newDict = {}
    for j in range(len(wordList)):
        newDict[wordList[j]] = 0
    countDict[wordList[i]] = newDict

while True:
    line = resFile.readline()
    line = line.strip("\r\n")
    if line == "": break

    #     | Sum/Avg |   41  |  42.59  33.33  24.07   0.00  57.41  82.93 |
    if "Sum/Avg" in line:
        resArray = re.findall(r'[\d\.\d]+', line)
        corr.append(float(resArray[1]))
        sub.append(float(resArray[2]))
        delrate.append(float(resArray[3]))
        ins.append(float(resArray[4]))
        phraseErr.append(float(resArray[5]))
        sentErr.append(float(resArray[6]))

    # process confusion matrixs
    if "Confusion Matrix" in line:
        # first 5 lines
        # print line
        for i in range(5):
            line = resFile.readline()
            # print line

        line = resFile.readline().strip()
        line = line.split("    ")[0]
        tempCountDict = {}
        while line[:3] != "Ins": #last word
            segments = line.split("   ")
            tempCountDict[segments[0]] = segments[1:]
            line = resFile.readline().strip()
            line = line.split("    ")[0]

        # Mapping temp count dictionary to count dictionary
        words = sorted(tempCountDict.keys())
        for w in words:
            if len(words) != len(tempCountDict[w]):
                continue
            # print tempCountDict[w]
            for iw in range(len(words)):
                countDict[w][words[iw]] = int(tempCountDict[w][iw]) + int(countDict[w][words[iw]])



print ""
print "-------------- Performing Recognition for " + sys.argv[1] + "-------------- "
print "Corr    Sub    Del    Ins    Err    S. Err"
print str(sum(corr)/float(len(corr))) + "\t" +\
      str(sum(sub)/float(len(sub))) + "\t" +\
      str(sum(delrate)/float(len(delrate))) + "\t" +\
      str(sum(ins)/float(len(ins))) + "\t" +\
      str(sum(phraseErr)/float(len(phraseErr))) + "\t" +\
      str(sum(sentErr)/float(len(sentErr)))

print '--------- Confusion Matrix ----------------'
print "		" + "	".join(sorted(countDict.keys()))
for key in sorted(countDict.keys()):
    output = key + "	"
    for w in sorted(countDict.keys()):
        output = output + "	" + str(countDict[key][w])
    print output