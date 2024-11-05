#!/bin/bash

#change txt -> csv
input_file="GPU_CPU_log.txt"
output_file="log.csv"

#csv format
header="Timestamp"
gpu_count=$(grep -o "GPU[0-9]" "$input_file" | sort -u | wc -l)
for ((i=0; i<gpu_count; i++)); do
  header+=",GPU${i}_Temp,GPU${i}_Util"
done
header+=",CPU0_Temp,CPU1_Temp"
echo "$header" > "$output_file"

#Check CPU model
is_amd=$(lscpu | grep -i 'amd' | wc -l)

#format csv
tail -n +2 "$input_file" | while read -r line; do
  #get timestamp csv format
  timestamp=$(echo "$line" | awk -F', ' '{print $1}')

  #get GPU temp, Util csv format
  gpu_data=""
  for ((i=0; i<gpu_count; i++)); do
    # 각 GPU에 대한 온도와 전력 사용량 및 최대 전력 값 추출
    temp=$(echo "$line" | grep -oP "GPU${i}, \K\d+(?=C)")
    power_draw=$(echo "$line" | grep -oP "GPU${i}, \d+C, \K\d+\.\d+(?=W)")
    power_limit=$(echo "$line" | grep -oP "GPU${i}, \d+C, \d+\.\d+W / \K\d+\.\d+")

    if [[ -n "$temp" && -n "$power_draw" && -n "$power_limit" ]]; then
      gpu_data+="$temp,$power_draw/$power_limit,"
    else
      gpu_data+=",,"
    fi
  done

  #get CPU temp csv format
  if [ "$is_amd" -gt 0 ]; then
    #AMD CPU Tctl 
    cpu_data=$(echo "$line" | grep -oP 'Tctl, \+\K\d+\.\d+(?=°C)' | tr '\n' ',' | sed 's/,$//')
  else
    #Intel CPU Package id
    cpu_data=$(echo "$line" | grep -oP 'Package, \+\K\d+\.\d+(?=°C)' | tr '\n' ',' | sed 's/,$//')
  fi

  #record csv file
  echo "$timestamp,$gpu_data$cpu_data" >> "$output_file"
done

echo "Conversion to CSV completed. Check $output_file for results."

