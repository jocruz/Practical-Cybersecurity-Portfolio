# 🌐 Insecure File Upload 0x01: Client-Side Controls Bypass

## ❓ Lab Overview

This lab tests the security of file upload mechanisms by allowing the upload of files and then attempting to bypass the client-side restrictions that limit file types to `.jpg` and `.png`.

---

## 🛠️ Steps and Observations

### 1. Initial Testing
- **Interface Elements:** Includes fields to choose a file and buttons for uploading.
- **File Type Restriction:** Attempting to upload a `.txt` file results in an error message, indicating only `.jpg` and `.png` files are allowed.

### 2. Proxy Interception and Modification
- **Tools Used:** Burp Suite to intercept and modify the file upload request.
- **Modification:** Change the filename to `hello.txt` and alter the file content to simple text "hello there," but keep the content-type as `image/png`.

### 3. Result of Modification
- **Outcome:** Despite the incorrect file type and content, the server accepts `hello.txt` as a valid upload, showing a message indicating successful upload.

### 4. Escalating the Attack
- **Further Modification:** Replace "hello there" with a PHP script `<?php system($_GET['cmd']); ?>` and change the filename to `cmd.php`.
- **Successful Upload:** The file is uploaded, and attempts to find the file's location using tools like `ffuf` to fuzz the directory structure of the server.

---

## 📖 Understanding the PHP Script and Responses

### PHP Script: 
- **What It Does:** This line of PHP code runs any command that you add to the web address (URL) after `cmd=`.
- **How It Works:**
  - **`system()`**: A PHP function that runs a command on the server.
  - **`$_GET['cmd']`**: Retrieves the command from the URL, such as `?cmd=whoami`.
  - **Example URL:** `http://localhost/labs/uploads/cmd.php?cmd=whoami` executes the `whoami` command.

### Error Message Explanation
- **Error Message:** "Warning: system(): Cannot execute a blank command in /var/www/html/labs/uploads/cmd.php on line 1"
- **Cause:** Occurs when the `cmd.php` script is accessed without a `cmd` parameter, leaving the `system()` function with nothing to execute.

---

## 🛡️ Query Parameters and Command Execution

### Adding `cmd=whoami`
- **Purpose:** `whoami` is a command-line utility that displays the username of the current user when executed.
- **URL with Parameter:** `http://localhost/labs/uploads/cmd.php?cmd=whoami`
- **Result:** Executes the `whoami` command on the server, returning `www-data` which is the username of the web server process.

---

## 🎯 Real-World Implications

- **Potential Risks:** Such vulnerabilities allow attackers to upload malicious files that can execute arbitrary commands, leading to unauthorized access or control over the server.
- **Prevention Strategies:** 
  - Ensure both client-side and server-side validations are in place.
  - Restrict executable file uploads.
  - Regularly scan uploaded files for malware.

---

## 🔧 Lab Notes

1. **Initial Upload Test:** Upload an image with `.png` extension and observe the file structure.
2. **Bypassing Client-Side Controls:**
   - Intercept the upload request using Burp Suite.
   - Replace the filename and magic bytes with `filename=logo.txt` and simple text content.
3. **Uploading Malicious File:**
   - Modify filename to `cmd.php` and replace file content with the PHP payload: `<?php system($_GET['cmd']); ?>`.
4. **Finding the Uploaded File:**
   - Use `ffuf` to fuzz for the file location:
     ```bash
     ffuf -u http://localhost/FUZZ -w /usr/share/wordlists/dirb/common.txt
     ```
   - Adjust the path as necessary, such as `http://localhost/labs/uploads/cmd.php`.
5. **Executing Commands:**
   - Use the parameter `?cmd=whoami` to execute commands and confirm successful exploitation.

---
