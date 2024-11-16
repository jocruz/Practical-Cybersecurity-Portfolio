---

## 🌐 Users and Privileges

***In simpler terms:***

***Understanding file permissions and user commands in Linux is like learning the rules of who can enter certain rooms in a building and what they can do inside those rooms.***

### **Understanding File Permissions (`ls -la` Output)**

### **Permission Categories**

- **Read (r):** View file contents or directory listings.
- **Write (w):** Modify files or contents within directories.
- **Execute (x):** Run files as programs or access directories.

### **Output Example**

- **Line:** `rwxr-x--- 1 user group 4096 May 10 12:34 myfile.txt`
    - **File Type:** `` (regular file)
    - **Owner Permissions:** `rwx` (read, write, execute)
    - **Group Permissions:** `r-x` (read, execute)
    - **Other Users:** `--` (no permissions)
    - **Owner:** `user`
    - **Group:** `group`
    - **File Size:** `4096 bytes`
    - **Modification Date:** `May 10 12:34`
    - **File Name:** `myfile.txt`

### **Key Commands for User Management**

### **chmod (Change Mode)**

- **Function:** Modifies file or directory permissions.
- **Example:** `chmod +x script.sh` — Adds execute permission to `script.sh`.

### **adduser**

- **Function:** Creates a new user account.
- **Example:** `adduser john` — Creates a new user named "john."

### **su (Switch User)**

- **Function:** Switches to another user account.
- **Example:** `su jane` — Switches to the user "jane" after password verification.

### **/etc/sudoers**

- **Function:** Manages sudo permissions.
- **Example:** Viewing the sudoers file to check sudo configurations.

### **sudo -l**

- **Function:** Lists permitted sudo commands for the current user.
- **Example:** `sudo -l` — Shows sudo permissions for the user.

### **Additional Relevant Commands**

### **chown (Change Owner)**

- **Function:** Changes the owner of a file or directory.
- **Example:** `chown bob file.txt` — Changes the owner of `file.txt` to "bob."

### **chgrp (Change Group)**

- **Function:** Changes the group of a file or directory.
- **Example:** `chgrp admins file.txt` — Changes the group of `file.txt` to "admins."

### **passwd**

- **Function:** Changes the password for a user account.
- **Example:** `passwd alice` — Changes the password for the user "alice."

### **usermod**

- **Function:** Modifies user account properties.
- **Example:** `usermod -aG sudo bob` — Adds "bob" to the "sudo" group.

### **groups**

- **Function:** Displays the groups a user belongs to.
- **Example:** `groups john` — Lists the groups associated with "john."

---