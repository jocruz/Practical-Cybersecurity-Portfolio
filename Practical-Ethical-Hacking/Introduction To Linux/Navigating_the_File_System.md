---

## 🌐 Navigating the File System

***In simpler terms:***

***Navigating a file system in Linux is like exploring different rooms in a building, each with its own contents and rules. Commands are like keys that help you open doors, move items, or rearrange the rooms.***

### **Core Commands**

### **pwd (Print Working Directory)**

- **Function:** Shows your current directory.
- **Example:** `pwd` → Outputs "/home/user/documents"

### **cd (Change Directory)**

- **Function:** Changes the current directory.
- **Example:** `cd /home/user/documents` → Moves to "/home/user/documents"

### **cd .. (Parent Directory)**

- **Function:** Moves up one directory level.
- **Example:** From "/home/user/documents", `cd ..` → Moves to "/home/user"

### **ls (List Directory Contents)**

- **Function:** Lists contents of the current directory.
- **Example:** `ls` → Shows files and directories.

### **ls -la (Detailed List)**

- **Function:** Lists detailed information, including hidden files.
- **Example:** `ls -la` → Shows detailed file and directory list.

### **mkdir (Make Directory)**

- **Function:** Creates a new directory.
- **Example:** `mkdir new_folder` → Creates a directory named "new_folder".

### **rmdir (Remove Directory)**

- **Function:** Removes an empty directory.
- **Example:** `rmdir empty_folder` → Deletes "empty_folder" if empty.

### **Advanced Commands**

### **man (Manual)**

- **Function:** Shows the manual for commands.
- **Example:** `man ls` → Displays detailed info about `ls`.

### **echo**

- **Function:** Outputs text or variables.
- **Example:** `echo "Hello, world!"` → Prints "Hello, world!".

### **> (Output Redirection)**

- **Function:** Redirects output to a file, overwriting it.
- **Example:** `echo "Hello" > greeting.txt` → Writes "Hello" to "greeting.txt".

### **>> (Append Output)**

- **Function:** Appends output to a file.
- **Example:** `echo "World!" >> greeting.txt` → Adds "World!" to "greeting.txt".

### **rm (Remove)**

- **Function:** Deletes files.
- **Example:** `rm file.txt` → Deletes "file.txt".

### **mv (Move)**

- **Function:** Moves or renames files.
- **Example:** `mv file.txt new_directory/file_renamed.txt` → Moves and renames "file.txt".

### **cp (Copy)**

- **Function:** Copies files.
- **Example:** `cp file.txt backup/file_copy.txt` → Copies "file.txt" to "backup".

### **locate**

- **Function:** Searches for files in a database.
- **Example:** `locate myfile.txt` → Searches for "myfile.txt" and shows the path.

### **updatedb**

- **Function:** Updates the database for `locate`.
- **Example:** `updatedb` → Updates the file search database.

### **passwd**

- **Function:** Changes a user's password.
- **Example:** `passwd` → Prompts to change the user's password.

---