
# 🌐 XXE Overview and Lab Insights

---

## ❓ What is XXE Injection?

XML External Entity (XXE) injection is a security vulnerability that exploits how XML parsers process external entities. If the parser is not securely configured, attackers can manipulate XML input to retrieve sensitive data, cause denial of service (DoS), or initiate server-side request forgery (SSRF).

---

## 🎯 Key XXE Attack Scenarios

1. **File Disclosure:**
   - Exploiting external entity definitions to access local system files or remote resources.
   - Example: Retrieving `/etc/passwd` on a Linux system.

2. **Denial of Service (DoS):**
   - Using recursive entity definitions to exhaust system resources.

3. **Server-Side Request Forgery (SSRF):**
   - Forcing the server to make unauthorized requests to internal or external systems.

---

## 🛠️ Lab: XXE Injection 0x01

### 📝 Safe vs. Exploit XML

#### **Safe XML Example**
- **Filename:** `xxe-safe.xml`
- **Content:**
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <creds>
      <user>testuser</user>
      <password>testpass</password>
  </creds>
  ```
- **Description:** Contains no references to external entities, ensuring secure processing.

#### **Exploit XML Example**
- **Filename:** `xxe-exploit.xml`
- **Content:**
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE creds [
  <!ELEMENT creds ANY>
  <!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
  <creds><user>&xxe;</user><password>pass</password></creds>
  ```
- **Description:** Introduces an external entity (`xxe`) to load content from `/etc/passwd`.

---

## 📖 Explanation of Lab Examples

### **Safe XML**
- The XML file does not reference external entities, ensuring it processes user data securely.

### **Exploit XML**
- The DOCTYPE declaration introduces an entity that retrieves sensitive information from the server's file system.

---

## 🎯 Real-World Implications

1. **Risks:**
   - Unauthorized file access.
   - Internal system reconnaissance.
   - Potential inter-system exploits.

2. **Prevention Strategies:**
   - Disable external entities in XML parsers.
   - Use safer data formats like JSON when possible.
   - Validate and sanitize all XML inputs.

---

### 🔗 References:
- [Payloads All The Things: XXE Injection](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XXE%20Injection)

---

