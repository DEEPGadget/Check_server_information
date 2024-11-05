#!/bin/bash

# 인자 확인
if [ $# -ne 2 ]; then
  echo "Usage: $0 <interval> <duration>"
  exit 1
fi

interval=$1
duration=$2
end_time=$((SECONDS + duration))

echo "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣿⣿⠿⠿⠿⠤⠤⠤⠽⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣿⣏⣉⣉⣉⣉⣉⣉⣉⣉⣉⣙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣓⣒⣒⣶⣿⣿⣿⣿⣿⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⡟⠉⣀⣈⠙⠇⢸⠋⢉⣀⣈⠙⢿⡟⠉⣀⣀⠉⠻⡿⠋⢉⣀⣈⠙⢿⣿⣿⣿⡿⠋⢉⣀⣈⠙⢿⡿⠋⣁⣀⡉⠛⣿⠛⢉⣀⣈⠛⠀⡿⠋⣁⣀⡈⠙⣿⠟⠉⣀⣀⠉⠻⡇⢈⣉⣉⣉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣭⣭⣭⣿⣿⣿⣭⣭⣭⣭⣭⣭⣭⣿⣿⣿⣿⣿⣿⡿⠀⣾⣿⣿⣷⠀⠀⠀⠛⠛⠛⠃⠈⠀⠛⠛⠛⠓⠀⠁⢰⣿⣿⣿⡇⠈⣿⣿⣿⡇⢰⣿⣿⣿⡇⠈⠀⢸⣿⣿⣿⡄⠀⢠⣿⣿⣿⣧⠀⠁⣼⣿⣿⣿⡆⠈⠀⠚⠛⠛⠓⠀⠁⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⡶⠶⠶⢿⣿⣿⣶⣶⣶⡶⠶⠶⠶⣿⣿⣿⣿⣿⣿⣿⡀⠻⣿⣿⠟⠀⣀⠘⢿⣿⣿⠟⢳⡀⠻⣿⣿⠟⠛⠂⠘⢿⣿⣿⠇⢠⣿⣿⣿⡇⠘⢿⣿⣿⠇⠀⡀⠸⣿⣿⡿⠁⢀⠈⢿⣿⣿⠏⢀⡄⠹⢿⣿⡿⠃⢀⠀⢻⣿⣿⡿⠛⡆⢸⣿⡿⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣿⣛⣛⣛⣛⣛⣛⣛⣛⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣀⣀⣤⣾⣿⣦⣄⣀⣀⣴⣿⣷⣤⣀⣀⣤⣾⡇⢰⣤⣀⣠⣴⣿⣿⣿⣿⣿⣦⣄⣀⣤⡆⠀⣿⣦⣀⣀⣴⣧⣼⣷⣤⣀⣀⣴⣿⣿⣦⣄⣀⣤⡆⢸⣷⣤⣀⣀⣤⣾⣷⣄⣀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣿⣿⣶⣶⠶⠶⠶⠶⠶⠶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⠙⠛⠛⢁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡈⠙⠛⠋⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
echo "****************************************************************************************************"
echo "*Recording GPU, CPU information....                                                                *"

# 로그 파일 초기화
log_file="GPU_CPU_log.txt"
echo "Timestamp, GPU and CPU Usage Log" > "$log_file"

# CPU가 AMD인지 확인
is_amd=$(lscpu | grep -i 'amd' | wc -l)

# 스크립트 실행
while [ $SECONDS -lt $end_time ]; do
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  # 각 GPU의 온도와 전력 사용량 및 최대 전력 추출
  gpu_info=""
  gpu_count=$(nvidia-smi --query-gpu=index --format=csv,noheader | wc -l)
  for ((i=0; i<gpu_count; i++)); do
    gpu_data=$(nvidia-smi --query-gpu=temperature.gpu,power.draw,power.limit --format=csv,noheader,nounits --id=$i)
    temp=$(echo "$gpu_data" | awk -F',' '{print $1}')
    power_draw=$(echo "$gpu_data" | awk -F',' '{print $2}')
    power_limit=$(echo "$gpu_data" | awk -F',' '{print $3}')
    gpu_info+="GPU${i}, ${temp}C,${power_draw}W /${power_limit}W "
  done

  # CPU 온도 추출 (AMD: Tctl, Intel: 각 소켓의 Package id)
  if [ "$is_amd" -gt 0 ]; then
    # AMD CPU: Tctl 값 추출
    cpu_temp=$(sensors | grep 'Tctl' | awk '{printf "Tctl, %s ", $2}')
  else
    # Intel CPU: 각 소켓의 Package id 값 추출
    cpu_temp=$(sensors | grep -E 'Package id [0-9]+' | awk '{printf "%s, %s ", $1, $4}')
  fi

  # 결과를 로그 파일에 저장
  echo "$timestamp, $gpu_info $cpu_temp" >> "$log_file"

  # 간격 시간 동안 대기
  sleep "$interval"
done
echo "****************************************************************************************************"
echo "****************************************************************************************************"
echo "****************************************************************************************************"
echo "****************************************************************************************************"
echo "*Recording GPU, CPU information completed. Check $log_file for results.                            *"
