#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Clickjacking Test (e.g., http://example.com):"
read URL

# Clickjacking টেস্টের জন্য iframe পে-লোড তৈরি
CLICKJACKING_PAYLOAD="<iframe src=\"$URL\" width=\"100%\" height=\"100%\" style=\"position: absolute; top: 0; left: 0; z-index: 9999;\"></iframe>"

# টেস্ট করা
RESPONSE=$(curl -s -d "$CLICKJACKING_PAYLOAD" $URL)

# যদি সাইটের Clickjacking সুরক্ষা না থাকে, এটি detect করা যাবে
if echo "$RESPONSE" | grep -q "<iframe"; then
    echo "[+] Potential Clickjacking vulnerability detected!"
else
    echo "[-] No Clickjacking vulnerability detected."
fi
