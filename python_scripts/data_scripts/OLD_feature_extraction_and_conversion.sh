# Main Script
# Performs feature extraction and conversion of data to htk format
# Written by Cheryl Wang; modified by Aditya Vishwanath

# Set 1
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/tip_hand_dist 0,1,2; done

# convert ark to htk
for fileName in data/tip_hand_dist/ark/*.ark;do copy-feats-to-htk --output-dir=data/tip_hand_dist/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 2
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
# tip & hand distance delta (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/tip_hand_dist_delta 0,1,2,3; done

# convert ark to htk
for fileName in data/tip_hand_dist_delta/ark/*.ark;do copy-feats-to-htk --output-dir=data/tip_hand_dist_delta/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 3
# handPosition (6d)
# handPositionDelta (6d)
# thumb & hand distance (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/thumb_hand_dist 0,1,4; done

# convert ark to htk
for fileName in data/thumb_hand_dist/ark/*.ark;do copy-feats-to-htk --output-dir=data/thumb_hand_dist/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 4
# handPosition (6d)
# handPositionDelta (6d)
# thumb & hand distance (2d) 
# thumb & hand distance delta (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/thumb_hand_dist_delta 0,1,4,5; done

# convert ark to htk
for fileName in data/thumb_hand_dist_delta/ark/*.ark;do copy-feats-to-htk --output-dir=data/thumb_hand_dist_delta/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 5
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/tip_thumb_hand_dist 0,1,2,4; done

# convert ark to htk
for fileName in data/tip_thumb_hand_dist/ark/*.ark;do copy-feats-to-htk --output-dir=data/tip_thumb_hand_dist/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 6
# handPosition (6d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos 0; done

# convert ark to htk
for fileName in data/hand_pos/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



# Set 7
# handPositionDelta (6d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_delta 1; done

# convert ark to htk
for fileName in data/hand_pos_delta/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_delta/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



# Set 8
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d) 
# tip & hand delta (2d)
# thumb & hand delta(2d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_tip_thumb_delta 0,1,2,3,4,5; done

# convert ark to htk
for fileName in data/hand_pos_tip_thumb_delta/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_tip_thumb_delta/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



# Set 9
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d) 
# tip & hand delta (2d)
# thumb & hand delta(2d)
# hand orientation (8d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_orit_tip_thumb_delta 0,1,2,3,4,5,6; done

# convert ark to htk
for fileName in data/hand_pos_orit_tip_thumb_delta/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_orit_tip_thumb_delta/htk --output-ext=htk --sample-period=40000 ark:$fileName; done

# Set 10
# handPosition (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_tip_thumb 0,2,4; done

# convert ark to htk
for fileName in data/hand_pos_tip_thumb/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_tip_thumb/htk --output-ext=htk --sample-period=40000 ark:$fileName; done

# Set 11
# handPosition (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d)
# handRoll (2d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_tip_thumb_roll 0,2,4,7; done

# convert ark to htk
for fileName in data/hand_pos_tip_thumb_roll/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_tip_thumb_roll/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



# Set 12
# handPosition (6d)
# handPositionDelta (6d)
# tip & hand distance (2d) 
# thumb & hand distance (2d) 
# tip & hand delta (2d)
# thumb & hand delta(2d)
# handRoll (2d)
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_pos_tip_thumb_delta_roll 0,1,2,3,4,5,7; done

# convert ark to htk
for fileName in data/hand_pos_tip_thumb_delta_roll/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_pos_tip_thumb_delta_roll/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



# Set 13
# handPosition (6d)
# shoulder -> elbow vector (6d)
# elbow -> hand vector (6d)
# left -> right hand vector (3d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/hand_body_pos 0,8,9,10; done

# convert ark to htk
for fileName in data/hand_body_pos/ark/*.ark;do copy-feats-to-htk --output-dir=data/hand_body_pos/htk --output-ext=htk --sample-period=40000 ark:$fileName; done


# Set 14
# shoulder -> elbow vector (6d)
# elbow -> hand vector (6d)
# left -> right hand vector (3d) 
for fileName in data/txt/thad*/*.txt; do python feature_extraction.py $fileName data/body_pos 8,9,10; done

# convert ark to htk
for fileName in data/body_pos/ark/*.ark;do copy-feats-to-htk --output-dir=data/body_pos/htk --output-ext=htk --sample-period=40000 ark:$fileName; done



