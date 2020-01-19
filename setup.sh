#!/bin/bash

TargetDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

TargetFiles=(.vimrc _gvimrc .vim)

echo "# Make link ..."

for target in ${TargetFiles[@]}
do
	ln -s -v ${TargetDir}${target} ${LinkDir}${target}
done

echo "# Update bashrc ..."

AdditionalBashrc=${TargetDir}.bashrc
grep "${AdditionalBashrc}" ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
	echo "  nothing to do."
else
	echo "  add ${AdditionalBashrc} in ~/.bashrc."

	echo "# Load additional .bashrc." >> ~/.bashrc
	echo ". ${AdditionalBashrc}" >> ~/.bashrc
fi

