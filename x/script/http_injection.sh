#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for HTTP Header Injection Test (e.g., http://example.com):"
read URL

# HTTP ইনজেকশন পে-লোড
INJECTION_PAYLOAD="X-Forwarded-For: 127.0.0.1\n\n"

# HTTP Header Injection পরীক্ষা
RESPONSE=$(curl -s -H "$INJECTION_PAYLOAD" $URL)

# যদি ইনজেকশন সফল হয়
if echo $RESPONSE | grep -q "127.0.0.1"; then
    echo "[+] HTTP Header Injection vulnerability detected."
else
    echo "[-] No HTTP Header Injection vulnerability detected."
fi
