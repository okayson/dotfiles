#!/bin/bash

TargetDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

TargetFiles=(.vimrc _gvimrc .vim)

echo "make link ..."
for target in ${TargetFiles[@]}
do
	echo "${LinkDir}${target} -> ${TargetDir}${target}"
	ln -s ${TargetDir}${target} ${LinkDir}${target}
done

exit

