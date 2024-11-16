
# 📝 Insecure File Upload Overview

## ❓ What is Insecure File Upload?

Insecure File Upload vulnerabilities occur when an application allows attackers to upload files without proper validation. These vulnerabilities can lead to a variety of attacks, such as remote code execution, malware distribution, or data breaches.

---

## 🌐 Types of Insecure File Upload Vulnerabilities

### 1️⃣ **Client-Side Validation Bypass**
- **Issue:** Validation is only enforced on the client-side, such as through JavaScript or file input restrictions.
- **Exploitation:** Attackers can bypass these controls by intercepting the upload request (e.g., using Burp Suite) and modifying the file type or content.

### 2️⃣ **Server-Side Validation Issues**
- **Issue:** The server improperly validates uploaded files, relying only on file extensions or MIME types.
- **Exploitation:** Uploading files with alternate extensions or modifying headers to match acceptable formats.

### 3️⃣ **Magic Bytes Misuse**
- **Issue:** Applications fail to properly verify the file content (magic bytes), relying solely on extensions or MIME types.
- **Exploitation:** Embedding malicious payloads within files while keeping valid magic bytes to bypass filters.

---

## 🎯 Common Attack Techniques

### 🧪 **Technique 1: File Name Manipulation**
- Modify the file name to include an executable extension (e.g., `.php`, `.php3`, `.phtml`).
- Use alternate extensions like `.png.php` or `.php%00.png` to trick server-side validation.

### 🧪 **Technique 2: Header Tampering**
- Alter the `Content-Type` header to an acceptable format (e.g., `image/png`) while uploading a malicious file.

### 🧪 **Technique 3: Magic Bytes Manipulation**
- Insert valid magic bytes for the expected file type (e.g., PNG) while embedding malicious content.

---

## 🛡️ Prevention Strategies

### ✅ **Implement Proper Server-Side Validation**
- Verify both file name extensions and content types.
- Use robust libraries to validate file contents based on actual file type (e.g., libmagic).

### ✅ **Limit Allowed File Types**
- Only accept specific file types and validate them thoroughly.
- Reject executable files and ensure no script execution in upload directories.

### ✅ **Rename Uploaded Files**
- Rename uploaded files to prevent execution, such as hashing file names or changing extensions to `.txt`.

### ✅ **Use Secure Upload Directories**
- Store uploads in directories without execute permissions.
- Separate upload directories from the main application directory.

---

## 🧐 Key Takeaways
1. **Client-side validation is not enough:** Always enforce validation on the server-side.
2. **Do not trust file extensions:** Use file content inspection to validate uploaded files.
3. **Implement strict controls:** Restrict executable files and use safe upload directories.

---

## 🎯 Real-World Implications
- **Potential Risks:** Exploited insecure file uploads can lead to remote code execution, defacement, or data breaches.
- **Importance of Security Controls:** Properly securing file upload mechanisms is critical for web application security.

