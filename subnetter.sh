#!/bin/bash

##### Calculating required paramaters from inputs #####

network_ip=`echo $1 | awk -F '/' '{print $1}'`
subnet=`echo $1 | awk -F '/' '{print $2}'`
number_of_subnets=$2





##################################################################
#### Generating the array of numbers that should be added to  ####
#### the subnet to calculate the subnet bits for each smaller ####
#### subnet						      ####
##################################################################

# 1 --> 0
# 2 --> 1 1
# 3 --> 1 2 2
# 4 --> 2 2 2 2
# 5 --> 2 2 2 2 3
# 
# 1 is the data initialization step
# 2 and every line after 2: swap last and first number, add one to last, add new after last(value=last)

array[1]=0
i=1
#array[$test]=2

while [ $i -lt $number_of_subnets ]
do
	# echo $i
	i=$(( i + 1 ))
	length=${#array[@]}

	# swap first and last elements
	temp=${array[${length}]}
	temp=${array[1]}
	#array[1]=${array[$length]}
	
	j=1
	while [ $j -lt $length ]
	do
		array[$j]=${array[$j+1]}
		j=$((j + 1))
	done 	
	array[$length]=$temp

	array[$length]=$((temp + 1))
	array[$length + 1]=$((temp + 1))
done

#echo ${#array[@]}
line=$(echo ${array[*]})
echo $line




###########################################################
##### Calculating the required outputs for each subnet ####
##### subnet, network-ip, broadcast-ip, hosts          ####
###########################################################

for j in $(eval echo "{1..$2}")
do
	# calculate prefix for class C subnets
	prefix=$(echo "$network_ip" | awk -F. '{OFS=".";NF--;print $0;}')
	# get the number that should be added to subnet-bits for new smaller subnet
	read temp <<< $(echo $line | awk -F ' ' "{print \$$j}")
	# get the host portion of ip
	read last <<< $(echo $network_ip | awk -F '.' '{print $4}')
	
	subnet_actual=$((subnet + temp))
	# calculate number of hosts in subnet 
	hosts=$(( 2 ** ( 32 - subnet_actual ) - 3 ))
	broadcast=$(( last + hosts + 2))
	echo "subnet=$network_ip/$subnet_actual    network=$network_ip    broadcast=$prefix.$broadcast    hosts=$hosts"
		
	# calculate network ip for next subnet
	a=$(( last + hosts + 3 ))	
	network_ip="$prefix.$a"
done
