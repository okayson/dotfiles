#!/bin/bash

LinkedDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

LinkedTargets=(.vimrc _gvimrc .vim)

echo "[PROCESS] Make link ..."

for target in ${LinkedTargets[@]}
do
	if [[  -L ${LinkDir}${target}  ]]; then
		echo "[INFO] Symbolic link exists...unlink: ${LinkDir}${target}"
		unlink ${LinkDir}${target}
	fi

	if [[  -f ${LinkDir}${target}  ]]; then
		echo "[ABORT] File exists: ${LinkDir}${target}"
	else
		echo "[INFO] Create symbolic link."
		ln -s -v ${LinkedDir}${target} ${LinkDir}${target}
	fi
done

echo "[PROCESS] Update bashrc ..."

BaseBashrc=~/.bashrc
AdditionalBashrc=${LinkedDir}.bashrc

grep "${AdditionalBashrc}" ${BaseBashrc} >/dev/null
if [ $? -eq 0 ]; then
	echo "[INFO] '${AdditionalBashrc}' is already setup in '${BaseBashrc}'."
else
	echo "[INFO] Setup '${AdditionalBashrc}' in '${BaseBashrc}'."
	echo "" >> ${BaseBashrc}
	echo "# Load additional .bashrc." >> ${BaseBashrc}
	echo ". ${AdditionalBashrc}" >> ${BaseBashrc}
	echo "[INFO] Please type '. ${AdditionalBashrc}' to reflect. "
fi

