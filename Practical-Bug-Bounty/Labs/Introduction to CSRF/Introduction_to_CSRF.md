
# 🌐 Introduction to Cross-Site Request Forgery (CSRF)

## 🛡️ What is CSRF?

**Cross-Site Request Forgery (CSRF)** is a critical web security vulnerability where an attacker tricks a user into performing unwanted actions on a web application where they are authenticated. It exploits the trust a website has in the user's browser, leveraging the automatic inclusion of credentials (e.g., cookies or session tokens).

---

## 🎯 How Does CSRF Work?

1. **User is Authenticated**:
   - The user logs into a trusted web application (e.g., a banking website) and has a valid session.
   
2. **Crafting a Malicious Request**:
   - The attacker crafts a malicious request designed to perform an action on behalf of the user (e.g., transferring money to the attacker’s account).
   
3. **Exploiting User Action**:
   - The attacker tricks the user into executing the malicious request by embedding it in a link or form on a third-party site.
   
4. **Executing the Action**:
   - When the user unknowingly triggers the request, the web application processes it as if it originated from the user.

---

## 🖼️ Example Attack Scenario

1. **Setup**:
   - The user logs into their banking website and stays authenticated.
   
2. **Attack**:
   - The attacker sends an email with a malicious link:
     ```
     <a href="http://bank.com/transfer?amount=1000&to=attacker">Click Here for Free Money!</a>
     ```
   - The user clicks the link, unaware of its intent.

3. **Outcome**:
   - The bank processes the request using the user's session, transferring money to the attacker.

---

## 🛡️ Defending Against CSRF

1. **Anti-CSRF Tokens**:
   - Add unique, unpredictable tokens to every form or request, validated by the server.

2. **SameSite Cookies**:
   - Use the `SameSite` cookie attribute to restrict cookies from being sent in cross-site requests.

3. **Custom Request Headers**:
   - Require requests to include custom headers that cannot be added cross-site (e.g., `X-CSRF-Token`).

4. **Referer Validation**:
   - Verify the `Referer` or `Origin` header to ensure requests originate from trusted sources.

---

## 🧠 Key Takeaways

- **CSRF exploits trust**: The vulnerability targets the trust a web application places in the user's browser.
- **User interaction is key**: Attacks often require user actions like clicking a link or submitting a form.
- **Mitigation techniques**:
  - Implement anti-CSRF tokens.
  - Enforce strict cookie policies.
  - Validate request origins.

---

## 🌟 Why This Matters

Understanding CSRF vulnerabilities is crucial for web security. By mastering these concepts and mitigation strategies, you demonstrate your capability to assess, identify, and remediate critical web application flaws effectively.
