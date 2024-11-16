---

## 🥇 Golden Ticket Attacks

### 📝 Summary

A **Golden Ticket** attack allows attackers to gain complete and indefinite access to a domain by forging Kerberos tickets. This attack is possible when the **krbtgt** account in Active Directory (AD) is compromised. With **Mimikatz**, attackers can extract the domain's **SID** and the **krbtgt** NTLM hash to create a Golden Ticket. This ticket can then be used to access any machine or resource within the domain, granting "god-mode" control over the network.

### 📋 Detailed Notes

### 1. **What is a Golden Ticket?**

- **Golden Ticket**: A forged Kerberos ticket that provides unrestricted access within a domain.
- **Key Points**:
    - Compromising the **krbtgt** account means you "own" the domain.
    - Golden Tickets allow attackers to **request access** to any domain resource.
    - This method gives **complete access** to every machine in the domain, bypassing usual security controls.

### 2. **Steps to Perform a Golden Ticket Attack**

### Step 1: **Extract the Required Information with Mimikatz**

- **Open Mimikatz** on the domain controller machine:
    
    ```
    mimikatz # lsadump::lsa /inject /name:krbtgt
    
    ```
    
- **Output Analysis**: Look for the following key information:
    - **SID**: The domain's Security Identifier (e.g., `S-1-5-21-1913434226-3450943478-2207244982`).
    - **krbtgt NTLM Hash**: The NTLM hash of the `krbtgt` account (e.g., `010b40a4c5680f28660ce94f1708104a`).

### Step 2: **Generate the Golden Ticket with Mimikatz**

- Use the extracted **SID** and **krbtgt** NTLM hash to generate the Golden Ticket:
    
    ```
    mimikatz # kerberos::golden /User:Administrator /domain:marvel.local /sid:S-1-5-21-1913434226-3450943478-2207244982 /krbtgt:010b40a4c5680f28660ce94f1708104a /id:500 /ptt
    
    ```
    
- **Explanation of Command Flags**:
    - `/User:Administrator` - Specifies the user to impersonate.
    - `/domain:marvel.local` - The domain name.
    - `/sid:S-1-5-21-...` - The domain's SID obtained earlier.
    - `/krbtgt:<hash>` - The NTLM hash of the `krbtgt` account.
    - `/id:500` - The User ID of the Administrator account.
    - `/ptt` - **Pass the Ticket** to the current session, applying the ticket immediately.

### Step 3: **Access Other Machines Using the Golden Ticket**

- After creating the Golden Ticket, **open a new command prompt** within the Mimikatz session:
    
    ```
    mimikatz # misc::cmd
    
    ```
    
- Use the command prompt to access other machines in the domain:
    
    ```
    dir \\\\THEPUNISHER\\c$
    
    ```
    
- **Expected Output**: This command lists the contents of the target machine’s `C$` share, demonstrating that you now have full access to that machine.

### 3. **Key Takeaways**

- **Indefinite Access**: The Golden Ticket remains valid until the `krbtgt` password is changed **twice**.
- **Complete Control**: This ticket allows the attacker to impersonate any user, granting unrestricted access to any domain resource.

### 📖 Abbreviations & Definitions

- **Golden Ticket**: A forged Kerberos ticket that allows an attacker to impersonate any user within the domain and gain access to all domain resources.
- **krbtgt**: The Kerberos Ticket Granting Ticket account, which encrypts and signs Kerberos tickets. Compromising this account is key to generating a Golden Ticket.
- **SID (Security Identifier)**: A unique identifier assigned to every object (user, group, computer) in the domain. Essential for creating a valid Golden Ticket.
- **NTLM Hash**: The cryptographic hash of a user’s password, used for authentication. The hash of the `krbtgt` account is necessary to create a Golden Ticket.
- **Mimikatz**: A post-exploitation tool used to extract credentials, generate Golden Tickets, and perform various attacks on Windows systems.

### 🚨 Critical Mentions & Exam Traps

- **🚨 Always Extract the Correct SID and `krbtgt` Hash**: The **SID** and **krbtgt** NTLM hash are crucial. An incorrect SID or hash will result in an invalid Golden Ticket.
- **💡 Use `/ptt` to Apply the Ticket**: The `/ptt` flag in the Mimikatz command immediately applies the Golden Ticket to the current session. Without this, the ticket won't be usable.
- **🔑 Check Access**: Always verify that the ticket works by attempting to access other machines or network shares (e.g., using `dir \\\\TARGET\\c$`).
- **⚠️ Exam Trap**: Forgetting to use the correct **SID** or **krbtgt** hash during ticket generation will cause the attack to fail. Always double-check these values before proceeding.
- **🔄 Persistence**: A Golden Ticket remains valid until the `krbtgt` password is **changed twice**. This makes it a persistent method for maintaining access within the domain.

---