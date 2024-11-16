# 📝 Lab Notes: Insecure File Upload 0x02

## 🌐 HTTP Request Overview

When we upload a PNG file, this is the HTTP request generated:

POST /labs/f0x02.php HTTP/1.1 Host: localhost ... Content-Type: multipart/form-data; boundary=---------------------------42073767943101830995135858884 Content-Length: 100313 ... -----------------------------42073767943101830995135858884 Content-Disposition: form-data; name="uploaded_file"; filename="random_kali.png" Content-Type: image/png


### 🔍 Analysis:

- The request contains a boundary identifier used for separating parts of the form data.
- The file "random_kali.png" is attached in the body of the request.

---

## 🧙‍♂️ Attack Vector: Magic Bytes Manipulation

Magic bytes are unique sequences at the beginning of a file used to identify the file format. By examining the PNG magic bytes, we identify a potential point of attack:

### 1️⃣ File Upload Manipulation:
- **Original file**: `random_kali.png`
- **Target exploit file**: `cmd.php`

The server checks for the file extension and blocks non-`.jpg` or `.png` files.

### 2️⃣ Bypass Strategy:
- Embed PHP code within the PNG file's magic bytes.
- **PHP code used**: 
- Modify the filename to include a PHP extension while retaining the PNG magic bytes.

---

## 💡 Additional Techniques:

### **Alternative Extensions**
If `.php` is blocked, other extensions like `.php3`, `.php4`, `.phtml` can be used. This can circumvent restrictions that rely solely on file extensions.

### **Null Byte Attack**
Use of `logo3.php%00.png`. This involves appending a null byte (`%00`) followed by `.png` to trick the server into processing the file as a PNG while actually executing the embedded PHP code.

---

## ❓ What are Null Byte Attacks?

Null byte attacks involve the insertion of a null character (`\0`) to mislead the system about the filename's end. This can allow an attacker to append executable code in a seemingly harmless file (like an image), which the server processes incorrectly due to the null byte.

---