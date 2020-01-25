#!/bin/bash

LinkedDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

LinkedTargets=(.vimrc _gvimrc .vim)

echo "[PROCESS] Generate link ..."

for target in ${LinkedTargets[@]}
do
	if [[  -L ${LinkDir}${target}  ]]; then
		echo "[INFO] Symbolic link exists ... unlink: ${LinkDir}${target}"
		unlink ${LinkDir}${target}
	fi

	if [[  -f ${LinkDir}${target}  ]]; then
		echo "[ABORT] File exists: ${LinkDir}${target}"
	else
		echo "[INFO] Generate symbolic link."
		ln -s -v ${LinkedDir}${target} ${LinkDir}${target}
	fi
done

echo "[PROCESS] Update bashrc ..."

BaseBashrc=~/.bashrc
AdditionalBashrc=${LinkedDir}.bashrc

grep "${AdditionalBashrc}" ${BaseBashrc} >/dev/null
if [ $? -eq 0 ]; then
	echo "[INFO] '${AdditionalBashrc}' is already setuped in '${BaseBashrc}'."
else
	echo "[INFO] Setup '${AdditionalBashrc}' in '${BaseBashrc}'."
	echo "" >> ${BaseBashrc}
	echo "# Additional .bashrc." >> ${BaseBashrc}
	echo "[ -f ${AdditionalBashrc} ] && source ${AdditionalBashrc}" >> ${BaseBashrc}
	echo "[INFO] Completed. Please reload ${BaseBashrc}."
fi

