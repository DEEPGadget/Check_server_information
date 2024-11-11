#!/bin/bash

# Input and output file paths
input_file="GPU_CPU_log.txt"
output_file="output.csv"

# Initialize output file with a basic header
echo -n "Timestamp,NVME(C),Memory used(MB)" > "$output_file"

# Read the first line to detect the number of GPUs and build the header dynamically
first_line=$(head -n 1 "$input_file" | tail -n 1)

gpu_count=$(grep -o "GPU[0-9]" "$input_file" | sort -u | wc -l)
for ((i=0; i<gpu_count; i++)); do
  header+=",GPU${i}_Temp,GPU${i}_Util"
done
header+=",CPU0_Temp,CPU1_Temp"
echo "$header" > "$output_file"




# Add CPU Package headers
echo ",CPU Package1 Temp(C),CPU Package2 Temp(C)" >> "$output_file"

# Process each line in the input file
tail -n +2 "$input_file" | while IFS= read -r line; do
  # Extract basic fields
  timestamp=$(echo "$line" | awk -F',' '{print $1}')
  nvme=$(echo "$line" | awk -F',' '{print $2}')
  memory=$(echo "$line" | awk -F',' '{print $3}' | awk '{print $1}')

  # Start building the line with timestamp, NVME, and memory
  output_line="$timestamp,$nvme,$memory"

  # Extract GPU information dynamically
  gpu_data=$(echo "$line" | grep -o "GPU[0-9], [0-9]*C, [0-9.]*W / [0-9.]*W")
  while read -r gpu_info; do
    gpu_temp=$(echo "$gpu_info" | awk '{print $2}' | sed 's/C,//')
    gpu_util=$(echo "$gpu_info" | awk '{print $3$4$5}')  # Remove spaces around power values
    output_line+=",${gpu_temp},${gpu_util}"
  done <<< "$gpu_data"

  # Add CPU Package temperatures
  cpu_pkg1=$(echo "$line" | grep -o "Package, +[0-9.]*°C" | awk 'NR==1 {print $2}' | sed 's/+//;s/°C//')
  cpu_pkg2=$(echo "$line" | grep -o "Package, +[0-9.]*°C" | awk 'NR==2 {print $2}' | sed 's/+//;s/°C//')
  
  output_line+=",${cpu_pkg1},${cpu_pkg2}"

  # Append to output file
  echo "$output_line" >> "$output_file"
done

echo "Data extraction complete. Check output.csv for results."
