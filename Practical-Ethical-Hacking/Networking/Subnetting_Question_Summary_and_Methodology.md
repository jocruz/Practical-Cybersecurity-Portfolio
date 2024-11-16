---

### 📝 **Subnetting Summary and Methodology**

### **🎓 Example Recap:**

---

***Question:***

You have the IP address **192.168.10.0/24** and need to create 5 subnets. What subnet mask should you use, and how many usable host IP addresses will be available per subnet?

---

***Method:***

- **Step 1:** Start with ***/24*** (subnet mask: **255.255.255.0**).
- **Step 2:** You need 5 subnets, so calculate **2^3 = 8** (borrow 3 bits).
- **Step 3:** New subnet mask is ***/27*** (**255.255.255.224**).
- **Step 4:** Calculate usable hosts: **2^5 - 2 = 30** usable hosts.

---

***Answer:***

Subnet mask: **255.255.255.224** (***/27***), **30** usable hosts per subnet.

---

### **🔍 Understanding IP Address and Subnet Mask:**

- We started by understanding that an IP address is divided into a ***network portion*** and a ***host portion***.
- The **subnet mask** helps identify which part of the IP address is for the network and which part is for hosts.

---

### **🔗 Borrowing Bits for Subnetting:**

- When creating subnets, you "borrow" bits from the **host portion** to increase the number of subnets.
- The more bits you borrow, the more subnets you can create, but this reduces the number of available hosts in each subnet.

---

### **🚫 Why Subtract 2 from the Total Hosts:**

- We subtract **2** from the total number of hosts in a subnet because:
    - The first address is reserved for the ***network address***.
    - The last address is reserved for the ***broadcast address***.

---

### **🔧 Methodology for Answering Subnetting Questions:**

---

### **1️⃣ Identify the Original Subnet Mask:**

- Start with the original subnet mask given in the question (e.g., ***/24***, ***/16***, etc.).

---

### **2️⃣ Determine How Many Subnets You Need:**

- Look at the number of subnets required.
- Use the formula **2^n** to determine how many bits to borrow, where **n** is the number of bits needed to create enough subnets.
- Find the smallest ***n*** such that **2^n** is greater than or equal to the required number of subnets.

---

### **3️⃣ Calculate the New Subnet Mask:**

- Add the number of borrowed bits to the original subnet mask to get the new subnet mask (e.g., ***/24*** + 3 bits = ***/27***).

---

### **4️⃣ Determine the New Subnet Mask in Decimal Form:**

- Convert the new subnet mask from **binary** to **decimal**.
- For example, ***/27*** corresponds to **255.255.255.224**.

---

### **5️⃣ Calculate Usable Hosts:**

- Subtract **2** from the total number of possible IP addresses in the subnet to get the number of usable hosts.
- For example, a ***/27*** subnet has **2^5 = 32** total IP addresses, so **32 - 2 = 30** usable hosts.

---

---