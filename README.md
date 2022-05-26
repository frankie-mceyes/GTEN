# Get TOR Exit Nodes
A BASH script made to get current TOR exit nodes and save them into a file

# Main purpouse
This script was made to get all TOR exit nodes and save them into a file (which can be "tornodes.txt" or customized).
Useful for **IDS**, **IPS**, **SIEMs**, **routers** or any other network appliances, if you want to block/watch all TOR traffic targeting or coming through your service/network.

# Features
- After getting the new list, this will be sorted and unified
- If the file exists, results will be added in order to avoid overwriting of previously saved lists
- All the IP addresses are extracted from the official source of TOR exit nodes

# Watch out for the hour!
The list containing all the TOR exit nodes is publicly available, but **it is updated every hour** (check the archive of TOR Status to get old lists).
You should do a hourly `crontab` to get a fresh and updated list of exit nodes.

## Getting the usage

```
$ ./gten.sh -
Usage:
         ./gten.sh [filename]
```
## Example of usage saving the output to "file.txt"
```
$ ./gten.sh addresses.txt
[+] All nodes will be written on addresses.txt
[i] Writing 1039 exit nodes on addresses.txt...
[+] Nodes written: 1039
[i] Total entries: 2084

[i] Removing duplicates entries...
[+] 1038 duplicate addresses have been removed.
[+] Total entries: 1046
```
## Example of standard usage
```
$ ./gten.sh
[!] Filename not specified. All nodes will be written on tornodes.txt
[i] Writing 1045 exit nodes on ./tornodes.txt...
[+] Nodes written: 1045
[i] Total entries: 2090

[i] Removing duplicates entries...
[+] 1045 duplicate addresses have been removed.
[+] Total entries: 1045
```
