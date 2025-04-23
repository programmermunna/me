#!/bin/bash

# ওয়েবসাইট বা IP ইনপুট নিন
echo "Enter IP or Domain for Open Port Scan (e.g., 192.168.1.1 or example.com):"
read TARGET

# Nmap দিয়ে ওপেন পোর্ট স্ক্যান
echo "Scanning open ports for $TARGET..."

nmap -p- --open $TARGET
