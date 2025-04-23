#!/bin/bash

# ওয়েবসাইট ডোমেইন ইনপুট নিন
echo "Enter Domain for Subdomain Scan (e.g., example.com):"
read DOMAIN

# সাবডোমেইন গুলি স্ক্যান করুন
echo "Scanning subdomains for $DOMAIN..."

sublist3r -d $DOMAIN -o subdomains.txt

echo "Subdomains found:"
cat subdomains.txt
