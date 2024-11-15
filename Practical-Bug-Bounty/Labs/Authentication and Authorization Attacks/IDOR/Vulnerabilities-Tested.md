# Vulnerabilities Explored 📋

## Insecure Direct Object Reference (IDOR)
1. **Parameter Manipulation:**
   - Exploited modifiable `account` parameter to access unauthorized data.
2. **Lack of Access Controls:**
   - Application failed to verify user authorization for specific account numbers.

---

## Why It Matters 🛡️
Exploiting IDOR vulnerabilities can:
- Expose sensitive user data.
- Lead to account takeovers or privilege escalation.
- Compromise the integrity of an application.

---
