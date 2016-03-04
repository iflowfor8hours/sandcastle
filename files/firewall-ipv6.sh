# Drop all ipv6 except loopback
sudo ip6tables -F
sudo ip6tables -A INPUT -i lo -j ACCEPT
sudo ip6tables -A OUTPUT -o lo -j ACCEPT
sudo ip6tables -A INPUT -j REJECT --reject-with icmp6-adm-prohibited
