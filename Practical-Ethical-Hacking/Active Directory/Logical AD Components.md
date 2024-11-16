---

## 🏢 Logical AD Components

### 📝 Summary

Active Directory (AD) uses several logical components to manage network resources and security. These components include the **AD DS Schema**, **Domains**, **Trees**, **Forests**, **Organizational Units (OUs)**, and **Trusts**. Understanding these elements is crucial for effectively organizing, managing, and securing an Active Directory environment.

### 📋 Detailed Notes

### 1. **The AD DS Schema** 📖

- **What is it?** The **Schema** acts as the blueprint for the entire AD structure. It defines every type of object that can exist in the directory and enforces rules about object creation and configuration.
- **Object Types**:
    - **Class Objects:** Determine what objects can be created in the directory (e.g., User, Computer).
    - **Attribute Objects:** Provide information that can be attached to an object (e.g., Display Name, Email).
- **Key Points**:
    - **Rules Enforcement:** The schema ensures that all objects follow the established rules and structure when they are created or modified.

| Object Types | Function | Examples |
| --- | --- | --- |
| **Class Object** | Specifies what can be created in AD | User, Computers |
| **Attribute** | Information attached to the object | Display Name, Title |

### 2. **Domains** 🌐

- **Definition:** Domains group and manage objects in an organization, serving as the primary logical structure in AD.
- **Key Functions**:
    - **Administrative Boundary:** Allows for applying policies to groups of objects.
    - **Replication Boundary:** Manages data replication between domain controllers.
    - **Authentication and Authorization:** Limits access to resources within the domain.

### 3. **Trees** 🌲

- **Definition:** A **Domain Tree** is a hierarchy of domains within Active Directory.
- **Key Points**:
    - All domains in the tree share a **contiguous namespace** with the parent domain (e.g., `child.parent.com`).
    - **Child Domains** can be created within the tree, expanding the domain structure.
    - **Two-Way Transitive Trust:** By default, all domains within a tree automatically create a **two-way transitive trust**, allowing seamless access across domains.

### 4. **Forests** 🌳

- **Definition:** A **Forest** is a collection of one or more domain trees.
- **Key Features**:
    - **Common Schema:** All domains in the forest share a single schema.
    - **Configuration Partition:** They share a common configuration partition, ensuring consistency across domains.
    - **Global Catalog:** The forest includes a **Global Catalog** that enables searching across all domains.
    - **Trusts:** Enables trusts between all domains in the forest, allowing resource access.
    - **Administrative Groups:** Shares **Enterprise Admins** and **Schema Admins** groups for forest-wide management.

### 5. **Organizational Units (OUs)** 🗂️

- **What are they?** OUs are containers within AD that hold users, groups, computers, and other OUs.
- **Purpose**:
    - **Hierarchical Representation:** Organizes resources in a logical, hierarchical manner, mirroring an organization's structure.
    - **Management:** Allows for the consistent management of objects within the OU.
    - **Delegation:** Enables administrators to delegate permissions to manage groups of objects.
    - **Policy Application:** Used for applying Group Policies to a collection of objects.

### 6. **Trusts** 🤝

- **Definition:** Trusts allow users in one domain to access resources in another domain.
- **Types of Trusts**:
    
    
    | Type of Trust | Description |
    | --- | --- |
    | **Directional** | The trust direction flows from the trusting domain to the trusted domain. |
    | **Transitive** | The trust relationship extends beyond two domains, including other trusted domains. |
- **Forest-Wide Trusts:** All domains within a forest trust each other by default, enabling seamless resource access.

### 📖 Abbreviations & Definitions

- **AD DS (Active Directory Domain Services):** The directory service that stores information about objects on the network and makes it easy for administrators to manage permissions and access to resources.
- **Schema:** The set of rules that define what types of objects (e.g., users, computers) can exist in the directory and their attributes.
- **OU (Organizational Unit):** A container in AD that can contain users, groups, computers, and other OUs, used for organizing resources and applying policies.
- **Global Catalog:** A distributed data repository that contains a searchable, partial representation of every object in every domain within the forest.
- **Trust:** A relationship established between domains to allow access to resources.

### 🚨 Critical Mentions & Exam Traps

- **🚨 Schema Structure:** Remember that the schema defines **both class objects** (e.g., User, Computer) and **attribute objects** (e.g., Display Name). This distinction is crucial when configuring and managing AD.
- **💡 Domains as Boundaries:** Domains act as **administrative, replication, and security boundaries**. Understanding their functions helps in proper domain management and policy application.
- **🔑 OUs for Delegation:** **OUs** are essential for delegating administrative permissions. They help manage a collection of objects in a consistent way, mirroring the organization's hierarchy.
- **⚠️ Trust Directionality:** **Directional Trusts** flow from the **trusting** domain to the **trusted** domain. **Transitive Trusts** extend beyond two domains, enabling access across multiple trusted domains.

---