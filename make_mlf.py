fileName="lists/tip_thumb_hand_dist.train"

f = open(fileName,"r") 
output= open("all_labels.mlf",'w')
output.write("#!MLF!#\n")
for line in f:
	split_end=line.split("/")
	end_str=split_end[-1]
	split_str=end_str.split(".")[0]
	#output.write('"*/',split_str,".lab")
	output.write("%s%s%s\n" % (('"*/'),(split_str),('.lab"')))
	#output.write("sil\n")
	new=split_str.split("_")
	if new[-2]=='other':
		for m in range(2, len(new)-2):
			new[m], new[m+1]=new[m+1], new[m]
	#print new, " len of new : ", len(new)
	output.write("%s\n" % (new[1]))
	for i in new[2:len(new)-3]:		
		output.write("%s_" % (i))
	output.write("%s" % (new[len(new)-3]))				
	output.write("\n%s\n" % (new[len(new)-2]))
	#output.write("sil\n")
	output.write(".\n")
	print split_str
