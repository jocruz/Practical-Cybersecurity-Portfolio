
# 📚 Local File Inclusion (LFI) Overview

---

## **Introduction to Local File Inclusion 🛡️📁**

### **What is Local File Inclusion (LFI)?**
Local File Inclusion (LFI) is a security vulnerability that allows an attacker to include and read files from the server through the web application.  
This often occurs when user input is used to specify file paths without proper validation or sanitization.

---

## **How Does Local File Inclusion Work?**

### 🌐 Example Scenario:
An application takes a file name as input and includes it in the response:
```php
<?php
    include($_GET['filename']);
?>
```

### 🤯 Exploiting the Vulnerability:
If the input isn't sanitized, an attacker can manipulate the `filename` parameter to include unintended files:
- Example request:
  ```
  http://example.com/page.php?filename=../../../../../etc/passwd
  ```

---

## **Impacts of Local File Inclusion**

1. **Sensitive Information Disclosure:**
   - Read system files such as `/etc/passwd` or configuration files.
2. **Code Execution:**
   - Under certain circumstances, LFI can lead to remote code execution by including malicious scripts.
3. **Log Poisoning:**
   - Write malicious input into server logs and include them for execution.

---

## 🛠️ Common Techniques for Exploiting LFI

1. **Directory Traversal:**
   - Use `../` sequences to navigate to restricted directories.
   - Example payload:
     ```
     ../../../../etc/passwd
     ```

2. **Recursive Filtering Bypass:**
   - Add extra characters like `./` to bypass basic filtering:
     ```
     ..././..././..././etc/passwd
     ```

3. **Using Wrappers (e.g., php://filter):**
   - Encode the content of sensitive files:
     ```
     php://filter/convert.base64-encode/resource=config.php
     ```

4. **Log Poisoning:**
   - Inject malicious payloads into server logs and include the log file for execution:
     ```
     /var/log/apache2/access.log
     ```

---

## **Real-World Example**

### Example Attack:
Request:
```
GET /vulnerable.php?filename=../../../../../etc/passwd HTTP/1.1
```

Response:
```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
...
```

---

## **Mitigation Strategies**

1. **Input Validation and Sanitization:**
   - Whitelist allowed file names.
   - Reject input containing `../` or other traversal sequences.

2. **Server Configuration:**
   - Disable directory listing.
   - Restrict access to sensitive directories.

3. **Error Handling:**
   - Avoid exposing detailed error messages that could help an attacker.

---

## 📋 Summary
Local File Inclusion is a critical vulnerability that can lead to data breaches, code execution, and more.  
Understanding and addressing these risks with proper input validation, server configuration, and security practices is essential to protecting web applications.

---
