
# 🌐 Template Injection Overview

---

## ❓ What is Template Injection?

Template Injection is a critical vulnerability that occurs when an application processes user input within templates without proper sanitization. This can lead to the execution of arbitrary code or commands, compromising server or client security.

---

## 🛠️ Types of Template Injection

### **1️⃣ Server-Side Template Injection (SSTI)**

- **Definition:** Occurs when a template engine processes untrusted user input, allowing attackers to execute server-side code.
- **Common Template Engines Prone to SSTI:**
  - **Jinja2 / Twig (Python/PHP):** Flexible but often misconfigured.
  - **Smarty (PHP):** Can execute PHP code when improperly secured.
  - **Freemarker (Java):** Allows dynamic execution features.
  - **ERB (Ruby):** Executes Ruby code if templates are insecure.

#### Exploitation Example:
- **Payload:** `{{4*4}}` in an input field returning `16` confirms vulnerability.
- **Escalation:** Injecting payloads to execute system commands or access sensitive files.

#### Real-World Implications:
- **Impact:** SSTI can result in full server takeover, data theft, or arbitrary command execution.

---

### **2️⃣ Client-Side Template Injection**

- **Definition:** Vulnerability arises when client-side template engines like AngularJS or React process user input insecurely.
- **Common Frameworks Affected:**
  - **AngularJS:** Exploitable via template features, particularly in older versions.
  - **React:** Vulnerable through `dangerouslySetInnerHTML`.

#### Exploitation Example:
- **Unsafe Input Rendering:** Injecting a `<script>` tag or JavaScript code that the template engine executes.

#### Real-World Implications:
- **Impact:** Enables Cross-Site Scripting (XSS) or DOM manipulation, potentially exposing sensitive user data.

---

## 🚀 How to Identify and Exploit Template Injection

1. **Identify the Template Engine:**
   - Look for error messages or syntax clues in the application.
2. **Inject Test Payloads:**
   - Example for SSTI: `{{7*7}}` or `${{7*7}}`.
   - Example for Client-Side: `{{alert('XSS')}}` in AngularJS.
3. **Escalate the Payload:**
   - Move from harmless arithmetic to malicious commands or sensitive data extraction.

---

## 🛡️ Mitigation Strategies

1. **Input Validation:**
   - Restrict and validate user input at all entry points.
2. **Sanitize Outputs:**
   - Escape all template outputs to avoid executing injected content.
3. **Use Secure Template Engines:**
   - Opt for engines that do not support code execution or restrict dynamic evaluation features.
4. **Error Handling:**
   - Suppress detailed error messages that could expose template engine details.

---

## 🎉 Fun Facts and Debugging Tips

- **Debugging Tip:** Misconfigured error messages can reveal the type of template engine used and potential injection points.
- **Historical Note:** Early web attacks in the 1990s leveraged similar techniques, targeting CGI scripts and dynamic web pages.

---

By understanding the mechanics of SSTI and client-side template injection, developers and security professionals can identify, exploit, and ultimately mitigate these vulnerabilities to secure modern web applications.

---
