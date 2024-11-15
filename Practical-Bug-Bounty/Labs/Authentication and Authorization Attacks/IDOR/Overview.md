# Lab 0x04: Understanding IDOR (Insecure Direct Object Reference) 👾

## What is IDOR? 🎯
Insecure Direct Object Reference (IDOR) occurs when an application exposes a reference to an internal object (e.g., database keys, files) that can be manipulated to access unauthorized data.

---

## Example Scenario 🌐
- **Current URL:**  
  `http://localhost/labs/e0x02.php?account=1009`
- **Issue:**  
  The `account` parameter in the URL is modifiable, leading to potential unauthorized access.

---

## Tools and Techniques Used
- **Manual Testing:** Burp Suite for intercepting and modifying requests.
- **Automation:** Python for payload generation, Burp Intruder for testing, and FFUF for fuzzing.

---
