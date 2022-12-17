#!/bin/bash
# Coded by Invalid
clear

# This is just a fancy start, don't mind it.
echo -e "\e[35mWelcome, onii-chan >_<\e[0m"
echo
echo -e "\e[1;35m⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷\e[0m"
echo -e "\e[1;35m⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇\e[0m"
echo -e "\e[1;35m⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽\e[0m"
echo -e "\e[1;35m⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕\e[0m"
echo -e "\e[1;35m⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕\e[0m"
echo -e "\e[1;35m⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕\e[0m"
echo -e "\e[1;35m⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄\e[0m"
echo -e "\e[1;35m⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕\e[0m"
echo -e "\e[1;35m⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿\e[0m"
echo -e "\e[1;35m⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿\e[0m"
echo -e "\e[1;35m⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟\e[0m"
echo -e "\e[1;35m⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠\e[0m"
echo -e "\e[1;35m⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙\e[0m"
echo -e "\e[1;35m⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣\e[0m"
echo
# Starting the operations
echo -e "\e[35mStarting operations...\e[0m"
echo
# Installing and starting ufw
echo -e "\e[35mInstalling ufw...\e[0m"
echo
sudo apt-get install ufw
echo -e "\e[35mStarting ufw... \e[0m"
sudo ufw enable
echo
# Updating and upgrande
echo -e "\e[35mUpdating and upgrading...\e[0m"
sudo apt-get update && sudo apt-get upgrade -y
echo
# Using chkrootkit
echo -e "\e[35mInstalling chkrootkit...\e[0m"
sudo apt-get install chkrootkit
echo -e "\e[0mStarting chkrootkit... \e[0m"
sudo chkrootkit
# This rule blocks invalid packets, this rule blocks all packets that are not SYN packets and don't belong to an estabilished TCP connection.
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP

# Block new packets that are not SYN, it's similar to the invalid packets ones but catches some that the other does not.
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP

# Block uncommon MSS Values, this iptables ruleblocks new packets (only SYN packets can be new packets as per the two previous rules) that use a TCP MSS value that is not common.
# This helps to block dumb SYN floods.
iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP

# Block packets with bogus TCP flags
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP

# Block packets from private subnets (Spoofing): These rules block  spoofed packets from private (Local) subnets.
# On your public network interface you usually don't want to receive packets from private sources IPs.
# These rules assume that your loopback interface uses the 127.0.0.1/8 IP space
# These 5 rules already block many TCP-based DDoS attacks at very high packet rates
# With the kernel settings and rules in the other script you'll be able to filter ACK and SYN-ACK attacks at line rate
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j DROP 
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j DROP
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j DROP
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j DROP
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j DROP
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j DROP
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j DROP
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP

# This drops all ICMP packets. ICMP is only used to ping a host and check if it is still alive, it is usually not needed so it only represents another vulnerability
iptables -t mangle -A PREROUTING -p icmp -j DROP

# This iptables rule helps against connections attacks.
# It rejectsconnections from hosts that have more than 80 estabilished connections.
# If you face any issues you should raise that number.
# This could cause trouble with legitimate clients that estabilish a large number of TCP connections
iptables -A INPUT -p tcp -m connlimit --connlimit-above 80 -j REJECT --reject-with tcp-reset

# Limits the new TCP connections that a client can estabilish per second.
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP

# This rule blocks fragmented packets.
iptables -t mangle -A PREROUTING -f -j DROP

# This limits incoming TCP RST packets to mitigate TCP RST floods.
iptables -A INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT
iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP

# This rule apply to all ports 
iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 8 --mss 1460
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# SSH brute-force protection
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

# Protection against port scanning
/sbin/iptables -N port-scanning
/sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
/sbin/iptables -A port-scanning -j DROP
echo
# Here you can block malicious addresses
echo -e "\e[35m Do you want to enter a malicious address to block? (y/n): \e[0m"
read yn
if [ yn == "y" ]
then
echo
echo -e "\e[35mEnter address: "
read malicious
echo
iptables -A INPUT -p tcp -m tcp -s $malicious -j DROP
echo
else
echo
echo -e "\e[35mOkay... continuing..."
cat /proc/net/stat/synproxy
echo
echo -e "\e[35mDone, exiting...\e[0m"
fi
exit 0
