#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL (e.g., http://example.com):"
read URL

# ওয়েবসাইট ইনফরমেশন গ্যাথারিং
echo "Gathering information for $URL"

# সার্ভার হেডার ইনফো (cURL ব্যবহার)
echo "Server Information:"
curl -I $URL | grep -i "Server"

# HTML টাইটেল
echo "Website Title:"
curl -s $URL | grep -o '<title>[^<]*' | sed 's/<title>//'

# ওয়েব টেকনোলজি ডিটেক্টর (WhatWeb)
echo "Detecting Web Technologies:"
whatweb $URL

# SSL সার্টিফিকেট ইনফো (যদি SSL থাকে)
echo "SSL Certificate Information:"
openssl s_client -connect $(echo $URL | sed 's/^https\?:\/\///') </dev/null 2>/dev/null | openssl x509 -noout -issuer -subject -dates
