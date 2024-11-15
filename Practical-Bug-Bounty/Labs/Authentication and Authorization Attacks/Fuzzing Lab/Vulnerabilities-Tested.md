# Vulnerabilities Explored 📋

## Authentication Vulnerabilities
1. **Weak Passwords:**
   - Tested for common weak passwords like `letmein` using a custom wordlist.
2. **Account Lockout Mechanism:**
   - Explored the lockout mechanism after multiple failed login attempts.
3. **Rate Limiting:**
   - Identified the absence of effective rate limiting, enabling brute-force fuzzing.

---

## Why It Matters 🛡️
Weaknesses in authentication systems can lead to:
- Unauthorized access through predictable credentials.
- Overcoming account lockout mechanisms by resetting databases.

---
