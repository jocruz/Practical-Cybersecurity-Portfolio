---

## 🖥 Creating and Using Bash Scripts

***In simpler terms:***

***A Bash script is like a recipe that tells your computer exactly what steps to follow to accomplish a task. It automates repetitive tasks, making them faster and more error-free.***

### **Understanding Commands in Bash Scripts**

### **ping**

- **Function:** Sends ICMP echo requests to a network host to measure connectivity.
- **Example:** `ping 192.168.4.29 -c 1` → Pings the IP address with 1 echo request.

### **cat**

- **Function:** Displays the content of files.
- **Example:** `cat ip.txt` → Shows the contents of "ip.txt".

### **grep**

- **Function:** Searches for patterns within text.
- **Example:** `grep "64 bytes" ip.txt` → Finds lines containing "64 bytes" in "ip.txt".

### **cut**

- **Function:** Extracts sections from each line of input.
- **Example:** `cut -d " " -f 4` → Cuts and displays the fourth field of each line.

### **tr**

- **Function:** Translates or deletes characters.
- **Example:** `tr -d ":"` → Removes colons from the input.

### **Overview of the Bash Script**

### **Script with Comments**

```bash
#!/bin/bash
# Check if the IP address segment was provided
if [ "$1" =="" ]
then
    echo "You forgot an IP address!"
    echo "Syntax: ./ipsweep.sh 192.168.4"
else
    # Loop through the numbers 1 to 254
    for ip in $(seq 1 254); do
        # Ping each IP address in the subnet, capture lines with "64 bytes",
        # cut out the 4th field, and remove colons
        ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":"
    done
fi

```

### **Explanation of Script Components**

- **Shebang:** Starts with `#!/bin/bash`, indicating that the script should be run in the Bash shell.
- **If Statement:** Ensures the user provides an initial IP address segment. If not, it prompts the user to enter it.
- **For Loop:** Cycles through IP addresses from `1` to `254` appending to the base IP provided.
- **Ping Command:** Used within the loop to ping each IP in the subnet.

### **Writing For Loops in Bash**

- **Syntax:** `for var in list; do commands; done`
- **Example:** `for ip in 'seq 1 254'; do echo $ip; done` → Prints numbers 1 to 254.
- **Purpose:** Executes a series of commands for each item in a list.

### **Understanding If Statements and Variables in Bash**

- **If Statement:** Executes commands based on conditions.
- **Syntax:** `if [ condition ]; then commands; fi`
- **Example:** `if [ "$1" == "" ]; then echo "No IP provided"; fi`
- **Variable $1:** Represents the first argument passed to the script. It's checked to ensure it's not empty.

### **Practical Uses and Automation**

- The script automates the process of pinging a range of IP addresses, often used to identify which addresses are active in a subnet.
- Automating with Bash scripts reduces manual work and increases efficiency in system administration tasks.

---

## Explaining the one liner command from terminal:

$ for ip in $(cat ips.txt); do nmap $ip; done

---

### **Understanding Advanced For Loop with `nmap`**

### **For Loop with Nmap**

```bash
for ip in $(cat ips.txt); do
    nmap $ip
done

```

- **Explanation:** This script reads IP addresses from a file named `ips.txt` and uses `nmap` to scan each IP address listed in the file.
- **Components:**
    - `$(cat ips.txt)`: This command reads the file `ips.txt` and outputs its contents, which are then iterated over by the `for` loop.
    - `nmap $ip`: Scans the current IP address from the list for open ports and available services.

### **What is Nmap?**

### **Nmap (Network Mapper)**

- **Function:** A security scanner used to discover hosts and services on a computer network, thereby building a "map" of the network.
- **Common Usage:** Scanning for open ports, detecting operating systems and software versions, and identifying security vulnerabilities.
- **Example:** `nmap 192.168.1.1` → Scans the IP address `192.168.1.1` for open ports and services.
- **Overview:** Nmap is widely used by network administrators for network inventory, managing service upgrade schedules, and monitoring host or service uptime.

---