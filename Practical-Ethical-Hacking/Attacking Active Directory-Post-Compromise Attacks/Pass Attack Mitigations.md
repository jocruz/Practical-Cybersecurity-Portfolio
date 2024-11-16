### 🔐 **Pass Attack Mitigations**

---

## 📝 **Summary**

Pass attacks, such as **Pass-the-Hash** or **Pass-the-Password**, are difficult to completely prevent, but there are several strategies to **mitigate** them. These involve **limiting account reuse**, implementing **strong passwords**, and using **Privilege Access Management (PAM)** to rotate sensitive credentials.

---

## 📚 **Detailed Notes**

### 1. **Limit Account Re-Use**

- **Avoid re-using local admin passwords**: Don’t use the same password for local admin accounts across different machines.
- **Disable Guest and Administrator accounts**: These default accounts are often targeted in attacks.
- **Limit local administrator privileges**: Grant admin rights only to users who absolutely need them (least privilege principle).

### 🚨 **Critical Tip**:

Avoid password reuse across machines—this makes lateral movement harder for attackers.

---

### 2. **Utilize Strong Passwords**

- **Length**: Use passwords longer than **14 characters**.
- **Avoid common words**: Don’t use simple, guessable words.
- **Passphrase suggestion**: Use long sentences as passwords to increase strength.

### 🚨 **Critical Tip**:

Longer passwords (>14 characters) are exponentially harder to crack, making **Pass-the-Password** attacks more difficult.

---

### 3. **Privilege Access Management (PAM)**

- **Check out/check in** sensitive accounts: Access to sensitive accounts should be managed, and passwords should only be used when necessary.
- **Automatically rotate passwords**: Passwords should be automatically changed upon check-in to reduce the chances of reusing compromised credentials.
- **Limits pass attacks**: By frequently rotating strong passwords, you reduce the window in which an attacker can reuse the password or hash.

### 💡 **Key Tip**:

Rotating strong passwords automatically with PAM makes it harder for attackers to use stolen credentials for long periods.

---

## 🚨 **Critical Mentions & Exam Traps**

- **📝 Never reuse passwords across machines**: This is one of the most effective ways to slow down an attacker's lateral movement.
- **🚨 Strong passwords**: Ensure passwords are long and complex; avoid using dictionary words.
- **📝 Utilize PAM tools**: These tools ensure that passwords are rotated, checked out only when needed, and checked back in after use, limiting the attacker's window of opportunity.

---

This cheat sheet covers **key mitigations** that reduce the likelihood of successful **pass attacks** by emphasizing strong passwords, account management, and rotating sensitive credentials.