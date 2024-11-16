# 🔍 **Post-Compromise AD Enumeration with ldapdomaindump**

---

### 📋 **Summary**:

Once a user has been compromised, the next step is efficient **Active Directory enumeration** to identify key targets. Tools like **ldapdomaindump** allow for a quick overview of domain users, groups, policies, and computers by extracting LDAP data. In this guide, we focus on running **ldapdomaindump** to gather valuable information for further exploitation.

💡 **Key Action**: After compromise, run `ldapdomaindump` to quickly enumerate domain users, groups, computers, and policies.

---

### 🛠️ **Detailed Notes**:

### **1. Preparing for Enumeration**:

- **Create a directory** to store your results:
    
    ```bash
    mkdir marvel.local
    
    ```
    

### **2. Running ldapdomaindump**:

- **Command**:
    
    ```bash
    sudo /usr/bin/ldapdomaindump ldaps://192.168.164.138 -u 'MARVEL\\fcastle' -p Password1
    
    ```
    
    - **Explanation**:
        - This command connects to the **LDAP server** at `192.168.164.138` using **Frank Castle’s** credentials and dumps the AD domain details.
        - **ldaps://** ensures a secure connection to the LDAP server.

### **3. Verifying Output**:

- **Check the output files** with `ls`:
    
    ```bash
    ls marvel.local/
    
    ```
    
    - Files generated will include:
        - `domain_users.html`, `domain_groups.html`, `domain_computers.html`, `domain_trusts.html`, etc.

### **4. Reviewing the Results**:

- Open the **domain users** file to review high-value accounts:
    
    ```bash
    firefox marvel.local/domain_users_by_group.html
    
    ```
    
- **What to look for**:
    - Users with **DONT_EXPIRE_PASSWD** flags (e.g., SQL Service, Tony Stark).
    - **Enterprise Admins**, **Domain Admins**, and other privileged groups.
    - Potentially weak passwords (e.g., SQLService password: `MYpassword123#`).

🚨 **Critical Mention**: High-value accounts like **Enterprise Admins** or **Domain Admins** are primary targets for privilege escalation.

---

### 📖 **Abbreviations & Definitions**:

- **LDAP**: Lightweight Directory Access Protocol used for querying and modifying directory services like Active Directory.
- **ldaps://**: Secure LDAP protocol using SSL/TLS.
- **SAM Name**: Security Account Manager Name, the unique identifier for Windows accounts.
- **DONT_EXPIRE_PASSWD**: A flag indicating the user’s password does not expire, making it a valuable target for long-term access.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **Look for High-Privilege Users**: Focus on **Enterprise Admins** and **Domain Admins** found in `domain_users_by_group.html`.
    - These users can give you full control of the domain if exploited.
- **Common Pitfall**: Make sure the account you’ve compromised has enough **LDAP access** to run `ldapdomaindump`. If you don’t have sufficient privileges, the dump might fail or be incomplete.

💡 **Tip**: Users with **DONT_EXPIRE_PASSWD** or **ACCOUNT_DISABLED** flags are often overlooked but can be critical for long-term persistence.

---

### 📌 **Potential Pitfalls**:

1. **Insufficient Permissions**:
    - If the compromised user lacks sufficient LDAP permissions, **ldapdomaindump** might not retrieve full information.
2. **Overlooking Domain Trusts**:
    - Don’t miss the `domain_trusts.html` file. It can reveal other trusted domains or networks for lateral movement.

---

### 💡 **Quick Tips for the Exam**:

- **High-Value Users First**: Always check `domain_users_by_group.html` for **Domain Admins** and **Enterprise Admins** to prioritize your escalation targets.
- **Verify Password Settings**: Look for weak passwords or accounts with **DONT_EXPIRE_PASSWD** settings—these accounts are easier to exploit and provide persistent access.
- **Cross-Domain Enumeration**: Use `domain_trusts.html` to identify trusted domains that you can potentially move into for further exploitation.

---