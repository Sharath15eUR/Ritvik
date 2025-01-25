## Assessment - Module 2
___

**Question 1 : Use the appropriate command to list all files larger than 1 MB in the current directory and save the output to a file.**

```bash
ls -l | awk '/^[^d]/ {if($5>2**20) print $NF}' >> large_files.txt
```

[Solution 1](./Q1.txt)

___

**Question 2 : Replace all occurrences of "localhost" with "127.0.0.1" in a configuration file named config.txt, and save the updated file as updated_config.txt**

```bash
sed 's/localhost/127.0.0.1/g' config.txt >> updated_config.txt
```

[Solution 2](./Q2.txt)

___

**Question 3 : Use the appropriate command to search for lines containing the word "ERROR" in a log file but exclude lines containing "DEBUG". Save the results to a file named filtered_log.txt.**

```bash
cat log.txt | grep -i error | grep -iv debug >> filtered_log.txt
```

[Solution 3](./Q3.txt)

___

**Question 4 : Write a code to identify the process with the highest memory usage and then terminate it.**

```bash
kill $(ps aux | awk '{print $4"\t"$2}' | sort -r | awk '{if(NR==2) print $2}')
```

[Solution 4](./Q4.txt)

___

**Question 5 : Use the networking tool command and print all the gateway available in a sorted manner**

```bash
netstat -r | awk '{if(NR>2) print $2}' | sort -u
```

[Solution 5](./Q5.txt)
