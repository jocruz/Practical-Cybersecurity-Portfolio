---

---

### **In Easier Terms** 📖

Active Directory is like a big phone book for Windows that helps manage and organize information about users, computers, printers, and more. It uses a system called **Kerberos** to authenticate users, but even non-Windows devices can connect using **RADIUS** or **LDAP**. It’s the most widely used identity management service, and interestingly, you don’t always have to find technical vulnerabilities to exploit it—you can take advantage of how it’s set up, like trusts and built-in features.

---

# 🌐 Active Directory Overview

### 🗂️ What is Active Directory?

- **Directory service** developed by Microsoft to manage Windows domain networks.
- Think of it as **Windows' phone book** that stores information on objects like:
    - 🖥️ **Computers**
    - 👤 **Users**
    - 🖨️ **Printers**

### 🔑 Authentication

- Authenticates using **Kerberos tickets**.
- Non-Windows devices (like Linux machines, firewalls) can authenticate using:
    - 🛡️ **RADIUS**
    - 📡 **LDAP**

### 🌍 Identity Management

- **Most commonly used** identity management service worldwide.

### 🔓 Exploiting Active Directory

- **No need to attack patchable exploits**.
- Instead, we abuse:
    - 🔗 **Trusts**
    - ⚙️ **Features**
    - 🧩 **Components** and more.

---

---

### **Definitions** 📘

- **Active Directory (AD)**: A directory service developed by Microsoft to manage Windows domain networks, storing information about objects like computers, users, and printers.
- **Kerberos**: A network authentication protocol that uses tickets to allow nodes to communicate over a non-secure network and prove their identity securely.
- **RADIUS (Remote Authentication Dial-In User Service)**: A networking protocol that provides centralized Authentication, Authorization, and Accounting (AAA) management for users who connect and use a network service. Non-Windows devices like Linux machines and firewalls can authenticate to AD via RADIUS.
- **LDAP (Lightweight Directory Access Protocol)**: A protocol used to access and maintain distributed directory information services, like Active Directory, and often used by non-Windows devices to authenticate with AD.

---

This **Definitions** section adds clarity to key terms!