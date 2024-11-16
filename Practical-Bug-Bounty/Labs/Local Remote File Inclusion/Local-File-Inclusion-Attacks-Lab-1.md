
# 📁 File Inclusion 0x01 - Local File Inclusion Attacks

---

## 🌐 Lab Overview

This lab demonstrates a Local File Inclusion (LFI) vulnerability within a web application hosted at:

```
http://localhost/labs/fi0x01.php
```

Users can select a text file from a dropdown menu, such as `tiramisu.txt`, which then reflects in the URL:

```
http://localhost/labs/fi0x01.php?filename=tiramisu.txt
```

---

## 🔍 Identifying the Target System

- **Objective:**  
  Determine if the target host is running a Linux system, as this will influence potential target files for exploitation (e.g., `/etc/passwd`).

- **Method:**  
  Infer the operating system by examining:  
  - Server headers  
  - Default pages  
  - Error messages  
  - Specific files that are standard on Linux systems.

---

## 🎯 Exploiting the Vulnerability

Once the target system's OS is identified (assuming Linux here), proceed with testing for Local File Inclusion:

```
GET /labs/fi0x01.php?filename=../../../../../../etc/passwd HTTP/1.1
```

### **Explanation:**
- **Directory Traversal:**  
  The `../../../../../../etc/passwd` in the filename parameter is an attempt to traverse directories up to the root and then navigate to the `/etc/passwd` file, a common Unix/Linux file that stores user information.

---

## 📖 Expected Outcome

- **If Vulnerable:**  
  The response will contain the content of the `/etc/passwd` file, confirming a successful Local File Inclusion attack.  
  - This file lists system users and other details, which are critical from a security perspective.

---

## 🛠️ Lab Conclusion

Successfully accessing the `/etc/passwd` file via an LFI vulnerability demonstrates the potential severity of this issue.  
It highlights the necessity for proper input validation and sanitization in web applications to prevent unauthorized file access.

---

### 📑 Notes:
- Use directory traversal to reach the local file.  
- Utilize **PayloadsAllTheThings** for advanced testing:  
  [PayloadsAllTheThings - File Inclusion](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/File%20Inclusion)
- **FUZZ** the filename parameter against a wordlist offered by Burp Suite or Seclists.
