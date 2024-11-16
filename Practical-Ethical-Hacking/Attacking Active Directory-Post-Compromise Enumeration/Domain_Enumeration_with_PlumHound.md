---

# 🌐 Domain Enumeration with PlumHound

---

## 📝 Summary

**PlumHound** is a domain enumeration tool used to gather key information from Active Directory environments, leveraging Neo4j databases. It automates queries to extract detailed information about users, groups, computers, and potential vulnerabilities. PlumHound is particularly useful for **quick and high-level assessments** when you need to identify high-value targets like domain admins, Kerberoastable users, or accounts with constrained delegation. It is designed to offer simplified output, making it ideal for scenarios where you want an **overview of domain users and admin groups** without deep-dive analysis.

**BloodHound**, on the other hand, is more powerful and complex, used for **graph-based analysis** of Active Directory relationships. BloodHound provides **detailed attack paths**, visualizing how a low-privileged user can escalate privileges within a domain. It offers advanced capabilities for finding privilege escalation opportunities, attack vectors, and lateral movement paths within a network.

### When to Use Each Tool:

- **PlumHound**:
    - Best for **quick assessments** or when you need a **high-level snapshot** of domain users, computers, and admin groups.
    - Ideal for **lightweight enumeration** during engagements when time is limited, or the goal is to quickly identify low-hanging fruit like **Kerberoastable users** or **direct admin relationships**.
- **BloodHound**:
    - Use when you need **in-depth analysis** of domain relationships, including privilege escalation paths and complex attack vectors.
    - Perfect for **advanced attack planning**, where understanding **lateral movement** and **privilege escalation** strategies is key to identifying deeper vulnerabilities.

Both tools are highly valuable in penetration testing engagements but serve slightly different purposes based on the depth and scope of the analysis required.

---

## 🔍 Detailed Notes

### **Step 1: Initial Domain Query (Listing Domain Users)**

- Command:
    
    ```bash
    sudo python3 PlumHound.py --easy -p neo4j1
    
    ```
    
- **Purpose**: Quickly retrieve a list of users within the domain. Useful for seeing who is present in the network, which can reveal high-value targets.
- **Expected Output**:
    
    ```
    n.name                      n.displayname
    --------------------------  ---------------
    ADMINISTRATOR@MARVEL.LOCAL
    TSTARK@MARVEL.LOCAL         Tony Stark
    SQLSERVICE@MARVEL.LOCAL     SQL Service
    PPARKER@MARVEL.LOCAL        Peter Parker
    KRBTGT@MARVEL.LOCAL
    GUEST@MARVEL.LOCAL
    FCASTLE@MARVEL.LOCAL        Frank Castle
    NT AUTHORITY@MARVEL.LOCAL
    
    ```
    
    💡 **Key Tip**: Look for **Administrator**, **Service Accounts** (like SQL Service), and any unusual or unknown accounts, as these may be worth investigating further.
    

---

### **Step 2: Full Task Execution (Running All Tasks)**

- Command:
    
    ```bash
    sudo python3 PlumHound.py -x tasks/default.tasks -p neo4j1
    
    ```
    
- **Purpose**: Runs the full set of tasks defined in the default task list, covering more ground, such as trusts, users, and admin groups.
- **Expected Output**:
    - Completes 119 tasks in about 3.8 seconds, with all reports saved in `reports/Reports.zip`.
    - Provides a more in-depth enumeration, including domain admins, schema admins, Kerberoastable users, etc.
    
    🚨 **Critical Mention**: Make sure to **run with `-x`** to generate the full set of reports during the exam. Missing this flag could cause you to lose important information.
    

---

### **Step 3: Viewing Reports in Browser**

- Command:
    
    ```bash
    cd reports
    firefox index.html
    
    ```
    
- **Purpose**: Opens the report in a browser for easy visual access. This is faster than manually searching through directories during the exam.
- **Important Data** in the report includes:
    - **Domains**: Shows existing domains in the network.
    - **Domain Admins (Direct)**: Lists admins with direct domain access (3 admins found in this case).
    - **Kerberoastable Users**: Shows users vulnerable to Kerberoasting attacks (2 users found).
    - **Local Admins**: Lists local admins, potentially high-value targets.
    - **GPOs**: Group Policy Objects that control various aspects of the domain.

---

### **Key Command Summary**

- **Quick User Enumeration**: `sudo python3 PlumHound.py --easy -p neo4j1`
- **Full Task Execution**: `sudo python3 PlumHound.py -x tasks/default.tasks -p neo4j1`
- **View Report in Browser**:
    
    ```bash
    cd reports
    firefox index.html
    
    ```
    

---

## 📚 Abbreviations & Definitions

- **LLMNR (Link-Local Multicast Name Resolution)**: Used to resolve hostnames on local networks without DNS. Often a target for man-in-the-middle attacks.
- **SMB (Server Message Block)**: Network file-sharing protocol allowing file and printer sharing over a network.
- **DNS (Domain Name System)**: Resolves domain names into IP addresses.
- **Kerberoasting**: Exploiting Kerberos to crack service account credentials.
- **GPO (Group Policy Object)**: Rules applied across domain computers, controlling settings and behavior within the network.

---

## 🚨 Critical Mentions & Exam Traps

- **🚨 Always Run the Full Task Set**: Use the `x` flag to ensure you gather all relevant information during an exam. Missing this could lead to **incomplete data** on important topics like domain trusts, constrained delegation, and admin groups.
- **💡 Look for Kerberoastable Users**: These users are often a target during attacks. **Check this section in the report immediately** during the exam.
- **🚨 Navigate the Reports Quickly**: Opening the report via browser (`firefox index.html`) is faster than manually looking through directories and will save precious exam time.
- **🚨 Watch for GPOs and Admin Groups**: During the exam, questions may target how to identify misconfigurations in **Group Policy Objects (GPOs)** or admin group memberships.

---

## 🔑 Key Takeaways for the Exam

- **PlumHound** allows for fast and effective domain enumeration. The key is to extract domain controllers, admin groups, and vulnerable user accounts (like Kerberoastable users) efficiently.
- **Command Memorization**: Make sure you know the critical commands (`-easy` for quick queries, `x` for full tasks) to avoid skipping essential steps during the exam.
- **Visual Report Navigation**: Use the browser to visualize and navigate the reports without getting bogged down in the file system.

---

These notes now include **clear action steps**, **critical mentions**, and more detailed explanations to help guide you through the commands and outputs during the exam. They are structured for **quick scanning** and reference, making them ideal for an open-book format.