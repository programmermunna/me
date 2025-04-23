#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for HTTP Response Header Test (e.g., http://example.com):"
read URL

# HTTP রেসপন্স হেডার পরীক্ষা
RESPONSE_HEADERS=$(curl -s -I $URL)

# সিকিউরিটি হেডার পরীক্ষা
if echo "$RESPONSE_HEADERS" | grep -q "Strict-Transport-Security"; then
    echo "[+] HSTS (HTTP Strict Transport Security) is enabled."
else
    echo "[-] HSTS is missing."
fi

if echo "$RESPONSE_HEADERS" | grep -q "X-Content-Type-Options"; then
    echo "[+] X-Content-Type-Options is set."
else
    echo "[-] X-Content-Type-Options is missing."
fi

if echo "$RESPONSE_HEADERS" | grep -q "X-Frame-Options"; then
    echo "[+] X-Frame-Options is set."
else
    echo "[-] X-Frame-Options is missing."
fi

if echo "$RESPONSE_HEADERS" | grep -q "X-XSS-Protection"; then
    echo "[+] X-XSS-Protection is enabled."
else
    echo "[-] X-XSS-Protection is missing."
fi
