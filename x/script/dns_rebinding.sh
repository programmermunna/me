#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for DNS Rebinding Test (e.g., http://example.com):"
read URL

# DNS Rebinding পরীক্ষার জন্য পে-লোড
DNS_REBINDING_PAYLOAD="http://attacker.com/malicious_file"

# DNS Rebinding আক্রমণ পরীক্ষা
RESPONSE=$(curl -s --header "Host: attacker.com" $URL)

# যদি DNS Rebinding ভ্যালনারেবিলিটি পাওয়া যায়
if echo $RESPONSE | grep -q "malicious"; then
    echo "[+] Potential DNS Rebinding vulnerability detected."
else
    echo "[-] No DNS Rebinding vulnerability detected."
fi
