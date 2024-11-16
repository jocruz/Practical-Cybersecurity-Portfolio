---

## 🥇 Golden Ticket Attacks

### 📝 Summary

A **Golden Ticket** attack allows an attacker who has compromised the **krbtgt** account in Active Directory to gain unrestricted access to all resources within the domain. This powerful attack enables control over any machine in the domain, effectively granting the attacker **"god-mode"** within the network. With tools like **Mimikatz**, an attacker can generate a Golden Ticket using the domain’s **SID** and the **krbtgt** hash.

### 📋 Detailed Notes

1. **What is a Golden Ticket?**
    - When the **krbtgt** account (the Kerberos Ticket Granting Ticket account) is compromised, the attacker gains:
        - **Complete control over the domain.**
        - The ability to **request access** to any resource or system in the domain.
    - **Golden Ticket = Full Domain Access:** Once generated, a Golden Ticket allows the attacker to masquerade as any user, gaining access to all machines and resources.
2. **How to Perform a Golden Ticket Attack:**
    - **Using Mimikatz to Generate a Golden Ticket:**
        - **Step 1: Obtain the Required Information.**
            - **SID:** The domain's **Security Identifier** (SID) is required to create the Golden Ticket. This can be obtained using tools like `whoami /user` or extracted from the domain controller.
            - **krbtgt Hash:** This hash can be extracted using **Mimikatz** after gaining elevated privileges within the domain.
        - **Step 2: Generate the Golden Ticket.**
            - With the **SID** and **krbtgt** hash in hand, use Mimikatz to create the Golden Ticket:
                
                ```
                kerberos::golden /user:<username> /domain:<domain> /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:500
                
                ```
                
            - **Explanation:** This command creates a Kerberos ticket that can impersonate any user in the domain.
        - **Step 3: Access Other Machines.**
            - Once the Golden Ticket is created, use it to access other machines on the domain directly from the command line. The attacker now has complete control.

### 📖 Abbreviations & Definitions

- **Golden Ticket:** A forged Kerberos ticket created using the **krbtgt** account hash, allowing indefinite access to any resource within the domain.
- **krbtgt:** The account used by the Kerberos Key Distribution Center (KDC) to encrypt and sign tickets within the domain. Compromising this account is crucial for creating a Golden Ticket.
- **SID (Security Identifier):** A unique identifier for users, groups, and computers within a Windows domain. Required for generating a valid Golden Ticket.
- **Mimikatz:** A post-exploitation tool used to perform various actions on Windows systems, including extracting password hashes, Kerberos tickets, and creating Golden Tickets.

### 🚨 Critical Mentions & Exam Traps

- **🚨 Compromising `krbtgt` = Owning the Domain:** Understand that compromising the **krbtgt** account gives an attacker **god-like** access to the entire domain.
- **💡 Obtain Both SID and `krbtgt` Hash:** To successfully generate a Golden Ticket, both the **domain SID** and the **krbtgt** hash are essential. Forgetting either piece will result in a failed attack.
- **🔑 Indefinite Access:** Golden Tickets provide **indefinite** access until the `krbtgt` password is changed twice. This is a crucial exam point, as it indicates the need for ongoing vigilance in monitoring domain security.
- **⚠️ Exam Trap:** Ensure you correctly specify the **SID**, **domain**, and **user** when creating a Golden Ticket using Mimikatz. Mistakes in these parameters can lead to failure in gaining access.

---