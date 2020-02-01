import sys

if len(sys.argv) != 4:
    print "Usage: gen_prototype.py numOfState vecSize outputFile"
    exit

numOfState = sys.argv[1]
vecSize = sys.argv[2]
prototypeFile = open(sys.argv[3], 'w')

print >> prototypeFile, '~o <vecSize> ' + vecSize + ' <USER>'
print >> prototypeFile, '~h "prototype"\n' +\
                        '<BEGINHMM>\n' +\
                        '<NUMSTATES> ' + numOfState

# mean & variance
state = 2
while state < int(numOfState):
    print >> prototypeFile, '<STATE> ' + str(state) + '\n' +\
                            '<MEAN> ' + vecSize
    meanStr = ''
    for i in range(int(vecSize)):
        meanStr = meanStr + '0.0 '
    print >> prototypeFile, meanStr

    print >> prototypeFile, '<Variance> ' + vecSize
    varStr = ''
    for i in range(int(vecSize)):
        varStr = varStr + '1.0 '
    print >> prototypeFile, varStr
    state = state + 1

# trans probability
print >> prototypeFile, '<TransP> ' + numOfState
for i in range(int(numOfState)):
    str = ""
    for j in range(int(numOfState)):
        if j < i:
            str = str + '0.0 '
        elif i == j:
            if i == 0 or i == int(numOfState) - 1:
                str = str + '0.0 '
            else:
                str = str + '0.6 '
        elif j == i + 1:
            if i == 0:
                str = str + '1.0 '
            else:
                str = str + '0.4 '
        else:
            str = str + '0.0 '
    print >> prototypeFile, str

print >> prototypeFile, '<EndHMM>'
