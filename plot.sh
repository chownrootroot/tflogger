#!/bin/bash

function plotta {
	if [ -z "${strParam}" ]; then
		printf "%s\n" "Error parameter selected..." && exit 1
	fi

	strTitle=$(cat log.txt | head -n 1 | awk -F ";" "{print $"${strParam}"}")

	cat log.txt | awk -F ";" "{print $"${strParam}"}" | sed '1d' > ${strTitle}.ds && 		gnuplot -persist -e "plot '"${strTitle}.ds"' with lines"
	rm ${strTitle}.ds
}

function showhelp {
printf "%s\n" "TFlogger help"
printf "%s\n" "-p <par> | select parameter to plot"
printf "%s\n" "-a | plot all parameters"
printf "%s\n" "-h | show this text"
}

iAll=0
while [ -n "${1}" ]; do
	if [ "${1}" = "-p" ]; then
		shift
		strParam=${1}
	elif [ "${1}" = "-a" ]; then
		iAll=1
	elif [ "${1}" = "-h" ]; then
		showhelp
		exit 0
	fi
	shift
done


if [ "${iAll}" = "1" ]; then
	for i in {2..9}; do
		strParam=${i}
		plotta
	done
else
	plotta
fi



exit 0

