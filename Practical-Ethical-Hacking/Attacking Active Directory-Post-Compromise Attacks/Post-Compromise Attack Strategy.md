---

## 🕵️‍♂️ Post-Compromise Attack Strategy

### 📝 Summary

Once you have gained access to an account, the focus shifts to exploring potential pathways to escalate privileges (vertical movement) or broaden access within the network (lateral movement). This strategy involves identifying **quick wins** for exploitation and, if none are found, performing a deeper enumeration to uncover overlooked vulnerabilities. The goal is to continuously assess how to exploit the current access for maximum impact.

### 📋 Detailed Notes

1. **You Have an Account, Now What?**
    - **Start with Quick Wins:**
        1. **Kerberoasting:** Look for service accounts with a Service Principal Name (SPN) in Active Directory. Use tools like `Rubeus` to request and crack their Kerberos ticket-granting service (TGS) tickets offline.
        2. **Secretsdump:** Utilize this tool (from the Impacket suite) to extract **NTLM password hashes**, Kerberos tickets, and plaintext credentials from the compromised system. It can provide immediate access to other systems.
        3. **Pass the Hash / Pass the Password:** Use the obtained **hash** or **plaintext password** to authenticate against other network services, circumventing the need for a user’s actual password.
    - **🔄 Repeat the Process:** Every time you successfully extract credentials or move to a new system, repeat the process of searching for new opportunities to **move vertically** (privilege escalation) or **laterally** (accessing other network systems).
2. **No Quick Wins? Dig Deeper!**
    - **🕵️ Enumerate the Environment:** If quick wins don’t yield results:
        1. Use **BloodHound** to map out the Active Directory environment. Identify relationships, user privileges, and potential paths for escalation.
        2. Look for accessible network shares, group memberships, service accounts, and other configurations that might give clues for lateral movement.
    - **🗒️ Track Your Access:** Document every resource your compromised account can access. This tracking is crucial to identify potential attack vectors and plan your next moves effectively.
    - **Old Vulnerabilities:** Investigate if the target systems have **unpatched vulnerabilities** (e.g., EternalBlue, PrintNightmare) or **misconfigurations** that can still be exploited for further access.
3. **Strategic Thinking:**
    - **💡 Always Ask:** "How can I **move laterally** until I can **move vertically**?" Your goal is to leverage every new access point to uncover higher-privilege accounts or more sensitive data.
    - **Think Outside the Box:** Don’t limit yourself to conventional methods. Look for creative solutions or seemingly minor misconfigurations that might provide new exploitation opportunities.

### 📖 Abbreviations & Definitions

- **Kerberoasting:** A technique targeting service accounts with SPNs in Active Directory to obtain encrypted tickets that can be cracked offline, revealing plaintext passwords.
- **Secretsdump:** A tool in the Impacket suite used to extract password hashes, Kerberos tickets, and plaintext credentials from Windows systems. It can perform this remotely if valid credentials are available.
- **Pass the Hash (PTH):** An attack technique where attackers use a captured NTLM hash to authenticate to other network systems without needing the plaintext password.
- **Lateral Movement:** The process of navigating through a network using the compromised account's privileges to access other systems and resources.
- **Vertical Movement (Privilege Escalation):** Gaining higher privileges on a system (e.g., from a standard user to an administrator).

### 🚨 Critical Mentions & Exam Traps

- **🚨 Always Track Access:** Document every system and share your compromised account can access. Overlooking this can lead to missed exploitation paths.
- **💡 Old Vulnerabilities Are Often Overlooked:** Never ignore unpatched software or old vulnerabilities; they can be crucial for achieving vertical or lateral movement.
- **🔄 Iterative Process:** Revisit each step after every new access or successful attack. **Constant iteration** is key to uncovering additional weaknesses.
- **⚠️ Exam Trap:** Over-focusing on one type of attack can lead to missing other critical vectors. Be versatile and explore multiple paths for exploitation, especially when initial attempts do not yield results.
- **🔑 Detailed Enumeration:** Proper enumeration using tools like **BloodHound** can reveal hidden relationships and vulnerabilities that might not be immediately obvious.

---