
---

# 📄 Script Summary

### 📁 **Directory Setup**

- **Purpose**: Prepares the directory structure for storing the outputs of subdomain discovery, screenshots, and scans.
- **Operations**:
    - Checks and creates a main directory named after the domain.
    - Inside the main directory, it creates three subdirectories: `subdomains`, `screenshots`, and `scans`.

### 🔎 **Subdomain Discovery**

- **Tools Used**: `subfinder`, `assetfinder`, and optionally `amass` (commented out).
- **Operations**:
    - **subfinder**: Searches for subdomains and outputs the results to `found.txt` within the `subdomains` directory.
    - **assetfinder**: Continues the search and appends additional findings to the same `found.txt` file.
    - **amass** (if uncommented): Would add yet more subdomains to `found.txt`.

### 🌐 **Identify Alive Subdomains**

- **Tools Used**: `httprobe` with support from `grep`, `sort`, `sed`, and `tee`.
- **Operations**:
    - Filters the `found.txt` for unique entries.
    - Uses `httprobe` to test which subdomains are active, focusing on those with HTTPS.
    - Saves the active subdomains to `alive.txt`.

### 🖼️ **Screenshot Active Subdomains**

- **Tool Used**: `gowitness`.
- **Operation**:
    - Takes screenshots of the active subdomains listed in `alive.txt` and saves them to the `screenshots` directory.

### 🛡️ **Network Scanning**

- **Tool Used**: `nmap`.
- **Operation**:
    - Scans all ports of the active subdomains using a fast and aggressive setting, saving the results in `nmap.txt` within the `scans` directory.

### 🚀 **Execution Flow**

- The script initiates by checking for the necessary directories and creating them if they do not exist.
- It sequentially executes tools to discover subdomains, checks their availability, captures their state via screenshots, and performs a comprehensive network scan.
- Each stage of the script is highlighted with red color-coded messages to indicate the start of a new operation.

### 🖥️ **Output Management**

- Uses sophisticated text processing commands to filter, sort, and manage outputs effectively, ensuring clarity and usefulness of the data captured.

---

This summary encapsulates the script’s purpose, tools, operations, and output management in a structured format that should be clear for any reader on your Notion page.

---

## 🛠 Setup Directories

### 1. **Create Necessary Directories**:

Ensures that the directories for storing subdomains, screenshots, and scan results exist. If they do not, the script creates them.

---

## 🔍 Subdomain Discovery

### 2. **Tools Used**:

### **subfinder**

`subfinder -d $domain > $subdomain_path/found.txt`

- **Purpose**: Finds subdomains.
- **Command**: `subfinder -d $domain`
- **Output**: Writes to `found.txt` under the `subdomains` directory.

### **assetfinder**

`assetfinder $domain | grep $domain >> $subdomain_path/found.txt`

- **Purpose**: Appends additional subdomains found to the existing list.
- **Command**: `assetfinder $domain | grep $domain`
- **Output**: Appends to `found.txt`.

### **amass** (Commented Out) (takes too long)

`#amass enum -d $domain >> $subdomain_path/found.txt`

- **Purpose**: Also used for subdomain enumeration (not active in this script).
- **Command**: `amass enum -d $domain`

---

## ✅ Checking Alive Subdomains

### 3. **Identify Active Subdomains**:

Sorts and checks which subdomains from `found.txt` are alive using `httprobe`.

- **Tools**: `httprobe`, `sort -u`
- **Output**: Results are saved in `alive.txt`.

---

## 📸 Taking Screenshots

### 4. **Screenshot Active Subdomains**:

`gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http`

Uses `gowitness` to capture screenshots of the active subdomains.

- **Command**: `gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http`

---

## 🚨 Network Scanning

`nmap -iL $subdomain_path/alive.txt -T4 -p- -oN $scan_path/nmap.txt`

### 5. **Scan with nmap**:

Performs a detailed scan on the active subdomains using `nmap`.

- **Command**: `nmap -iL $subdomain_path/alive.txt -T4 -p- -oN $scan_path/nmap.txt`

---

## 🧰 Flags and Tools

### 6. **Explanation of Flags**:

- **Echo `e`**: Interpret color codes and other backslash escapes.
- **Redirection and Pipes**: Use `>`, `>>`, and `|` for managing outputs.
- **Text Tools**: Utilize `grep`, `sort`, `sed`, and `tee` for text manipulation.

---

---

## 🧩 Text Tools Explained

These tools are used in the script for manipulating and processing text data efficiently.

## 🔍 **grep**

- **Purpose**: Filters and searches text based on patterns.
- **Usage in Script**: It is used to select lines that contain the domain name from the output of other tools.
- **Example**: `assetfinder $domain | grep $domain` filters the output of `assetfinder` to include only lines that contain the domain name.

## 🔄 **sort**

- **Purpose**: Arranges text lines in a specific order.
- **Usage in Script**: It sorts the list of subdomains and removes duplicates to ensure each subdomain is listed once.
- **Example**: `sort -u` sorts lines and `u` flag removes duplicate entries.

## ✂️ **sed**

- **Purpose**: Edits text based on specific rules, such as substitution, deletion, or insertion.
- **Usage in Script**: In the context of the script, `sed` could be used to modify the output format or content, such as removing unwanted parts of URLs or changing text formats. However, it's noted as a potential tool since it’s not explicitly used in the provided script lines.
- **Example**: `sed 's/https\?:\/\///'` would remove the 'http://' or 'https://' part from URLs if it were in the script.

## ➡️ **tee**

- **Purpose**: Reads from standard input and writes to standard output and files.
- **Usage in Script**: It writes the output to both the terminal (for immediate viewing) and a file for logging.
- **Example**: `| tee -a $subdomain_path/alive.txt` appends the output to `alive.txt` while also allowing it to be viewed live.

---
