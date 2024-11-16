---

## 🌐 Common Network Commands

***In simpler terms:***

***These network commands are like using different tools to check various aspects of a building’s plumbing system—from seeing the blueprint (network configuration) to testing water flow (network connectivity).***

### **Core Network Commands**

### **ip a**

- **Function:** Shows network interfaces and IP addresses.
- **Example:** `ip a` → Displays details like IP addresses, MAC addresses, and more for all network interfaces.

### **ifconfig**

- **Function:** Shows network interfaces’ configuration.
- **Example:** `ifconfig` → Outputs configuration details such as IP and MAC addresses for active interfaces.

### **iwconfig**

- **Function:** Manages wireless network interfaces.
- **Example:** `iwconfig` → Displays wireless settings, including signal strength and encryption status.

### **ip n**

- **Function:** Shows Neighbor Table with IP-to-MAC address mappings.
- **Example:** `ip n` → Lists IP and MAC addresses of recently communicated devices.

### **arp -a**

- **Function:** Shows ARP cache, mapping IP addresses to MAC addresses.
- **Example:** `arp -a` → Outputs IP and MAC address mappings from the ARP cache.

### **ip r**

- **Function:** Displays routing table.
- **Example:** `ip r` → Shows routes, gateway IPs, and interface details.

### **route**

- **Function:** Manages the IP routing table.
- **Example:** `route` → Similar to `ip r`, displays the routing table.

### **Network Testing Commands**

### **ping**

- **Function:** Tests network connectivity to an IP address.
- **Example:** `ping 8.8.8.8` → Sends ICMP requests to Google’s DNS server and shows connectivity stats.

### **Additional Details**

- These commands help in troubleshooting, setting up, or checking network configurations.
- Each tool provides specific information related to network interfaces, connectivity, and route planning.

---