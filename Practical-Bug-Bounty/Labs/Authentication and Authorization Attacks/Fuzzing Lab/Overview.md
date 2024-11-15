# Lab 3: FFUF Fuzzing Lab Walkthrough 🚀

## Objective 🎯
Learn how to use `ffuf` for fuzzing usernames and passwords on a web application, utilizing different modes and custom wordlists.

## Scenario Description 🎭
- Target Application: `/labs/a0x03.php`
- Database Reset URL: `/init.php` (resets lockout mechanism after 5 failed attempts)
- Tools and Files:
  - **Intercept Tool:** Burp Suite
  - **Wordlists:**
    - `/usr/share/seclists/Usernames/top-usernames-shortlists.txt`
    - Custom `passwordl3.txt` (includes `letmein`)

## Key Insights 🌟
- Accounts lock after **5 failed attempts**.
- Using `clusterbomb` mode allows testing all combinations of usernames and passwords efficiently.
- Filtering results helps identify unusual responses indicative of valid credentials.

---
