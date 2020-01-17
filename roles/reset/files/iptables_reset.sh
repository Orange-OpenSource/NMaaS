#!/bin/bash

# Accept all in default policies
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Flush every rule
iptables -F
iptables -t nat -F

# Delete any custom chain
iptables -X
iptables -t nat -X
