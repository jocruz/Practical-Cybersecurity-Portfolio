---

## 🌐 Subnetting Part 2

***In simpler terms:***

***Subnetting divides a large network into smaller sections to better manage and utilize IP addresses. It's like allocating rooms in a large building to different departments.***

### **Subnetting Notes for Specific IPs**

### **1️⃣ IP Address: `192.168.0.0/22`**

- **Subnet Mask:** `255.255.252.0`
- **Usable Hosts:** 1022
- **Network Address:** `192.168.0.0`
- **Broadcast Address:** `192.168.3.255`
- **IP Range:** `192.168.0.0 - 192.168.3.255`
- **Details:** /22 means using 22 bits for the network, leaving 10 bits for hosts. This setup allows for 1022 usable addresses after accounting for network and broadcast addresses.

### **2️⃣ IP Address: `192.168.1.0/26`**

- **Subnet Mask:** `255.255.255.192`
- **Usable Hosts:** 62
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.63`
- **IP Range:** `192.168.1.0 - 192.168.1.63`
- **Details:** /26 uses 26 bits for the network, with 6 bits for hosts, providing 62 usable addresses.

### **3️⃣ IP Address: `192.168.1.0/27`**

- **Subnet Mask:** `255.255.255.224`
- **Usable Hosts:** 30
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.31`
- **IP Range:** `192.168.1.0 - 192.168.1.31`
- **Details:** /27 allocates 27 bits to the network and 5 bits to hosts, resulting in 30 usable addresses.

### **Methodology for Subnetting**

1. **Subnet Mask Determination:**
    - Derive from CIDR notation (e.g., /22 becomes `255.255.252.0`).
2. **Usable Hosts Calculation:**
    - Formula: \(2^{{host bits}} - 2\), subtract 2 for network and broadcast addresses.
3. **Network and Broadcast Addresses Identification:**
    - **Network Address:** First address in the subnet (all host bits `0`).
    - **Broadcast Address:** Last address in the subnet (all host bits `1`).
4. **Usable IP Range:**
    - Starts after the network address and ends before the broadcast address.

---