#------------------------
# IPTABLES RULES
#------------------------


# Teamspeak
iptables -A INPUT -p udp --dport 9987 -j ACCEPT
iptables -A INPUT -p udp --sport 9987 -j ACCEPT

iptables -A INPUT -p tcp --dport 30033 -j ACCEPT
iptables -A INPUT -p tcp --sport 30033 -j ACCEPT

iptables -A INPUT -p tcp --dport 10011 -j ACCEPT
iptables -A INPUT -p tcp --sport 10011 -j ACCEPT

# HTTP(s)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT

iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --sport 8080 -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT

# SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -j ACCEPT

# DNS
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

# MINECRAFT
iptables -A INPUT -p udp --dport 25565 -j ACCEPT
iptables -A INPUT -p udp --sport 25565 -j ACCEPT
iptables -A INPUT -p udp --dport 25567 -j ACCEPT
iptables -A INPUT -p udp --sport 25567 -j ACCEPT

#SAVE
iptables-save > /etc/iptables.up.rules
#RESTORE
iptables-restore < /etc/iptables.up.rules

# flush
iptables -L
