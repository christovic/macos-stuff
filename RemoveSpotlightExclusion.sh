#!/bin/bash

# We can find the index of the item in the array by extracting the key, finding the lines with
# 'string' in them, and then finding the search string.
cd /System/Volumes/Data/.Spotlight-V100

search_string=$1

let index="`plutil -extract Exclusions xml1 -o - VolumeConfiguration.plist  | grep string | grep -wn "${search_string}" | cut -d ':' -f 1` - 1"

echo The index of $search_string is $index

if [ $index -lt 0 ]; then
	echo Not in array, not doing anything.
else
	echo Found $search_string in array, removing it
	plutil -remove Exclusions.${index} /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist
fi

# Now we restart mds to apply the changes

launchctl stop com.apple.metadata.mds && launchctl start com.apple.metadata.mds
