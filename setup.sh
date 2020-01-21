#!/bin/bash

TargetDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

TargetFiles=(.vimrc _gvimrc .vim)

echo "[PROCESS] Make link ..."

for target in ${TargetFiles[@]}
do
	if [[  -L ${LinkDir}${target}  ]]; then
		echo "[INFO] Symbolic link exists...unlink: ${LinkDir}${target}"
		unlink ${LinkDir}${target}
	fi

	if [[  -f ${LinkDir}${target}  ]]; then
		echo "[ABORT] File exists: ${LinkDir}${target}"
	else
		echo "[INFO] Create symbolic link."
		ln -s -v ${TargetDir}${target} ${LinkDir}${target}
	fi
done

echo "[PROCESS] Update bashrc ..."

AdditionalBashrc=${TargetDir}.bashrc
grep "${AdditionalBashrc}" ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
	echo "[INFO] '${AdditionalBashrc}' is already setup in '~/.bashrc'."
else
	echo "[INFO] Setup '${AdditionalBashrc}' in '~/.bashrc'."

	echo "" >> ~/.bashrc
	echo "# Load additional .bashrc." >> ~/.bashrc
	echo ". ${AdditionalBashrc}" >> ~/.bashrc
fi

