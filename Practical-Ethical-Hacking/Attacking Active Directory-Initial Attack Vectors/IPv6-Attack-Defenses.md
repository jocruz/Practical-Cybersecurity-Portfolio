---

### 🛡️ **IPv6 Attack Defenses**

- **Overview**: IPv6 poisoning leverages the fact that Windows queries for IPv6 addresses even in environments that primarily use IPv4. To prevent attacks like **mitm6**, the following defenses can be implemented:

### **Firewall Rules via Group Policy**:

- **Block the following inbound and outbound rules** to prevent IPv6 poisoning:
    - **(Inbound)**: Core Networking - Dynamic Host Configuration Protocol for IPv6 (**DHCPV6-In**)
    - **(Inbound)**: Core Networking - Router Advertisement (**ICMPv6-In**)
    - **(Outbound)**: Core Networking - Dynamic Host Configuration Protocol for IPv6 (**DHCPV6-Out**)

🚨 **Critical Mention**: **Disabling IPv6 entirely** can lead to unwanted side effects. It’s safer to block specific traffic like **DHCPv6** and **router advertisements** instead.

### **WPAD (Web Proxy Auto-Discovery Protocol)**:

- If **WPAD** is not used internally, **disable it via Group Policy** and stop the `winhttpautoproxysvc` service to prevent proxy-based attacks.

### **LDAP and LDAPS Protection**:

- **Relaying to LDAP/LDAPS** can only be prevented by:
    - Enabling **LDAP signing**.
    - Enabling **LDAP channel binding**.

### **Protecting Administrative Users**:

- Add **administrative accounts** to the **Protected Users** group or mark them as **Account is sensitive and cannot be delegated** to prevent their impersonation via delegation attacks.

---

This section provides a comprehensive guide for preventing the attacks you’ve been studying, using **firewall settings**, **group policy modifications**, and specific **LDAP protections**. Let me know if you’d like any additional details!