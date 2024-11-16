
# 📘 Understanding CVSS: Part 2

---

## 📘 **CVSS Overview and Tools**

### 📊 **CVSS Calculators and Vector Strings**

- **Calculators:** There's no need to manually calculate CVSS scores as various online calculators are available to automate this task.
- **Vector Strings:** These provide a textual representation of the components that make up a CVSS score, making it easy to share and understand the specifics of a vulnerability assessment.
    - **Example String for CVSS v3.1:** `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:L/E:H/RL:O/RC:U/CR:H/MAC:H`

### 🌐 **Where to Calculate:**

- [**First.org](http://first.org/) Calculator:** [firstorg/cvss/calculator](https://www.first.org/cvss/calculator)
- **Other Resources:** Available at sites like [cvss.ramhacks.org](http://cvss.ramhacks.org/), [gitlab-com.gitlab.io/gl-security/appsec/cvss-calculator](http://gitlab-com.gitlab.io/gl-security/appsec/cvss-calculator), and [cvssadvisor.com](http://cvssadvisor.com/).

---

## 🆚 **CVSS v3.1 vs. CVSS v4.0**

### 📝 **Challenges with CVSS v3.1:**

- **Primary Input:** Base Score is heavily relied upon for risk analysis.
- **Granularity Issues:** Offers less granularity with fewer than 99 discrete scores.
- **Temporal Metrics:** These do not significantly impact the final score.
- **Complexity:** The mathematical model is considered overly complicated and sometimes counterintuitive.
- **Real-Time Data:** Lacks integration of real-time threat or supplemental impact details.

### 🌟 **New in CVSS v4.0:**

- **Increased Granularity:** More detailed in base metrics for finer granularity.
- **Simplified Metrics:** Threat metrics and their impact on scoring are simplified.
- **Removal of Ambiguities:** Specifically in how downstream impacts (scope) are scored.
- **Broader Applicability:** More suitable for OT (Operational Technology), ICS (Industrial Control Systems), and IoT (Internet of Things).
- **Enhanced Response Attributes:** Introduces supplemental attributes to aid in vulnerability response.

### 🏷️ **CVSS v4.0 Nomenclature:**

- **CVSS-B:** Base Score alone.
- **CVSS-BT:** Base Score plus Threat Score.
- **CVSS-BE:** Base Score plus Environmental Score.
- **CVSS-BTE:** Base Score plus Threat and Environmental Scores.

---

## 📜 **Conclusion: Summary of Key Points**

- **Vector Strings:** Simplify the sharing and understanding of CVSS metrics.
- **Multiple Calculators:** A variety of tools are available to compute CVSS scores, catering to different user preferences and needs.
- **CVSS v4.0 Updates:** Be prepared for the new version, which offers improvements in granularity, scoring simplicity, and applicability to a broader range of technologies.

---
