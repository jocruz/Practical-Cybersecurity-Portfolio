
# Commands Used in Lab 1 🛠️

### FFUF Command Breakdown
```bash
ffuf -request req.txt -request-proto http -w /usr/share/seclists/Passwords/xato-net-10-million-passwords-10000.txt -fs 1814
```

#### Key Parameters Explained:
- **`-request req.txt`:** Specifies a file containing the raw HTTP request.
- **`-request-proto http`:** Ensures the protocol is HTTP.
- **`-w`:** Points to the wordlist file used for testing passwords.
- **`-fs 1814`:** Filters responses by size, hiding results with a size of 1814 bytes (common failure responses).

#### Example Result
When running the command:
- A password of `letmein` returned a unique response with size **1808 bytes**, indicating a possible valid credential.
