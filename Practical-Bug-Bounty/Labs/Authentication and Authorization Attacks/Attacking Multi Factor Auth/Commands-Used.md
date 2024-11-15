# Commands and Tools Used in Lab 2 🛠️

## Using Burp Suite for MFA Manipulation
1. **Initial Login:**
   - Log in as Jessamy with the credentials:
     - **Username:** Jessamy  
     - **Password:** Pasta  

2. **Intercepting Traffic:**
   - Enable Burp Suite intercept after submitting the MFA code.

3. **Manipulating the Request:**
   - Modify the username in the intercepted traffic:
     - Change `username=Jessamy` to `username=Jeremy`.

4. **Forwarding the Request:**
   - Disable intercept and allow the manipulated traffic to proceed.

---
