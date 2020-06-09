#!/bin/bash

strLogPath="${HOME}/bin/git/tflogger/log.txt"
strResPath="${HOME}/bin/git/tflogger/result.txt"

if [ -f "${strLogPath}" ]; then
    printf "%s\n" "Logfile found..."
else
    printf "%s\n" "Logfile not found. Creating..."
    printf "%s;%s;%s;%s;%s;%s;%s;%s;%s\n" "Time" "CPU" "Core0" "Core1" "Core2" "Core3" "GPU" "ProcFan" "VideoFan" > ${strLogPath} 
fi

while true; do
    sensors > ${strResPath}
    strCPUTemp=$(cat ${strResPath} | grep "CPU:" | awk '{print $2}')
    strCore0Temp=$(cat ${strResPath} | grep "Core 0:" | awk '{print $3}')
    strCore1Temp=$(cat ${strResPath} | grep "Core 1:" | awk '{print $3}')
    strCore2Temp=$(cat ${strResPath} | grep "Core 2:" | awk '{print $3}')
    strCore3Temp=$(cat ${strResPath} | grep "Core 3:" | awk '{print $3}')
    strGPUTemp=$(cat ${strResPath} | grep temp1 | awk '{print $2}')
    strProcFan=$(cat ${strResPath} | grep "Processor Fan" | awk '{print $3}')
    strVideoFan=$(cat ${strResPath} | grep "Video Fan" | awk '{print $3}')
    rm ${strResPath}

    printf "%s;%s;%s;%s;%s;%s;%s;%s;%s\n" "$(date +%Y-%m-%d" "%H:%M:%S)" "${strCPUTemp}" "${strCore0Temp}" "${strCore1Temp}" "${strCore2Temp}" "${strCore3Temp}" "${strGPUTemp}" "${strProcFan}" "${strVideoFan}" >> ${strLogPath}
    sleep 10
done 

exit 0
