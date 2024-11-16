---

---

### **In Easier Terms** 📖

Active Directory has both physical and logical components that keep everything organized and running smoothly. The **physical side** includes things like **domain controllers** (the "big honcho" servers) that manage the AD database (`ntds.dit`) and handle authentication and replication. There's also the **global catalog server**, which helps speed up searches, and the **Read-Only Domain Controller (RODC)**, a limited access version.

On the **logical side**, AD has **partitions** for organizing data, a **schema** that defines the structure, and **domains** that group together users, computers, and more. **Domain trees** connect multiple domains, and **forests** allow different domain trees to share a schema. **Sites** represent the physical network locations of domain controllers, while **Organizational Units (OUs)** help organize everything neatly within the domains.

---

## Domain Controller vs AD DS Data Store:

---

- **Domain Controller**: It's a server in an Active Directory network that handles the important job of **authenticating users and devices**. It stores a copy of the AD database, controls access to network resources, and ensures that updates get shared across all other domain controllers in the network.
- **AD DS Data Store**: This is where all the information for the Active Directory lives, like a **database** that keeps track of users, computers, and other network resources. The main file that holds this information is called **ntds.dit**, and it's stored in the `%systemRoot%\NTDS` folder on the domain controller.

---

### **Definitions** 📘

- **ntds.dit**: The main Active Directory database file, storing all directory information like users and computers.
- **DIT extension**: The file extension used for Active Directory's database file (`ntds.dit`).
- **%systemRoot%\NTDS folder**: The default folder on all domain controllers where the `ntds.dit` file is stored.
- **RADIUS (Remote Authentication Dial-In User Service)**: A networking protocol for managing authentication, authorization, and accounting for users who connect to a network service.
- **LDAP (Lightweight Directory Access Protocol)**: A protocol used to access and manage directory information, such as what’s stored in Active Directory, often used for non-Windows devices to authenticate with AD.

---

### **Active Directory Components** 🛠️

**Physical Components:**

- **Data Store**: Holds the AD DS database (`ntds.dit`).
- **Domain Controllers (DCs)**: 🖥️ The "big honcho" servers with AD DS installed, providing authentication, authorization, and replication services.
- **Global Catalog Server**: 🗂️ A domain controller that stores details about every object in the directory, speeding up searches across domains.
- **Read-Only Domain Controller (RODC)**: 📄 A domain controller that contains a read-only copy of the AD DS database.

**Logical Components:**

- **Partitions**: 🧩 Segments in the AD DS database that organize directory data.
- **Schema**: 🧾 Defines the structure and attributes for all objects stored in the directory.
- **Domains**: 🌍 Logical groupings of objects like users, computers, and printers.
- **Domain Trees**: 🌳 A hierarchy of domains that share a common namespace.
- **Forests**: 🌲 A collection of one or more domain trees sharing a common schema but possibly different namespaces.
- **Sites**: 📍 Physical groupings of domain controllers based on IP addresses.
- **Organizational Units (OUs)**: 📂 Containers within domains used to organize objects like users and computers.