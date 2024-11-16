
# 🌐 Cross-Site Request Forgery (CSRF): Overview and Labs

## 🛡️ **What is CSRF?**

Cross-Site Request Forgery (CSRF) is a web security vulnerability that tricks a logged-in user into unknowingly executing unwanted actions on a web application where they are authenticated. By exploiting the trust a web application has in a user's browser, an attacker can manipulate the victim to perform actions such as:

- Changing account settings.
- Transferring funds.
- Performing administrative actions.

---

## 🎯 **How Does CSRF Work?**

1. **User Authentication**: The victim is logged into a web application.
2. **Malicious Request**: The attacker tricks the victim into performing an action (e.g., clicking a malicious link, visiting a website).
3. **Execution**: The request is sent with the victim’s cookies or authentication tokens, making it appear legitimate to the server.

---

## 🛠️ **Key Components of a CSRF Attack**

1. **Vulnerable Target**: A web application that relies on cookies or other session identifiers for authentication.
2. **User Interaction**: A user must be logged into the application during the attack.
3. **Malicious Code**: Typically, a crafted HTML form or JavaScript code designed to exploit the vulnerability.

---

## 🛡️ **How to Prevent CSRF?**

1. **Anti-CSRF Tokens**:
   - Add unique, unpredictable tokens to every sensitive form.
   - Validate the token on the server to confirm the request's legitimacy.
   
2. **SameSite Cookies**:
   - Set cookies to `SameSite` to restrict their use in cross-origin requests.
   
3. **Custom Headers**:
   - Require requests to include custom headers (e.g., `X-CSRF-Token`), which browsers cannot send in cross-site requests.
   
4. **Verify Referer Headers**:
   - Check the `Referer` header to ensure requests originate from trusted sources.

---

## 📝 **CSRF Labs Summary**

### **Lab 0x01: Basic CSRF Attack**

**Scenario**:
- A form allows the user to submit their email address.
- No CSRF protection is implemented.

**Attack**:
- Create a malicious HTML form that auto-submits to the vulnerable application.

**Key Takeaways**:
- Demonstrates the simplicity of CSRF when no protection mechanisms are in place.

---

### **Lab 0x02: CSRF Token Bypass**

**Scenario**:
- A form includes a hidden CSRF token for protection.
- The server does not validate the token correctly.

**Attack**:
- Craft a malicious form that includes a forged token value.
- Bypass the token validation and execute the CSRF attack.

**Key Takeaways**:
- Highlights how improperly implemented tokens can be bypassed.

---

## 📚 **Interview Study Tips**

1. **Understand Core Concepts**:
   - Explain the difference between CSRF and XSS (Cross-Site Scripting).
   - Emphasize that CSRF exploits user trust in a web application, while XSS exploits user trust in a website.

2. **Explain Prevention Techniques**:
   - Be prepared to discuss anti-CSRF tokens and the use of `SameSite` cookies.

3. **Describe Real-World Examples**:
   - Reference scenarios such as modifying account settings or transferring funds without user consent.

4. **Highlight Lab Insights**:
   - Mention how you identified and exploited vulnerabilities in the labs.
   - Focus on the practical application of tools like Burp Suite for intercepting and modifying requests.

---

## 🧠 **Key Takeaways**

- CSRF attacks rely on exploiting the user's authenticated session.
- Prevention mechanisms like anti-CSRF tokens and secure cookies are essential.
- Real-world scenarios demonstrate the critical need for proper implementation and validation.

---

