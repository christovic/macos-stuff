#!/bin/bash

cd /System/Volumes/Data/.Spotlight-V100

# First let's check if the directory we're adding already exists

search_string=$1

let index="`plutil -extract Exclusions xml1 -o - VolumeConfiguration.plist  | grep string | grep -wn "${search_string}" | cut -d ':' -f 1` - 1"

if [ $index -lt 0 ]; then
	echo Not in array, let\'s add it in.
	plutil -insert Exclusions.0 -string ${search_string} /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist
else
	echo Already in array, not doing anything.
fi

# Now we restart mds to apply the changes

launchctl stop com.apple.metadata.mds && launchctl start com.apple.metadata.mds
