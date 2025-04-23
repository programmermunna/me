#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Sensitive Info Exposure Test (e.g., http://example.com):"
read URL

# পোটেনশিয়াল সেনসিটিভ ইনফরমেশন পে-লোড
SENSITIVE_FILES=("/config.php" "/.env" "/api_keys.txt" "/db_credentials.php")

for file in "${SENSITIVE_FILES[@]}"
do
    # প্রতিটি ফাইলের জন্য টেস্ট করা
    TEST_URL="${URL}${file}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি ফাইল কনটেন্ট পাওয়া যায়, তাহলে সেনসিটিভ ইনফরমেশন এক্সপোজ হয়েছে
    if echo $RESPONSE | grep -q "API_KEY" || echo $RESPONSE | grep -q "DB_PASSWORD"; then
        echo "[+] Sensitive information exposure detected with file: $file"
    else
        echo "[-] No sensitive information exposure detected with file: $file"
    fi
done
