# Subnet-Calculator
This script subdivides a given CIDR /24 and smaller subnets into a pre-defined number of smaller subnets.
After devision it will print,
			subnet
			network ip
			broadcast ip
			gateway ip
			number of hosts 
of the smaller subnet.

Script language: bash



Syntax:
$./subnetter.sh <input subnet> <number>





###################################################################################################################
Sample usages


Use case 1

INPUT: 
	./subnetter.sh 192.168.0.0/24 3
OUTPUT:
	subnet=192.168.0.0/25 network=192.168.0.0 broadcast=192.168.0.127 gateway=192.168.0.1 hosts=125
	subnet=192.168.0.128/26 network=192.168.0.128 broadcast=192.168.0.191 gateway=192.168.0.129 hosts=61
	subnet=192.168.0.192/26 network=192.168.0.192 broadcast=192.168.0.255 gateway=192.168.0.193 hosts=61


Use case 2

INPUT: 
	./subnetter.sh 192.168.0.0/24 4

OUTPUT:
	subnet=192.168.0.0/26 network=192.168.0.0 broadcast=192.168.0.63 gateway=192.168.0.1 hosts=61
	subnet=192.168.0.64/26 network=192.168.0.64 broadcast=192.168.0.127 gateway=192.168.0.65 hosts=61
	subnet=192.168.0.128/26 network=192.168.0.128 broadcast=192.168.0.191 gateway=192.168.0.129 hosts=61
	subnet=192.168.0.192/26 network=192.168.0.192 broadcast=192.168.0.255 gateway=192.168.0.193 hosts=61


Use case 3

INPUT: 
	./subnetter.sh 10.55.10.64/28 2

OUTPUT:
	subnet=10.55.10.64/29 network=10.55.10.64 broadcast=10.55.10.71 gateway=10.55.10.65 hosts=5
	subnet=10.55.10.72/29 network=10.55.10.72 broadcast=10.55.10.79 gateway=10.55.10.73 hosts=5
