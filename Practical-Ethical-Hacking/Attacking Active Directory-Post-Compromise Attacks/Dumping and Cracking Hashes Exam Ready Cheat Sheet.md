---

### 🔐 **Dumping and Cracking Hashes: Exam-Ready Cheat Sheet**

---

## 📝 **Summary**

This guide helps you understand how to **dump password hashes** using [**secretsdump.py**](http://secretsdump.py/), **crack** those hashes with **hashcat**, and perform lateral movement using **Pass-the-Hash** attacks. It covers key concepts, commands, and actions in a way that is quick and easy to reference during your exam.

- **Objective**:
    1. Dump **SAM hashes**, **cached domain credentials**, and **LSA secrets** from target machines.
    2. Crack or reuse the dumped hashes to escalate privileges.
    3. Use **Pass-the-Hash** to move laterally across the network without needing the actual password.

### **Key Differences**:

- **secretsdump.py** **extracts credentials** (hashes, cleartext passwords) from a machine, while **crackmapexec** **tests those credentials** across other machines to see where they work.
- **secretsdump.py** focuses on **harvesting** valuable data, whereas **crackmapexec** is used for **credential re-use** and lateral movement in the network.

---

## 📚 **Detailed Notes**

### 1. **Dumping Password Hashes with `secretsdump.py`**

### 🔧 **Key Command**:

```bash
secretsdump.py MARVEL.local/fcastle:'Password1'@192.168.164.139

```

- **What it does**: Dumps **local SAM hashes**, **cached domain logon info**, and **LSA secrets** from the target machine.

### 🖥️ **Example Output**:

```
Administrator:500:aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b:::
MARVEL.LOCAL/Administrator:$DCC2$10240#Administrator#c7154f935b7d1ace4c1d72bd4fb7889c

```

### 💡 **Key Tips**:

- **SAM hashes**: These are **hashed passwords** for local accounts on the target system.
- **Cached credentials**: May contain **domain admin passwords**. Cracking these gives you high-level access.

### 🚨 **Critical Mention**:

Always prioritize **Administrator** hashes! These are the most valuable for lateral and vertical movement.

---

### 2. **Cracking Hashes with `hashcat`**

### 🔧 **Key Command**:

```bash
hashcat -m 1000 ntlm.txt /usr/share/wordlists/rockyou.txt --show

```

- **What it does**: Cracks the **NTLM hash** stored in the file `ntlm.txt` using the **rockyou.txt** wordlist.

### 🖥️ **Example Output**:

```
64f12cddaa88057e06a81b54e73b949b:Password1

```

- **Result**: The hash `64f12cddaa88057e06a81b54e73b949b` was cracked to reveal the password `Password1`.

### 💡 **Key Tips**:

- Use **common wordlists** (like `rockyou.txt`) to crack hashes quickly.
- Even if you can't crack the hash, you can still use it in a **Pass-the-Hash attack**.

---

### 3. **Pass-the-Hash Attack**

### 🔧 **Key Command**:

```bash
secretsdump.py <administrator:@192.168.164.140> -hashes aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b

```

- **What it does**: Uses the **hash** instead of the password to dump more information from the target machine.

### 💡 **Key Tips**:

- You don’t need the plaintext password. The **hash** itself can be used to access other systems.

---

### 4. **Automating Lateral Movement**

If you have access to multiple machines, you can automate lateral movement across the network:

### 🖥️ **Command Example**:

```bash
for ip in $(cat ips.txt); do secretsdump.py admin:$hash@$ip; done

```

- This runs `secretsdump.py` on all IPs listed in `ips.txt`.

### 💡 **Key Tips**:

- Once you have access, dump hashes across the network to gain control over more machines.

### 🔀 **Lateral Movement**

---

## **LLMNR Poisoning to Lateral Movement**

### 1. **LLMNR Poisoning** ➡️ **Capture Hash** ➡️ **Crack Hash**:

- **Use LLMNR Poisoning** to capture hashed credentials (e.g., NTLM hashes) on the network.
- **Crack the Captured Hash** using tools like `hashcat` to retrieve plaintext passwords or use the hash in a Pass-the-Hash attack.

### 2. **Password Spraying**:

- After cracking, **spray the cracked password** across the network to identify other systems where it can be used.
- This step helps **find new login credentials** and gain access to additional machines.

### 3. **Dumping Credentials with `secretsdump.py`**:

- **Use newly found logins** to dump **local admin hashes** from machines:
    
    ```bash
    secretsdump.py <domain>/<user>@<target_ip>
    
    ```
    
- Gather as many hashes as possible for further lateral movement.

### 4. **Respraying the Network**:

- **Respray** the network using the **local admin hashes** to gain access to other machines and dump their credentials.

### 📌 **Key Takeaway**: This process focuses on repeating lateral movements until a vertical escalation (e.g., domain admin) is achieved. **Persistence** in moving laterally is key to finding the right opportunity for escalation.

---

## 🔑 **Abbreviations & Definitions**

- **SAM (Security Account Manager)**: Stores **hashed passwords** for local accounts.
- **LSA Secrets**: Stores sensitive information like **cached domain credentials** and **passwords**.
- **NTLM**: A **hashing algorithm** used to store Windows passwords.
- [**secretsdump.py**](http://secretsdump.py/): Tool for dumping **SAM**, **LSA**, and **cached credentials** from a target system.
- **hashcat**: Password cracking tool used to crack **NTLM** hashes.
- **Pass-the-Hash Attack**: Using an **NTLM hash** to authenticate without needing the actual password.

---

## 🚨 **Critical Mentions & Exam Traps**

- **📝 Administrator Hashes**: Always prioritize these when dumping hashes. They allow for the greatest control over a system.
- **🚨 Cached Credentials**: These are often domain admin passwords. Cracking them can give you complete domain control.
- **💡 Use Older Machines**: Look for systems using **wdigest** or older protocols to potentially find **cleartext passwords**.
- **🚨 Check for Cleartext Passwords**: Sometimes you’ll find a **cleartext password** in LSA Secrets, even when you expect only hashes.
- **📝 Automate Lateral Movement**: Once you have access, use scripts to dump hashes across the entire network.
- **🚨 Use LLMNR Attacks**: Capturing and cracking a hash via **LLMNR poisoning** can give you credentials to use across the network.

---

### 🛠️ **Cheat Sheet for Quick Commands**

### 🔧 **Dumping Hashes**:

```bash
secretsdump.py <domain>/<user>:<password>@<target_ip>

```

### 🔧 **Cracking Hashes**:

```bash
hashcat -m 1000 <hashfile> /usr/share/wordlists/rockyou.txt --show

```

### 🔧 **Pass-the-Hash Attack**:

```bash
secretsdump.py <user>@<target_ip> -hashes <NTLM_hash>

```

---