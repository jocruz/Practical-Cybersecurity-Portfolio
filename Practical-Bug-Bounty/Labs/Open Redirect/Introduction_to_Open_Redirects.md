
# 📝 **Introduction to Open Redirects**

### 🎯 **Objective:**

To understand what open redirects are, how they can be exploited to capture login credentials, and to see an example of open redirect vulnerability through a lab exercise.

### 🚀 **What is an Open Redirect?**

An open redirect is a security vulnerability in web applications. It occurs when a web application or server uses unvalidated or untrusted user input to construct a URL to which it then redirects the user. Attackers can exploit this vulnerability to redirect users to phishing or malware sites, or to perform other malicious activities.

### 🛠️ **Lab Setup:**

- **URL:** `http://localhost/labs/r0x01.php`
- **Functionality:** The page contains buttons that allow viewing different scripts with parameters including a return URL.

### 📋 **Procedure:**

1. **Access the Lab Environment:**
    - Navigate to `http://localhost/labs/r0x01.php` and observe the two buttons labeled "View Script".
2. **Interact with Redirect Feature:**
    - Click on "View Script: Script 1 / SQL injection payloads" which leads to:
    - `http://localhost/labs/r0x01_script.php?id=1&return_url=http://www.google.com`
    - This URL includes a parameter `return_url` that dictates where the user will be redirected after clicking "Return to List."

### 📊 **Understanding the Redirect:**

- **Why the Redirect Works:**
    - The application does not validate or sanitize the `return_url` parameter, allowing the user to be redirected to any URL specified in it.
    - When "Return to List" is clicked, the application simply follows the URL specified without checking its legitimacy or origin.

### 🌐 **Exploiting Open Redirects:**

- **Credential Capture:**
    - An attacker can modify the `return_url` to redirect users to a malicious site that mimics a legitimate login page (phishing site).
    - Unsuspecting users might enter their credentials into the phishing site, believing they are securely logging back into their accounts.

### 🛡️ **Mitigation Strategies:**

- **Validate URLs:** Ensure all redirect URLs are validated against a list of allowed URLs.
- **Use Internal Redirects:** If possible, convert potential external redirects to internal mapping values to avoid exposing raw URLs in parameters.

### 📖 **Useful Resources:**

- [**OWASP Guide on URL Redirection](https://owasp.org/www-community/attacks/URL_Redirection_to_Untrusted_Site_Phishing):** Details about URL redirection vulnerabilities and prevention techniques.
- [**Mitigating Open Redirects](https://securityblog.com/open-redirects/):** Practical advice and methods to secure web applications against open redirects.

### 🔍 **Key Definitions:**

- **Open Redirect:** A vulnerability due to improper validation of redirected URLs allowing attackers to divert users to untrusted sites.
- **Phishing:** A cyber-attack that uses disguised email as a weapon. The goal is to trick the email recipient into believing that the message is something they want or need and to click a link or download an attachment.
