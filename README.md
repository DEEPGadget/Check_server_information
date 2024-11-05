# **Prerequisite setup**

OS : Ubuntu 22.04
tools : NVIDIA graphic driver, CUDA, lm-sensor, ifupdown-extra, ipmitools

## **File description**
1. gpu-cpu.sh

This file records the temperature and utilization of GPUs from index 0 to index N, as shown by nvidia-smi, as well as the temperature values for AMD CPUs (Tctl) and Intel CPUs (Package id) as reported by sensors.

2. make-csv.sh

This file converts the output file GPU_CPU_log.txt, generated by running gpu-cpu.sh, into a CSV file. When you execute this file, it converts GPU_CPU_log.txt into log.csv

3. test.sh

This file checks the status of the CPU, GPU, Memory, Storage, USB state, network test, and PSU.


# **How to Use**

## **1. git clone and move Check_server_information**
```
git clone https://github.com/DEEPGadget/Check_server_information.git
cd Check_server_information
```

## **2. Change chmod gpu-cpu.sh, make-csv.sh, test.sh**
```
chmod +x gpu-cpu.sh
chmod +x make-csv.sh
chmod +x test.sh
```

## **3. Run ```test.sh``` file , and You can capture output**

```
OUT PUT SAMPLE

⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⠿⠿⠿⠤⠤⠤⠽⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣏⣉⣉⣉⣉⣉⣉⣉⣉⣉⣙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣓⣒⣒⣶⣿⣿⣿⣿⣿⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⡟⠉⣀⣈⠙⠇⢸⠋⢉⣀⣈⠙⢿⡟⠉⣀⣀⠉⠻⡿⠋⢉⣀⣈⠙⢿⣿⣿⣿⡿⠋⢉⣀⣈⠙⢿⡿⠋⣁⣀⡉⠛⣿⠛⢉⣀⣈⠛⠀⡿⠋⣁⣀⡈⠙⣿⠟⠉⣀⣀⠉⠻⡇⢈⣉⣉⣉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣭⣭⣭⣿⣿⣿⣭⣭⣭⣭⣭⣭⣭⣿⣿⣿⣿⣿⣿⡿⠀⣾⣿⣿⣷⠀⠀⠀⠛⠛⠛⠃⠈⠀⠛⠛⠛⠓⠀⠁⢰⣿⣿⣿⡇⠈⣿⣿⣿⡇⢰⣿⣿⣿⡇⠈⠀⢸⣿⣿⣿⡄⠀⢠⣿⣿⣿⣧⠀⠁⣼⣿⣿⣿⡆⠈⠀⠚⠛⠛⠓⠀⠁⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⡶⠶⠶⢿⣿⣿⣶⣶⣶⡶⠶⠶⠶⣿⣿⣿⣿⣿⣿⣿⡀⠻⣿⣿⠟⠀⣀⠘⢿⣿⣿⠟⢳⡀⠻⣿⣿⠟⠛⠂⠘⢿⣿⣿⠇⢠⣿⣿⣿⡇⠘⢿⣿⣿⠇⠀⡀⠸⣿⣿⡿⠁⢀⠈⢿⣿⣿⠏⢀⡄⠹⢿⣿⡿⠃⢀⠀⢻⣿⣿⡿⠛⡆⢸⣿⡿⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣛⣛⣛⣛⣛⣛⣛⣛⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣀⣀⣤⣾⣿⣦⣄⣀⣀⣴⣿⣷⣤⣀⣀⣤⣾⡇⢰⣤⣀⣠⣴⣿⣿⣿⣿⣿⣦⣄⣀⣤⡆⠀⣿⣦⣀⣀⣴⣧⣼⣷⣤⣀⣀⣴⣿⣿⣦⣄⣀⣤⡆⢸⣷⣤⣀⣀⣤⣾⣷⣄⣀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣶⣶⠶⠶⠶⠶⠶⠶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⠙⠛⠛⢁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡈⠙⠛⠋⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
****************************************************************************************************
*Checking Prerequisite tools! Please wait a moment!                                                *
*gpu-burn already installed.                                                                       *
*Checking GPU PCIe.... Please wait a moment.                                                       *
*GPU burn 60 second..for check PCIe Stat                                                           *
*network-test successfully installed.                                                              *
*Checking network-test.... Please wait a moment.                                                   *
*ipmitool install sucessfully.                                                                     *
*Checking ipmitool.... Please wait a moment.                                                       *
****************************************************************************************************
====================================================================================================
|Manycoresoft Hardware Resource Check List!                                                        |
====================================================================================================
CPU Model  : Intel(R) Xeon(R) Silver 4108 CPU @ 1.80GHz
CPU Core   : 32
CPU Socket : 2
GPU Model : NVIDIA GeForce RTX 2080
GPU EA : 4 EA
GPU PCIe Stat :
                LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
                LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
                LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
                LnkSta: Speed 2.5GT/s (downgraded), Width x16 (ok)
Memory : 141Gi
Storage :  SIZE       TYPE
           sda        931.5G
           nvme0n1    931.5G
USB Status : Bus 001 (ok) Bus 002 (ok) Bus 003 (ok) Bus 004 (ok) Bus 005 (ok) Bus 006 (ok) Bus 007 (ok) Bus 008 (ok) Bus 009 (ok) Bus 010 (ok) Bus 011 (ok) Bus 012 (ok)
network-test :
INFO: The enp5s0 interface is up
INFO: The enp6s0 interface is up
WARN: The virbr0 interface is down
WARN: The docker0 interface is down
INFO: The br-f98dcc566cda interface is up
WARN: The br-0028e03b0b37 interface is down
WARN: The br-2232f7a9ac70 interface is down
INFO: The vethd1d93f4@if9 interface is up
INFO: The veth0058073@if11 interface is up
INFO: System can access web server at Internet host www.debian.org (port 80)
PSU State :
Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: No such file or directory

```

## **4. Run ```gpu-cpu.sh``` file, GPU_CPU_log.txt file will be create.**
``` ./gpu-cpu.sh <interval> <duration> ```

## **5. Run ```make-csv.sh``` file, log.csv csv file will be create.**
``` ./make-csv.sh ```
