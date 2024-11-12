#!/bin/bash

# lscpu
cpu_model=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//')
cpu_cores=$(lscpu | grep "^CPU(s):" | awk -F: '{print $2}' | sed 's/^[ \t]*//')
cpu_sockets=$(lscpu | grep "Socket(s)" | awk -F: '{print $2}' | sed 's/^[ \t]*//')

# nvidia-smi gpu name
# nvidia-smi installed check
# if nvidia-smi installed
if command -v nvidia-smi &> /dev/null; then
    # nvidia-smi gpu model name out
    gpu_model=$(nvidia-smi --query-gpu=name --format=csv,noheader | uniq)
    gpu_count=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
else
    # nvidia-smi not installed
    # lspci gpu model name out
    gpu_model=$(lspci -vvv | grep NVIDIA | grep -i VGA | awk -F ']' '{print $2}' | sed 's/^[ \t]*//')
    gpu_count=$(lspci | grep -i NVIDIA | wc -l)
    echo "Please Check GPU Driver!!!"
fi

#check network-test tool
if ! command -v network-test &> /dev/null; then
    echo "network-test not found. Install ifupdown-extra package!"

    # ifupdown-extra package install
    sudo apt update
    sudo apt install -y ifupdown-extra

    # install check
    if command -v network-test &> /dev/null; then
        echo "network-test successfully installed."
    fi
fi


# ipmitool check
if ! command -v ipmitool &> /dev/null; then
    echo "ipmitool not install. Install ipmitool."

    # ipmitool package install
    sudo apt update
    sudo apt-get install -y ipmitool

    # ipmitool installed check
    if command -v ipmitool &> /dev/null; then
        echo "ipmitool install sucessfully."
    fi
fi

#free -h
memory_total=$(free -h | grep "Mem:" | awk '{print $2}')

#lsblk
storage_list=$(lsblk -o NAME,SIZE,TYPE | awk '$3 == "disk" {printf "           %-10s %s\n", $1, $2}')

#lsusb
usb_status="USB Status :"

# lsusb get Bus number
for bus in $(lsusb | awk '{print $2}' | sort -u); do
    usb_status+=" Bus $bus (ok)"
done

#echo "$usb_status"

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
echo "*Checking Prerequisite tools! Please wait a moment!                                                *"
###########
cd "$HOME"

if [ -d "$HOME/gpu-burn" ]; then
    echo "*gpu-burn already installed.                                                                       *"
    echo "*Checking GPU PCIe.... Please wait a moment.                                                       *"
    cd gpu-burn
else
    echo "*gpu-burn not detected....install gpu-burn                                                         *"
    git clone https://github.com/wilicc/gpu-burn
    cd gpu-burn || exit 1
    make
    echo "*gpu-burn build complete                                                                           *"
    echo "*Checking GPU PCIe.... Please wait a moment.                                                       *"
fi

echo "*GPU burn 120 second..for check PCIe Stat                                                          *"
./gpu_burn 120 > /dev/null 2>&1 &

if command -v network-test &> /dev/null; then
    echo "*network-test successfully installed.                                                              *"
    echo "*Checking network-test.... Please wait a moment.                                                   *"
fi


if command -v ipmitool &> /dev/null; then
    echo "*ipmitool install sucessfully.                                                                     *"
    echo "*Checking ipmitool.... Please wait a moment.                                                       *"
fi


echo "****************************************************************************************************"
#gpu-burn wait....
sleep 10
pcie_status=$(sudo lspci -vvv | grep NVIDIA -A 30 | grep LnkSta)

#output
echo "===================================================================================================="
echo "|Manycoresoft Hardware Resource Check List!                                                        |"
echo "===================================================================================================="
echo "CPU Model  : $cpu_model"
echo "CPU Core   : $cpu_cores"
echo "CPU Socket : $cpu_sockets"
echo "GPU Model : $gpu_model"
echo "GPU EA : $gpu_count EA"
echo "GPU PCIe Stat :"
echo "$pcie_status"
echo "Memory : $memory_total"
echo "Storage :  SIZE       TYPE"
echo "$storage_list"
echo "$usb_status"
echo "network-test :"
network-test | grep -E "interface.*(up|down)|System can access web server at Internet host www.debian.org"
echo "PSU State :"
sudo ipmitool sensor | grep -E "PSU[0-9]+ Power (In|Out)" | while read -r line; do
    psu_name=$(echo "$line" | awk '{print $1, $2, $3}')
    value=$(echo "$line" | awk '{print $4, $5}')
    echo "$psu_name $value"
done

