---

# 🔐 **GPP (Group Policy Preferences) Attacks AKA cPassword Attacks Exam Reference**

---

## **Summary**

**Group Policy Preferences (GPP)** allowed admins to include credentials within policies to manage systems, and these credentials were stored in **cPassword**, an encrypted format. However, the encryption key for cPassword was accidentally leaked, making it possible for attackers to decrypt the stored credentials. Although **Microsoft patched** this in **MS14-025**, the patch doesn’t remove older vulnerable GPP files, meaning these attacks are still relevant for penetration tests on unpatched or outdated systems.

---

### **GPP Attack and cPassword Overview**

### **GPP Attack**

- **Group Policy Preferences (GPP)** allowed admins to push system settings, including credentials, to computers in a domain.
- These credentials were stored in an **encrypted form** called **cPassword**.
- Microsoft **accidentally leaked the encryption key**, allowing anyone with access to the GPP files to decrypt the stored passwords.
- Even though the vulnerability was patched in **MS14-025**, older files with **cPassword** can still be exploited if they haven’t been removed.

### **cPassword Overview**:

- **cPassword** is the encrypted version of passwords stored in **GPP XML files**.
- **The Problem**: Microsoft accidentally leaked the **encryption key** for all cPasswords, making it possible for attackers to decrypt and retrieve these passwords.
- **Key Point**: The same encryption key works for all cPasswords, making it a significant vulnerability if these files remain in unpatched systems.

---

---

## **Detailed Notes**

### **Step 1: Understanding the Vulnerability**

- **Group Policy Preferences (GPP)** were used by Windows administrators to push out system policies, including **credentials** (e.g., local admin passwords, service accounts).
- These credentials were stored in **cPassword** (an encrypted format within Group Policy XML files).
- Unfortunately, **Microsoft accidentally released the encryption key** for cPassword, making it possible for attackers to decrypt these passwords.
- **MS14-025 Patch**: Microsoft released this patch to stop new cPasswords from being used, but it did **not remove old vulnerable files**, so if those files are still present, they can be exploited.

---

### **Step 2: Steps to Conduct a GPP Attack**

1. **Identify Vulnerable Systems**:
    - Find systems or domain controllers that still have old Group Policy files with cPassword and have **not been cleaned up** after the MS14-025 patch.
2. **Locate the GPP XML Files**:
    - The **SYSVOL** share on domain controllers contains these Group Policy XML files.
    - Search for XML files related to GPP, which may include **cPassword** data.
3. **Exploit Using Metasploit**:
    - Use Metasploit’s **smb_enum_gpp** module to find and decrypt the cPassword:
        
        ```bash
        msfconsole
        search smb_enum_gpp
        use auxiliary/admin/smb/smb_enum_gpp
        set SMBUser <valid_user>
        set SMBPass <valid_password>
        set RHOSTS <target_ip>
        run
        
        ```
        
    - If the module finds **cPassword** in the Group Policy files, it will automatically decrypt and display the credentials in the terminal.

---

## **Abbreviations & Definitions**

- **GPP (Group Policy Preferences)**: A Windows feature allowing administrators to manage policies that include credentials for systems.
- **cPassword**: The encrypted password stored in GPP XML files, which can be decrypted due to the leaked encryption key.
- **MS14-025**: The Microsoft patch that stopped the use of cPassword but did not clean up existing vulnerable files.
- **SYSVOL**: A shared folder on domain controllers where Group Policy files are stored.
- **SMB (Server Message Block)**: A protocol used for network file sharing.
- **Metasploit**: A popular penetration testing framework that allows for automated exploitation of vulnerabilities.

---

## **Critical Mentions & Exam Traps**

- 🚨 **MS14-025 doesn’t delete old files**: Even if the system is patched, vulnerable files could still exist. **Always check for leftover XML files** containing cPassword.
- 💡 **Valid credentials required**: You’ll need valid credentials to run the Metasploit module and access the Group Policy files (GPP XML files).
- 📝 **Vulnerable XML files in SYSVOL**: Focus your search on the **SYSVOL** share of the domain controller, where GPP files are stored.
- 🚨 **Even patched systems can still be vulnerable**: Just because the system has MS14-025 doesn’t mean it’s immune—if old files exist, they can still be exploited.

---

## **Easy-to-Digest Summary of the Steps We Took**

### **GPP Attack Process Overview**:

1. **Identify vulnerable systems**: Look for unpatched systems or old Group Policy files on the **domain controller**.
2. **Search for Group Policy XML files**: These files are stored in **SYSVOL** and may contain **cPassword** (encrypted credentials).
3. **Exploit with Metasploit**: Use the **smb_enum_gpp** module to search for XML files and decrypt the cPassword if found.

### **Quick Reference of Commands**:

1. **Search for the Metasploit module**:
    
    ```bash
    search smb_enum_gpp
    
    ```
    
2. **Set credentials and target**:
    
    ```bash
    set SMBUser <valid_user>
    set SMBPass <valid_password>
    set RHOSTS <target_ip>
    
    ```
    
3. **Run the module**:
    
    ```bash
    run
    
    ```
    

### **Summary of Key Concepts**:

- **GPP vulnerability**: Admins used embedded credentials in **cPassword** for system policies.
- **cPassword can be decrypted**: Because the encryption key was leaked, attackers can decrypt the stored passwords.
- **MS14-025 doesn’t clean up old files**: Patched systems may still have vulnerable files.

---