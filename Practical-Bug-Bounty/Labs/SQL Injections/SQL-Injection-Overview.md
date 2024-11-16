
# 📚 SQL Injection Overview

---

## **Introduction to SQL Injections 🛡️💻**

### **What is SQL Injection?**
SQL Injection (SQLi) is a type of security vulnerability that allows an attacker to interfere with the queries that an application makes to its database.  
It involves inserting or "injecting" malicious SQL code into an input field for execution (e.g., data fields in web forms), which can lead to:
- Unauthorized access to sensitive data.
- Data manipulation.
- Complete control over the database.

---

## **How Are SQL Injections Used in Modern Attacks?**

In today's digital age, SQL Injection remains a prevalent threat due to the widespread use of databases in websites and applications. Attackers exploit SQLi to:
1. **Bypass Authentication:**  
   Manipulate SQL queries to log in as other users, including administrators.
2. **Access Sensitive Data:**  
   Extract private customer information, corporate data, and other confidential data.
3. **Modify Database Information:**  
   Alter or delete data, compromising data integrity.
4. **Take Over Systems:**  
   Execute administrative operations on the database or run malicious code affecting server operations.

---

## 🧐 Detailed Explanation of SQL Injection Example

### 🔍 Basic SQL Operation
When you search for a username like `jeremy`, the application performs a SQL query like:
```sql
SELECT username, email FROM users WHERE username = 'jeremy'
```

---

### 🤯 How Injection Works

1. **Single Quote (`'`):**  
   Terminates the user input portion of the SQL command, allowing injection of new commands.
2. **UNION SELECT:**  
   Combines results from the original query with a new `SELECT` statement. `null` values are used to match the number and type of columns expected in the original result set.
3. **Function Usage (`version()`):**  
   Extracts sensitive information, such as the database version.
4. **Comment Indicator (`#`):**  
   Comments out the rest of the original SQL query post-injection, ensuring only the injected part executes.

---

### **Example**
Injection:
```sql
jeremy' UNION SELECT null, null, version()#
```

**Key Points:**
- **Breaking Point (`'`):** Ends the input string.
- **UNION SELECT:** Injects a new query.
- **Function (`version()`):** Extracts database version.
- **Comment (`#`):** Neutralizes the remainder of the SQL command.

**Result:** The database version is revealed, showing the injection was successful.

---

## 📋 Step-by-Step Injection Process

1. **Step 1:** Extract table names.
   ```sql
   jeremy' UNION SELECT null, null, table_name FROM information_schema.tables#
   ```

2. **Step 2:** Extract column names.
   ```sql
   jeremy' UNION SELECT null, null, column_name FROM information_schema.columns#
   ```

3. **Step 3:** Extract sensitive data (e.g., passwords).
   ```sql
   jeremy' UNION SELECT null, null, password FROM injection0x01#
   ```

---

## 📋 Summary
SQL Injection is a powerful technique that can:
1. Bypass authentication.
2. Expose sensitive database information.
3. Compromise the security and integrity of web applications.

**Mitigation Tips:**
- Use prepared statements and parameterized queries.
- Implement robust input validation and sanitization.
- Regularly monitor and test for vulnerabilities.

---
