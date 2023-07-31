#!/bin/bash

# Assuming you have already executed the commands to obtain ip_master and ip_worker
output=$(nmap -sn 192.168.0.0/24)
ip_master=$(echo "$output" | awk -F '[()]' '/Nmap scan report for.*master/ {print $2}')
ip_worker=$(echo "$output" | awk -F '[()]' '/Nmap scan report for.*worker*/ {print $2}')

# Combine both IP addresses into a single array
ip_list=()
ip_list+=("$ip_master") # Add the master IP
ip_list+=($ip_worker)   # Add the worker IPs (assuming ip_worker contains two values)

# Sort the array in ascending order
sorted_ip_list=($(echo "${ip_list[@]}" | tr ' ' '\n' | sort -n))

# Test if the sorted IP list is not empty
if [ ${#sorted_ip_list[@]} -eq 0 ]; then
    echo "The sorted IP list is empty."
    exit 1
fi
temp_file="/tmp/hosts_temp"
rm -f "$temp_file"
touch "$temp_file"

# Extract the first IP from the sorted list
first_ip=${sorted_ip_list[0]}
ip_numeric=$(awk -F '.' '{print $4}' <<< "$first_ip")
dns_entry="pi.home.lab" # Fixed the variable name here

for ((j = 0; j < 20; j++)); do
    # Increment the numeric part of the IP address
    next_ip_numeric=$((ip_numeric + j))
    
    # Create the next IP address
    next_ip_address=$(awk -F '.' -v next_ip_numeric="$next_ip_numeric" '{print $1"."$2"."$3"."next_ip_numeric}' <<< "$first_ip")
    
    echo "$next_ip_address $dns_entry" >> "$temp_file"
done
cat "$temp_file" | sudo tee -a /etc/hosts > /dev/null
echo "Entries added to /etc/hosts:"

rm -f "$temp_file"
echo "doneeeeeeeeeeee"