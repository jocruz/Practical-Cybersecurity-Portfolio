
# 🌐 Server-Side Request Forgery (SSRF) Overview

## ❓ What is SSRF?

Server-Side Request Forgery (SSRF) is a web security vulnerability where an attacker tricks a server into making unauthorized HTTP requests to internal or external resources. This can allow attackers to:

- Access sensitive internal resources.
- Exfiltrate data.
- Perform denial-of-service (DoS) attacks.
- Interact with external systems maliciously.

---

## 🎯 How SSRF Works

### Basic Concept

- **Definition**: SSRF occurs when a web application fetches a remote resource without validating the user-supplied URL, thereby allowing an attacker to manipulate the requests made by the server.
- **Impact**: This can lead to information disclosure, interaction with internal services, or actions taken on behalf of the server that hosts the web application.

### 🖼️ Example Scenario

- **Normal Use**: A user submits `http://example.com`, and the server fetches the website's data.
- **Malicious Use**: An attacker submits `http://localhost/admin` or `file:///etc/passwd`, causing the server to access restricted resources.

---

## 🔍 Common SSRF Attack Types

### 1. **Basic SSRF**
- **Target**: Internal endpoints, private IPs, or external services.
- **Example**: `http://localhost/admin` or `http://169.254.169.254/latest/meta-data/`

### 2. **Blind SSRF**
- **Target**: External systems or services where no direct server response is visible to the attacker.
- **Technique**: Leverage tools like `webhook.site` or observe side effects (e.g., DNS logs).

### 3. **Port Scanning**
- **Target**: Identify open ports on internal or external networks.
- **Example**: Sequential requests to `http://localhost:22`, `http://localhost:80`, etc.

### 4. **Protocol Exploits**
- **Target**: Exploiting non-HTTP protocols like `file://`, `ftp://`, or `gopher://`.

---

## 🛡️ Defending Against SSRF

1. **Input Validation**
   - Strictly validate URLs to ensure they match expected formats or domains.
   - Reject schemas like `file://`, `ftp://`, `gopher://`.

2. **Domain Whitelisting**
   - Allow only trusted domains or IP ranges.

3. **Response Restrictions**
   - Limit or sanitize server responses to user requests.
   - Disable unnecessary response handling features.

4. **Network Segmentation**
   - Isolate critical internal systems from the internet-facing application.

5. **Secure Metadata Access**
   - Use instance identity tokens for cloud environments instead of relying on open metadata APIs.

---

## 🛠️ Tools for Testing SSRF

- **Burp Suite**: Intercept and modify HTTP requests.
- **Curl**: Simulate server requests from the command line.
- **FFUF**: Fuzz directories or parameters for SSRF vulnerabilities.
- **Commix**: Test for command injection combined with SSRF.

---

## 💡 Key Interview Takeaways

1. **Explain SSRF in Simple Terms**:
   - “SSRF is when attackers trick a server into making unauthorized requests to sensitive internal or external resources.”

2. **Demonstrate Lab Insights**:
   - Highlight your experience testing SSRF with tools like Burp Suite and FFUF.
   - Mention crafting payloads for metadata access, port scanning, or accessing restricted files.

3. **Emphasize Defense Techniques**:
   - Showcase knowledge of domain whitelisting, input validation, and secure configurations for internal services.

---

## 🧪 Lab Insights

### Lab 1: **Basic SSRF**

- **Objective**: Exploit SSRF to access `admin.php`.
- **Steps**:
  - Intercept POST requests with Burp Suite.
  - Modify URL to target `http://localhost/admin`.
  - Fuzz directories using FFUF.
- **Key Takeaway**: Demonstrated server request manipulation to access internal admin endpoints.

---

### Lab 2: **Blind SSRF**

- **Objective**: Trigger server requests to an external system (e.g., webhook.site).
- **Steps**:
  - Modify URL parameters to send requests to `https://webhook.site/...`.
  - Observe webhook logs to confirm server interaction.
- **Key Takeaway**: Highlighted the challenge of exploiting SSRF without direct feedback.

---

### Advanced SSRF: **Port Scanning Automation**

- **Script Overview**:
  - Crafted a Bash script to automate port scanning via SSRF.
  - Leveraged JSON payloads in SSRF-vulnerable endpoints.
- **Key Takeaway**: Demonstrated efficiency in probing internal networks via SSRF.

---

This SSRF overview provides a comprehensive understanding of the vulnerability, including real-world examples, defense techniques, and hands-on lab insights. It's an excellent resource to showcase your expertise in identifying, exploiting, and mitigating SSRF vulnerabilities.

---
