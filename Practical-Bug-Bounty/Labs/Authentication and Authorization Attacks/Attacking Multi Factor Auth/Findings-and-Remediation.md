# Findings and Remediation 🧐🛠️

## Findings
- **Identified Vulnerability:** MFA tokens were not tied to specific user sessions.  
- **Exploit:** An attacker could reuse Jessamy's MFA code to log into Jeremy's account by modifying the intercepted request.  

---

## Remediation
1. **Bind Tokens to Sessions:**
   - Ensure MFA tokens are associated with specific user sessions and accounts.
2. **Validate Tokens at the Backend:**
   - Tokens should be verified for correct pairing with the intended username.
3. **Implement Token Expiry:**
   - Tokens must have a short lifespan to prevent reuse in other contexts.
4. **Monitor for Unusual Activity:**
   - Log and review mismatches in MFA token usage across accounts.

---
