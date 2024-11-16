
# 📘 **Introduction to CVSS: Part 1**

### 🎯 **Objective:**

To gain a foundational understanding of the Common Vulnerability Scoring System (CVSS), its purpose, the different types of metrics it uses, and how these metrics are applied in vulnerability assessment.

### 🚀 **Overview of CVSS**

The Common Vulnerability Scoring System (CVSS) provides a way to capture the principal characteristics of a vulnerability and produce a numerical score reflecting its severity. The score can then be translated into a qualitative representation (such as low, medium, high, and critical) to help assess and prioritize vulnerability management efforts.

### 🔢 **CVSS Score Scale:**

- **0:** No vulnerability.
- **0.1 - 3.9:** Low severity.
- **4.0 - 6.9:** Medium severity.
- **7.0 - 8.9:** High severity.
- **9.0 - 10.0:** Critical severity.

### 📚 **Components of CVSS:**

1. **Base Metrics:** The intrinsic qualities of a vulnerability that are constant over time and across user environments.
2. **Temporal Metrics:** The characteristics of a vulnerability that change over time but not across user environments.
3. **Environmental Metrics:** The characteristics of a vulnerability that are relevant and specific to a particular user's environment.

### 🛠️ **Detailed Metrics Explanation:**

### **Base Metrics:**

- **Exploitability Metrics:**
    - **Attack Vector (AV):** This metric reflects how the vulnerability can be exploited. The values are:
        - **Network (N):** The vulnerability can be exploited remotely through the network.
        - **Adjacent (A):** The exploit must be launched from the same local network.
        - **Local (L):** The exploit must be launched locally (physical access or authenticated session).
        - **Physical (P):** The exploit requires physical access to the device.
    - **Attack Complexity (AC):** This metric describes the conditions beyond the attacker’s control that must exist to exploit the vulnerability. It is scored as Low (L) or High (H).
    - **Privileges Required (PR):** This measures the level of privileges an attacker must possess for successful exploitation, categorized into None (N), Low (L), or High (H).
    - **User Interaction (UI):** This metric captures whether the vulnerability can be exploited solely at the discretion of the user who must perform an action before the vulnerability can be exploited. It is a binary measure: None (N) or Required (R).
- **Impact Metrics:**
    - **Confidentiality (C), Integrity (I), Availability (A):** Each is rated as None (N), Low (L), or High (H), indicating the impact on these security properties if the vulnerability is successfully exploited.

### **Temporal Metrics:**

- **Exploit Code Maturity (E):** Indicates the level of maturity of the exploit aimed at this vulnerability.
- **Remediation Level (RL):** Reflects the availability and maturity of patches and workarounds.
- **Report Confidence (RC):** Represents the degree of confidence in the truth of the reported vulnerability.

### **Environmental Metrics: Modified Base Metrics:**

These metrics allow adjustment of the base scores based on the importance of the affected IT asset to a user’s organization and the effectiveness of mitigations.

- **Modified Attack Vector (MAV)**
- **Modified Attack Complexity (MAC)**
- **Modified Privileges Required (MPR)**
- **Modified User Interaction (MUI)**
- **Modified Scope (MS)**
- **Modified Confidentiality (MC)**
- **Modified Integrity (MI)**
- **Modified Availability (MA)**

### **Environmental Metrics: Requirements:**

- **Confidentiality Requirement (CR), Integrity Requirement (IR), Availability Requirement (AR):** Reflects how critical it is to protect the CIA aspects of the information resources affected by the vulnerability.

### 🛡️ **CVSS in Practice:**

- **CVE vs CVSS:** CVE identifiers describe individual vulnerabilities. CVSS scores assess their severity.
- **CVSS Versions:** There are three versions of CVSS currently in use—v1, v2, and v3—with v3 being the most current and comprehensive.

### 🏆 **CVSS and Bug Bounties:**

Bug bounties evaluate submissions based on the CVSS score to prioritize and reward findings appropriately. Researchers may self-calculate CVSS scores, which can be adjusted by the triaging team or the affected organization.

### ⚠️ **Limitations of CVSS:**

- CVSS scores can be subjective and may not perfectly reflect the practical impact of a vulnerability in different environments. They are also static and do not adapt to changing threat landscapes.

### 📖 **Further Reading and Tools:**

- [**OWASP CVSS Calculator](https://owasp.org/www-community/attacks/):** An online tool to calculate CVSS scores.
- [**NIST National Vulnerability Database](https://nvd.nist.gov/vuln-metrics/cvss):** Offers CVSS scores for known vulnerabilities.
