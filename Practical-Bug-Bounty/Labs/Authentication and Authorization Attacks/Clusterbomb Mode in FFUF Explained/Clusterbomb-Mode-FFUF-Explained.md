
# 📔 Clusterbomb Mode in FFUF Explained

---

## 🚀 FFUF Testing Modes

### 1️⃣ Clusterbomb Mode
#### What is Clusterbomb Mode? 🤔
**Combination Testing:**  
This mode tests every possible combination of usernames and passwords from two lists. For example, if you have 3 usernames and 3 passwords, FFUF will make **9 attempts** in total, testing every username with every password.

---

#### Example Scenario 📝
**Usernames:**  
- Alice, Bob, Charlie  
**Passwords:**  
- 123, 456, 789  

**Tests Conducted:**  
- Alice with 123, 456, 789  
- Bob with 123, 456, 789  
- Charlie with 123, 456, 789  

---

#### Usage Guidelines ✅
- **Thorough Testing:**  
  Best used when you need to test all possible combinations, such as during security testing to ensure no combination allows unauthorized access.

- **Command Example:**
  ```bash
  ffuf -request l3request.txt -request-proto http   -w /usr/share/seclists/Usernames/top-usernames-shortlist.txt:USER   -w /usr/share/seclists/Passwords/xato-net-10-million-passwords-10.txt:PASS   -mode clusterbomb -o results.csv -of csv
  ```

---

### 2️⃣ Pitchfork Mode
#### What is Pitchfork Mode? 🤔
**Parallel Testing:**  
This mode pairs entries from multiple lists in parallel, meaning the **first entry** from one list is tested with the **first entry** from another list, and so on.  
> Requires the lists to be of the same length or stops when the shortest list is exhausted.

---

#### Example of Pitchfork Mode 📝
**Usernames:**  
- Alice, Bob, Charlie  
**Passwords:**  
- 123, 456, 789  

**Tests Conducted:**  
- Alice with 123  
- Bob with 456  
- Charlie with 789  

---

#### When to Use Pitchfork Mode? ✅
- **Specific Scenarios:**  
  Useful when testing parameters that should correspond across lists, like testing different configurations or settings.

- **Efficiency:**  
  More efficient when the correct pairings are known, reducing the number of unnecessary tests.

---

### Final Notes
This guide visually separates **Clusterbomb** and **Pitchfork** modes for quick reference, highlighting their distinct use cases and providing clear examples and commands for each.
