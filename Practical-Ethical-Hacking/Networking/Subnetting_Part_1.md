![Screenshot 2024-08-05 at 10.54.59 PM.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/6be55db8-82c5-4f94-8f52-83c9d5cb1157/690370a2-7572-4e3f-828a-859462315729/Screenshot_2024-08-05_at_10.54.59_PM.png)

Cheat sheet for Subnetting

---

## 🌐 Subnetting Part 1

***In simpler terms:***

***Subnetting is like dividing a large block of apartments into smaller units, making it easier to manage and more efficient to use.***

### **Resources**

- **Seven Second Subnetting:** [YouTube Link](https://www.youtube.com/watch?v=ZxAwQB8TZsM)
- **Subnet Guide:** [Google Drive Link](https://drive.google.com/file/d/1ETKH31-E7G-7ntEOlWGZcDZWuukmeHFe/view)

### **Concept of Subnetting**

- **Purpose:** Divides a network into smaller, manageable subnetworks (subnets).
- **Utility:** Increases efficiency in using IP addresses and simplifies network management.

### **Key Components**

1. **CIDR Notation:**
    - **Example:** `192.168.0.0/24`
    - **Explanation:** "/24" indicates the first 24 bits are the network part, leaving 8 bits for host addresses.
    - **Subnet Mask:** Corresponds to `255.255.255.0`.
2. **Subnetting Example:**
    - **Original Network:** `192.168.0.0/24`
    - **Borrowing 2 Bits:** Creates 4 subnets, changing the subnet mask to `255.255.255.192`.
    - **Subnets Created:**
        - Subnet 1: `192.168.0.0/26` (Range: `192.168.0.0 - 192.168.0.63`)
        - Subnet 2: `192.168.0.64/26` (Range: `192.168.0.64 - 192.168.0.127`)
        - Subnet 3: `192.168.0.128/26` (Range: `192.168.0.128 - 192.168.0.191`)
        - Subnet 4: `192.168.0.192/26` (Range: `192.168.0.192 - 192.168.0.255`)

### **Understanding IP Addresses and Subnet Masks**

- **IP Division:** Network portion and host portion.
- **Subnet Mask Usage:** Identifies network vs. host parts of an IP address.

### **Methodology for Subnetting**

1. **Identify Original Subnet Mask:** Begin with the existing subnet mask.
2. **Determine Subnets Needed:** Use the formula \(2^n\) to find bits to borrow for required subnets.
3. **Calculate New Subnet Mask:** Add borrowed bits to original mask.
4. **Usable Hosts Calculation:** Subtract 2 from total hosts for network and broadcast addresses.

### **Example Calculation**

- **Scenario:** Create 5 subnets from IP `192.168.10.0/24`.
- **Steps:**
    - Original Mask: `/24` (255.255.255.0)
    - Needed Subnets: 5, \(2^3 = 8\) (borrow 3 bits)
    - New Subnet Mask: `/27` (255.255.255.224)
    - Usable Hosts: 30 per subnet

---