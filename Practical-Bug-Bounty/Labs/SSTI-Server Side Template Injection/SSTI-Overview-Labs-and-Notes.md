
# 🌐 SSTI Overview: Labs and Notes

---

## 🧠 What is Server-Side Template Injection (SSTI)?

Server-Side Template Injection occurs when an attacker exploits vulnerabilities in web template engines, allowing malicious templates to execute arbitrary code on the server. This can lead to information disclosure, unauthorized access, or full server compromise.

---

## 🎭 Common Template Engines Vulnerable to SSTI

1. **Twig (PHP)**: Provides flexible rendering but can be misconfigured to allow malicious code execution.
2. **Jinja2 (Python)**: Commonly used but vulnerable if user inputs are directly rendered.
3. **Smarty (PHP)**: Executes PHP code if improperly configured.
4. **Freemarker (Java)**: Susceptible to code execution through unsafe data binding.

---

## 🔍 Lab 1: SSTI Exploration

**Objective**: Test a vulnerable message submission form for SSTI.

### 🛠 Steps Taken:

1. **Test for Cross-Site Scripting**:
    - Injected `<script>alert(1)</script>` to confirm XSS vulnerability.
2. **Identified Template Engine**:
    - Fuzzed using `{{7*7}}` and identified Twig template engine by observing outputs like `49`.
3. **Exploited SSTI**:
    - Payload: `{{['id',""]|sort('system')}}`.
    - Outcome: Executed `id` command, exposing user information (`uid=33(www-data) gid=33(www-data)`).
4. **Learnings**:
    - Use template-specific payloads for precise exploitation.
    - Input sanitization is critical to prevent SSTI.

---

## 🔍 Lab 2: Birthday Card SSTI Challenge

**Objective**: Identify SSTI in a birthday card generator.

### 🛠 Two Exploitation Techniques:

1. **Burp Suite Interception**:
    - Fuzzed `cardHtml` parameter using `template-engines-special-vars.txt`.
    - Successful Payload: `{{=42*42}}`.
2. **Direct HTML Manipulation**:
    - Modified editable HTML to inject `{{['id',""]|sort('system')}}`.
    - Outcome: Extracted user info (`uid=33(www-data)`), confirming SSTI.

### 🎯 Key Observations:

- Exploitation can occur via direct input manipulation or intercepted requests.
- Robust input validation is a necessity.

---

## 🔍 Lab 3: Advanced SSTI Exploitation

**Objective**: Combine SSTI and XSS techniques for multi-layered exploitation.

### 🛠 Highlights:

1. **Basic XSS Validation**:
    - Inserted `<script>alert(1)</script>` to confirm vulnerability.
2. **Identified Template Rendering**:
    - Injected `{{7*7}}` into editable fields and observed processed outputs.
3. **Payload Execution**:
    - Exploited system commands with `{{['id',""]|sort('system')}}`.
    - Output: System user details and file access through templates.

---

## 🎓 Key Takeaways from Labs

- **Critical Risks**:
    - SSTI allows attackers to execute arbitrary commands, exposing sensitive data and compromising systems.
- **Attack Vectors**:
    - Exploitable via user inputs in forms, editable fields, and unvalidated template variables.
- **Prevention Techniques**:
    - Strict input validation and escaping.
    - Use safe rendering modes in template engines.
    - Regular security audits and code reviews.

---

## 📚 Resources

- **HackTricks**: [SSTI Exploitation Guide](https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection)
- **SecLists**: [Template Engine Fuzzing Payloads](https://github.com/danielmiessler/SecLists)
- **Burp Suite**: Tool for intercepting and modifying HTTP requests.

---
