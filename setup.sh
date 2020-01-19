#!/bin/bash

TargetDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

TargetFiles=(.vimrc _gvimrc .vim)

echo "make link ..."
for target in ${TargetFiles[@]}
do
	ln -s -v ${TargetDir}${target} ${LinkDir}${target}
done

