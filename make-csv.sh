#!/bin/bash

# 원본 텍스트 파일과 출력 CSV 파일 지정
input_file="GPU_CPU_log.txt"
output_file="log.csv"

# 첫 번째 줄에서 동적으로 헤더 생성
header="Timestamp"
gpu_count=$(grep -o "GPU[0-9]" "$input_file" | sort -u | wc -l)
for ((i=0; i<gpu_count; i++)); do
  header+=",GPU${i}_Temp,GPU${i}_Util"
done
header+=",CPU0_Temp,CPU1_Temp"
echo "$header" > "$output_file"

# CPU가 AMD인지 확인
is_amd=$(lscpu | grep -i 'amd' | wc -l)

# 데이터 행 변환 및 CSV 파일에 저장
tail -n +2 "$input_file" | while read -r line; do
  # 타임스탬프 추출
  timestamp=$(echo "$line" | awk -F', ' '{print $1}')

  # 각 GPU의 온도와 사용 전력/최대 전력 추출
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

  # CPU 온도 추출 (AMD: Tctl, Intel: 각 소켓의 Package id)
  if [ "$is_amd" -gt 0 ]; then
    # AMD CPU: Tctl 값 추출
    cpu_data=$(echo "$line" | grep -oP 'Tctl, \+\K\d+\.\d+(?=°C)' | tr '\n' ',' | sed 's/,$//')
  else
    # Intel CPU: 각 소켓의 Package id 값 추출
    cpu_data=$(echo "$line" | grep -oP 'Package, \+\K\d+\.\d+(?=°C)' | tr '\n' ',' | sed 's/,$//')
  fi

  # 결과를 CSV 파일에 저장
  echo "$timestamp,$gpu_data$cpu_data" >> "$output_file"
done

echo "Conversion to CSV completed. Check $output_file for results."

