---

### 🖨️ **How to Hack Through a Pass-Back Attack: MFP Hacking Guide**

---

### 📋 **Summary**:

This guide focuses on **Multi-Function Peripherals (MFPs)**, devices commonly overlooked in penetration testing. MFPs are typically connected to corporate networks, integrated with LDAP, SMTP, and network shares, which makes them a potential entry point for attackers. **MFP hacking** allows you to exploit weak configurations to extract credentials or escalate privileges using a **pass-back attack**.

The **pass-back attack** involves accessing the MFP’s Embedded Web Service (EWS), altering LDAP or SMTP settings, and capturing sensitive credentials by redirecting authentication traffic to a malicious server controlled by the attacker.

### **Why is it called "Pass-Back"?**

The term “pass-back” comes from the idea that the system is trying to pass credentials to a server for authentication. In this case, you’re "passing back" the credentials to your own server instead of the real server, where you can capture them.

---

### 🛠️ **Detailed Notes**:

### **1. Understanding MFP Hacking**:

- **MFP**: Multi-Function Peripherals like printers with networking capabilities, often found in corporate environments.
- MFPs integrate with **LDAP**, **SMTP**, and **Network Shares**, making them vulnerable targets.
- Most MFPs ship with **default administrative credentials**, which are usually left unchanged.

### **2. MFP-LDAP Integration**:

- **LDAP integration** allows MFPs to:
    - Lookup user email addresses for scan/email functionality.
    - Grant access to network resources, such as home directories.
- Credentials used for LDAP queries are stored on the MFP and can be captured.

### **3. Accessing the Embedded Web Service (EWS)**:

- Default admin credentials for common vendors:
    - **Ricoh**: Username: `admin` | Password: *(blank)*
    - **HP**: Username: `admin` | Password: `admin` or *(blank)*
    - **Canon**: Username: `ADMIN` | Password: `canon`
    - **Epson**: Username: `EPSONWEB` | Password: `admin`
    
    **Tools for EWS access**:
    
    - **PRET** (Printer Exploitation Toolkit): [GitHub Link](https://github.com/RUB-NDS/PRET)
    - **Praeda**: [GitHub Link](https://github.com/percx/Praeda)

---

### **4. Pass-Back Attack**:

**Step-by-Step**:

1. **Access the EWS**: Log into the MFP’s web interface using default or guessed credentials.
2. **Replace LDAP Server**: In the MFP’s LDAP settings (usually found in the networking tab):
    - Replace the existing LDAP server (e.g., `192.168.1.100`) with your **malicious LDAP server** IP address.
3. **Set Up a Netcat Listener**: Open a **Netcat listener** on port 389 (or the port specified in the LDAP settings).
💡 **Example Output**:
    
    ```bash
    nc -lvnp 389
    
    ```
    
    ```
    Connection from 192.168.1.101 received!
    Username: admin
    Password: MyPassword123!
    
    ```
    
4. **Capture Credentials**: Once a user tries to authenticate via the MFP (e.g., using scan-to-email), the MFP will send their credentials to your LDAP server.

---

### **5. Attacking SMTP and Windows Sign-In**:

- **SMTP Configuration**:
    - Modify the **SMTP server** in the MFP settings to point to your server.
    - Capture the stored **SMTP authentication credentials** when the MFP sends mail through your malicious SMTP server.
- **Windows Sign-In**:
    - Replace the domain in the **Windows sign-in** settings with your domain.
    - When a domain user signs in via the MFP control panel, their credentials are sent to your **domain controller**.

---

### 📖 **Abbreviations & Definitions**:

- **MFP**: Multi-Function Peripherals, devices like printers with network capabilities.
- **EWS**: Embedded Web Service, the web interface for managing MFP settings.
- **LDAP**: Lightweight Directory Access Protocol, used for directory queries and authentication.
- **SMTP**: Simple Mail Transfer Protocol, used for sending emails.
- **PRET**: Printer Exploitation Toolkit, a tool for attacking printers.
- **Netcat**: A networking tool used for creating TCP/UDP connections to listen for data.
- **Pass-Back Attack**: A method of capturing credentials by redirecting authentication attempts to a malicious server.

---

### 🚨 **Critical Mentions & Exam Traps**:

- **MFP Defaults**: Many MFPs ship with **default credentials** that are never changed. Always check for these before attempting complex attacks.
- **LDAP and SMTP Servers**: When modifying the **LDAP** or **SMTP** settings, ensure you correctly set up your **malicious server** and listener to avoid missing critical credential capture.
- **Physical Access**: MFPs are often **physically accessible** in corporate environments, making them an easy and often overlooked target for exploitation.

---

### 📌 **Potential Pitfalls**:

1. **Incorrect LDAP Configuration**:
    - If the wrong IP or port is used for the malicious LDAP server, the MFP won’t connect, and no credentials will be captured.
2. **SMTP Attack Fails**:
    - Ensure that the **SMTP port** and authentication method match the original settings to capture credentials correctly.
3. **Overlooking Physical Security**:
    - MFPs are often **physically accessible**, but **underutilized** in penetration tests. Always check local printers if you cannot find other attack vectors.

---

### 💡 **Quick Tips for the Exam**:

- **Start with Default Admin Credentials**: Always try default credentials first (e.g., `admin/admin` for HP) before moving to more complex attack vectors.
- **Use PRET or Praeda**: These tools can automate information gathering and code execution on MFPs, saving time.
- **Set Up a Netcat Listener**: Make sure your listener is ready to capture credentials as soon as the attack is triggered.
- **LDAP/SMTP Configuration**: Modify LDAP and SMTP settings carefully, and always test that the MFP sends credentials to your malicious server.

---

**Final Additions**:

- I’ve added an **example output** of the Netcat listener to show what successful credential capture looks like. This is crucial for verifying during an exam.
- Key steps like **configuring the listener** and **modifying LDAP/SMTP settings** have been further emphasized to make sure they stand out for quick reference.

With these minor adjustments, the notes are now fully ready for an open-book exam, optimized for fast access to critical information. Let me know if this works for you or if you need any further tweaks!