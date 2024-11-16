---

# 🕵️‍♂️ **Domain Enumeration with Bloodhound**

---

### 📋 **Summary**:

**Bloodhound** is a tool designed for **Active Directory enumeration** and **privilege escalation pathfinding**. It visualizes relationships between users, groups, computers, and policies within a domain. This guide walks through setting up **Neo4j**, running **bloodhound-python** to gather data, and analyzing the results in the **Bloodhound UI** to identify critical paths and targets, such as **Domain Admins**.

💡 **Key Action**: Use **Bloodhound** to find high-value targets like **Domain Admins** and map out privilege escalation paths within Active Directory.

---

### 🛠️ **Detailed Notes**:

### **1. Setting Up Neo4j for Bloodhound**:

- Start the **Neo4j database**, which Bloodhound uses to store AD relationships:
    
    ```bash
    sudo neo4j console
    
    ```
    
    - You’ll see the **server address** and **port**:
        
        ```bash
        Bolt enabled on localhost:7687.
        Remote interface available at <http://localhost:7474/>
        
        ```
        
    - **Log into Neo4j** by visiting the provided URL (`http://localhost:7474/`) and using:
        - **Username**: `neo4j`
        - **Password**: `neo4j1`

💡 **Tip**: **Neo4j** is essential for running **Bloodhound** as it manages the relationships between AD objects.

---

### **2. Running Bloodhound**:

- **Start Bloodhound** after setting up Neo4j:
    
    ```bash
    sudo bloodhound
    
    ```
    
    - This launches the **Bloodhound UI** where you can later upload data for analysis.

---

### **3. Gathering Data with bloodhound-python**:

- Create a directory for **Bloodhound** output:
    
    ```bash
    mkdir ~/Documents/PEH/bloodhound
    
    ```
    
- Run **bloodhound-python** to collect AD data:
    
    ```bash
    sudo /home/kali/.local/share/pipx/venvs/crackmapexec/bin/bloodhound-python -d MARVEL.local -u fcastle -p Password1 -ns 192.168.164.138 -c all
    
    ```
    
    - **Explanation**:
        - This command connects to the domain controller (`192.168.164.138`) and gathers data using **Frank Castle’s** credentials.
        - It will collect information on users, groups, computers, GPOs, and more.

🚨 **Critical Mention**: If **Kerberos TGT** fails, Bloodhound will automatically fall back to **NTLM authentication**. Ensure NTLM fallback is allowed in your environment.

- **Output**:
    - Bloodhound will find information such as:
        - **Domains**: 1
        - **Computers**: 3
        - **Users**: 9
        - **Groups**: 52
        - **GPOs**: 3
- **Files Generated**:
    
    ```bash
    ls ~/Documents/PEH/bloodhound
    
    ```
    
    - You will see JSON files like `20240921211949_computers.json`, `20240921211949_users.json`, etc.

---

### **4. Uploading Data to Bloodhound UI**:

- Go to the **Bloodhound UI**:
    - Click **Upload Data** (on the right side).
    - Navigate to the **bloodhound** directory and upload the JSON files (`~/Documents/PEH/bloodhound`).

💡 **Tip**: Upload all the JSON files to get a complete picture of the AD environment.

- **Analyze Data**:
    - Go to the **Analysis** tab in the top-left menu.
    - Click on **Find All Domain Admins** to visualize the connections between **Domain Admins** and other entities.
    - Click on nodes to explore **GPO memberships**, **reachable high-value targets**, and other critical information.

🚨 **Critical Mention**: Focus on **Domain Admin logins** into non-domain controllers for potential exploitation via **token impersonation**.

---

### 📖 **Abbreviations & Definitions**:

- **Neo4j**: A graph database used by Bloodhound to store and analyze relationships within Active Directory.
- **Bloodhound**: A tool for mapping Active Directory relationships and privilege escalation paths.
- **bloodhound-python**: A Python-based tool used to gather data for Bloodhound.
- **GPO**: Group Policy Objects, used to enforce security settings and permissions within AD.
- **NTLM Authentication**: A fallback authentication protocol used if **Kerberos** fails.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **Kerberos Failures**: If **Kerberos** fails during data collection, make sure NTLM fallback is enabled, or the query will fail.
- **Kerberoastable Targets**: Use the **Kerberos Interaction** analysis to find **Kerberoastable members** of high-value groups, which can be attacked using **Kerberoasting**.

💡 **Tip**: Mark **owned** or **high-value targets** in Bloodhound to track key users and privilege escalation paths.

---

### 📌 **Potential Pitfalls**:

1. **Insufficient Data in Small Domains**:
    - In smaller domains, Bloodhound may not return much data. However, focus on **Domain Admin logins** into non-domain controllers and potential **GPO misconfigurations**.
2. **Upload All Data**:
    - Make sure to upload all the JSON files to get a comprehensive view of the domain. Missing any could lead to incomplete analysis.

---

### 💡 **Quick Tips for the Exam**:

- **Start with Domain Admins**: Use the **Find All Domain Admins** feature to prioritize high-value targets for further exploitation.
- **Explore GPOs**: Look for **weak Group Policies** like disabling security features (e.g., Windows Defender) to identify exploitation points.
- **Focus on Kerberos**: Use the **Kerberos Interaction** analysis to identify **Kerberoastable users**, which are vulnerable to **Kerberos-based attacks**.

---