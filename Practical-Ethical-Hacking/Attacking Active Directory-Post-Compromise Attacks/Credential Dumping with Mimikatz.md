---

## 🔓 Credential Dumping with Mimikatz

### 📝 Summary

**Mimikatz** is a powerful post-exploitation tool used to extract credentials (like plaintext passwords, hashes, and Kerberos tickets) from a Windows system. This guide walks through the process of using Mimikatz to dump credentials, highlighting the necessary commands, critical considerations, and potential exam traps.

### 📋 Detailed Notes

1. **Preparing the File Transfer:**
    - On the **Kali machine**, set up a simple HTTP server to share files:
        
        ```bash
        python3 -m http.server 80
        
        ```
        
    - This command starts an HTTP server on port **80**, allowing file access from the current directory.
2. **Downloading Mimikatz on the Target Machine:**
    - On the **Spiderman (Windows target) machine**:
        - Open the **Edge browser**.
        - Navigate to the **Kali machine's IP address** (e.g., `http://192.168.164.128`).
        - Download and save the Mimikatz files to the target machine's **Downloads** folder.
3. **Running Mimikatz on the Target Machine:**
    - Open **Command Prompt** on the Windows machine.
    - Navigate to the **Downloads** directory:
        
        ```bash
        cd C:\\Users\\peterparker\\Downloads\\mimikatz.exe
        
        ```
        
    - Run the following **Mimikatz** commands:
        1. **Check for Privileges:**
            
            ```
            mimikatz # privilege::debug
            
            ```
            
            - **📝 Note:** This step grants Mimikatz the necessary privileges to interact with system security features.
        2. **Interact with LSA Secrets:**
            
            ```
            mimikatz # sekurlsa::logonPasswords
            
            ```
            
            - **💡 Important:** The output will include a lot of information like **Wdigest**, **MSV**, and potentially **cleartext passwords** if the system is vulnerable.
        3. **Analyze the Output:**
            - Look for **cleartext passwords** (e.g., `marvel\\administrator`). These may appear due to weak security configurations or network share connections (e.g., a connection to `hydra-dc`).
4. **Reviewing Mimikatz Modules:**
    - Mimikatz offers various modules such as:
        - **privilege::** – Checks and enables necessary privileges.
        - **sekurlsa::** – Interacts with the Local Security Authority, allowing extraction of passwords.
        - **pth (Pass-the-Hash):** Extracts and utilizes password hashes for lateral movement in a network.

### 📖 Abbreviations & Definitions

- **Mimikatz:** A post-exploitation tool used to extract plaintext passwords, hashes, PINs, and Kerberos tickets from Windows memory.
- **LSA (Local Security Authority):** A subsystem in Windows responsible for enforcing security policies and storing credentials.
- **Wdigest:** A Windows authentication protocol that can store plaintext credentials in memory.
- **NTLM (New Technology LAN Manager):** A suite of security protocols for network authentication.
- **Sekurlsa:** A Mimikatz module used to access and interact with LSA to dump sensitive information.
- **SAM (Security Accounts Manager):** A Windows database that stores user account information, including password hashes.

### 🚨 Critical Mentions & Exam Traps

- **🚨 Always use `privilege::debug`** before executing commands. This privilege is essential for Mimikatz to access security-related memory areas.
- **💡 The `sekurlsa::logonPasswords` command** may expose **cleartext passwords** if Wdigest is enabled or if the system is vulnerable to credential dumping.
- **🔑 Small Details:** Network connections (e.g., connected to `hydra-dc`) may provide clues or additional vulnerabilities to exploit.
- **⚠️ Exam Trap:** Look for output indicating plaintext passwords or NTLM hashes. Misconfigurations, such as enabling Wdigest or using weak network shares, are often the culprits.

---