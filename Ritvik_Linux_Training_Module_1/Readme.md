## Assessment - Module 1

**The terminal log file is available [here](terminal.log)**. 

Download and `cat` the log file

```bash
wget https://raw.githubusercontent.com/Sharath15eUR/Ritvik/refs/heads/main/Ritvik_Linux_Training_Module_1/terminal.log && cat terminal.log
```


___

**Question 1 : Create a file and add executable permission to all users (user, group and others)**

```bash
touch ques1
chmod a+x ques1
```

**Question 2 : Create a file and remove write permission for group user alone.**

```bash
touch ques2
chmod g-w ques2
```

**Question 3 : Create a file and add a softlink to the file in different directory (Eg : Create a file in dir1/dir2/file and create a softlink for file inside dir1)**

```bash
mkdir dir1
cd dir1/
mkdir dir2
cd dir2/
echo "Question 3" >> ques3
cd ..
ln ./dir2/ques3 ques3_lnk
```

**Question 4 : Use ps command with options to display all active process running on the system**

```bash
ps ax
```

**Question 5 : Create 3 files in a dir1 and re-direct the output of list command with sorted by timestamp of the files to a file**

```bash
touch a_ques5 z_ques5 _ques5
ls -l --sort=time >> ques5_sorted.txt
```
