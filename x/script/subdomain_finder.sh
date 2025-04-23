#!/bin/bash

# ওয়েবসাইট ডোমেইন ইনপুট নিন
echo "Enter Domain for Subdomain Scan (e.g., example.com):"
read DOMAIN

# Sublist3r টুল দিয়ে সাবডোমেইন খুঁজে বের করা
echo "Finding subdomains for $DOMAIN..."

sublist3r -d $DOMAIN -o subdomains.txt

# সাবডোমেইন তালিকা দেখান
echo "Subdomains found:"
cat subdomains.txt
