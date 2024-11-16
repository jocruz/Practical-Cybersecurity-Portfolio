
# 🕸 Cross-site Scripting (XSS) Overview

---

## 🤔 What is Cross-site Scripting?

Cross-site Scripting (XSS) is a type of security vulnerability typically found in web applications.  
XSS allows attackers to inject client-side scripts into web pages viewed by other users.  

### 🛠 How Does XSS Work?

XSS attacks occur when an application includes untrusted data (often from user input) in a web page without proper validation or escaping.  
This enables attackers to execute scripts in the victim's browser, potentially leading to:
- Hijacking user sessions.
- Manipulating web content.
- Redirecting users to malicious websites.

---

## 🎭 Types of XSS Attacks

### 1️⃣ Reflected XSS
- **Definition:**  
  The malicious script comes from the current HTTP request and is reflected back in the server's response.
- **Example:**  
  An attacker sends a URL with a script embedded. When the victim clicks the link, the script is executed in their browser.

---

### 2️⃣ Stored XSS
- **Definition:**  
  The malicious script is stored on the server (e.g., in a database) and served to users.
- **Example:**  
  An attacker posts a malicious script in a comment section. Every user viewing the comment executes the script.

---

### 3️⃣ DOM-Based XSS
- **Definition:**  
  The vulnerability exists in client-side code, where the browser's DOM is manipulated without proper validation.
- **Example:**  
  JavaScript dynamically includes untrusted data into the DOM, enabling script execution.

---

## 🔒 How to Prevent XSS Attacks

1. **Validate Input:**  
   Validate all user inputs on the server side.
2. **Escape Output:**  
   Escape data before inserting it into HTML.
3. **Use Secure Frameworks:**  
   Leverage frameworks that automatically escape XSS by design.
4. **Content Security Policy (CSP):**  
   Implement CSP to mitigate XSS risks by restricting sources of script execution.

---

## 🧰 Tools for Testing XSS Vulnerabilities

1. **Browser Developer Tools:**  
   Test how applications handle script injections.
2. **Automated Scanners:**  
   Use tools like OWASP ZAP, Burp Suite, or sqlmap to identify vulnerabilities.
3. **Manual Testing:**  
   Combine automated tools with manual testing for comprehensive coverage.

---

## 📖 Summary of XSS Types

### Reflected XSS
- **Easy Summary:**  
  An attack where the malicious script is part of the user's request and reflected back in the server's response.
- **Delivery Mechanisms:**  
  - Email links.
  - Malicious websites.
- **Impact:**  
  Affects individual users who click the link or submit malicious inputs.

---

### Stored XSS
- **Easy Summary:**  
  The malicious script is stored on the server and executed whenever users access the stored content.
- **Delivery Mechanisms:**  
  - Comments.
  - User profiles.
- **Impact:**  
  Affects all users who view the stored data.

---

### DOM-Based XSS
- **Easy Summary:**  
  The attack manipulates the DOM in the browser without relying on server-side vulnerabilities.
- **Delivery Mechanisms:**  
  - URL parameters influencing the DOM.
  - Unsafe JavaScript operations.
- **Impact:**  
  Exploits vulnerabilities in client-side code.

---

## 📝 Key Takeaways
1. XSS exploits untrusted data to execute scripts in user browsers.
2. Reflected and Stored XSS rely on server-side vulnerabilities, while DOM-Based XSS is client-side.
3. Prevention techniques include input validation, output escaping, and CSP.

---
