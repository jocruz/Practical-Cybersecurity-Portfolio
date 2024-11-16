---

### 📝 **Subnetting Notes for Specific IPs**

---

### **1️⃣ IP Address: `192.168.0.0/22`**

- **Subnet Mask:** `255.255.252.0`
- **Number of Usable Hosts:** 1022
- **Network Address:** `192.168.0.0`
- **Broadcast Address:** `192.168.3.255`

---

- *🔧 **How We Got the Subnet:**
- **/22** means the first 22 bits are for the network, and the remaining 10 bits are for the hosts.
- **Subnet Mask:** Convert the first 22 bits to the subnet msask `255.255.252.0`.
- *🔧 **Calculating Hosts:**
- Hosts = \(2^{{host bits}} - 2\)
- \(2^{10} - 2 = 1022\) usable hosts.
- *🔧 **Network and Broadcast:**
- **Network Address:** `192.168.0.0` (the starting point of the subnet).
- **Broadcast Address:** `192.168.3.255` (the last address in the range, where all host bits are `1`).

**💡 Key Points:**

- The range of IP addresses in this subnet spans from `192.168.0.0` to `192.168.3.255`.

---

### **2️⃣ IP Address: `192.168.1.0/26`**

- **Subnet Mask:** `255.255.255.192`
- **Number of Usable Hosts:** 62
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.63`

---

- *🔧 **How We Got the Subnet:**
- **/26** means the first 26 bits are for the network, and the remaining 6 bits are for the hosts.
- **Subnet Mask:** Convert the first 26 bits to the subnet mask `255.255.255.192`.
- *🔧 **Calculating Hosts:**
- Hosts = \(2^{{host bits}} - 2\)
- \(2^6 - 2 = 62\) usable hosts.
- *🔧 **Network and Broadcast:**
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.63`

**💡 Key Points:**

- The range of IP addresses in this subnet spans from `192.168.1.0` to `192.168.1.63`.

---

### **3️⃣ IP Address: `192.168.1.0/27`**

- **Subnet Mask:** `255.255.255.224`
- **Number of Usable Hosts:** 30
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.31`

---

- *🔧 **How We Got the Subnet:**
- **/27** means the first 27 bits are for the network, and the remaining 5 bits are for the hosts.
- **Subnet Mask:** Convert the first 27 bits to the subnet mask `255.255.255.224`.
- *🔧 **Calculating Hosts:**
- Hosts = \(2^{{host bits}} - 2\)
- \(2^5 - 2 = 30\) usable hosts.
- *🔧 **Network and Broadcast:**
- **Network Address:** `192.168.1.0`
- **Broadcast Address:** `192.168.1.31`

**💡 Key Points:**

- The range of IP addresses in this subnet spans from `192.168.1.0` to `192.168.1.31`.

---

### **Methodology for Calculating Subnets, Hosts, Network, and Broadcast Addresses**

---

1. **Determine the Subnet Mask:**
    - Use the number of bits given in the CIDR notation (e.g., /22, /26, /27).
    - Convert the first part (network portion) to a subnet mask (e.g., /22 = 255.255.252.0).
2. **Calculate the Number of Usable Hosts:**
    - Use the formula \(2^{{host bits}} - 2\).
    - Subtract 2 to account for the network and broadcast addresses.
3. **Identify the Network Address:**
    - The network address is the first IP address in the subnet range, where all host bits are set to `0`.
4. **Identify the Broadcast Address:**
    - The broadcast address is the last IP address in the subnet range, where all host bits are set to `1`.
5. **Determine the Range of Usable IPs:**
    - The usable IP range starts after the network address and ends before the broadcast address.

---