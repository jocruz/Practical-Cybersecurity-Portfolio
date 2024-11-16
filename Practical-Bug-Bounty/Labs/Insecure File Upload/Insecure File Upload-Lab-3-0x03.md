---

### 📝 Lab Notes: Insecure File Upload 0x03

### 🌐 HTTP Request Overview

During this lab, the process begins with uploading a .PNG file, then observing the POST request using Burp Proxy:

```
POST /labs/f0x03.php HTTP/1.1
Host: localhost
...
Content-Type: multipart/form-data; boundary=---------------------------301288109727861736292505919259
Content-Length: 246
...
-----------------------------301288109727861736292505919259
Content-Disposition: form-data; name="uploaded_file"; filename="random_kali.txt"
Content-Type: image/png

hello there
-----------------------------301288109727861736292505919259--

```

🔍 **Analysis**:

- This request is captured and modified in the repeater tool, initially attempting to change only the file name which leads to a server-side validation error preventing non-.jpg or .png file uploads.

### 💻 Attack Strategy: Bypassing File Type Validation

1. **Initial Strategy**:
    - Modify the file extension in the HTTP request to attempt a PHP file upload.
    - Server response: Only '.jpg' and '.png' files are allowed.
2. **Enhanced Bypass Approach**:
    - Remove some of the PNG magic bytes but ensure the PHP script is embedded within the remaining structure.
    - Inject PHP code: ``

### 🚀 Successful Upload and Execution:

- **Extensions Tested**:
    - `.php` initially blocked.
    - Successful with `.php5` and `.phtml` extensions.
- **Final URL to Trigger Code Execution**:
    
    ```
    <http://localhost/labs/uploads/yes.phtml?cmd=whoami>
    
    ```
    
    - This results in the execution of the command `whoami`, which outputs `www-data`, indicating the server's response under the user context running the web server, demonstrating a successful attack.

### 🎯 Summary and Learnings:

- **Key Points**:
    - Even when common PHP extensions are blocked, alternative extensions like `.php5` and `.phtml` can be leveraged for successful attacks.
    - Ensuring PHP code is correctly sandwiched within file content that appears valid can help bypass simple file type checks.
- **Understanding Output**:
    - The output from the executed command within the injected PHP script shows `www-data`, confirming the server-side script execution in the context of the server's user.

---