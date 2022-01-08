#!/bin/bash

LinkedDir=$(cd $(dirname $0); pwd)/
LinkDir=~/

LinkedTargets=(.vim .vimrc _gvimrc .tmux.conf .ripgreprc)

echo "Generate link..."

for target in ${LinkedTargets[@]}
do
	if [[  -L ${LinkDir}${target}  ]]; then
		echo "    Symbolic link exists...unlink: ${LinkDir}${target}"
		unlink ${LinkDir}${target}
	fi

	if [[  -f ${LinkDir}${target}  ]]; then
		echo "    [ABORT] File exists: ${LinkDir}${target}"
	else
		echo "    Generate symbolic link...${LinkDir}${target} -> ${LinkedDir}${target}"
		ln -s ${LinkedDir}${target} ${LinkDir}${target}
	fi
done

echo "Update bashrc..."

BaseBashrc=~/.bashrc
AdditionalBashrc=${LinkedDir}.bashrc

grep "${AdditionalBashrc}" ${BaseBashrc} >/dev/null
if [ $? -eq 0 ]; then
	echo "    '${AdditionalBashrc}' is already setuped in '${BaseBashrc}'."
else
	echo "    Setup '${AdditionalBashrc}' in '${BaseBashrc}'."
	echo "" >> ${BaseBashrc}
	echo "# Additional .bashrc." >> ${BaseBashrc}
	echo "[ -f ${AdditionalBashrc} ] && source ${AdditionalBashrc}" >> ${BaseBashrc}
	echo "    Completed. Please reload ${BaseBashrc}."
fi

