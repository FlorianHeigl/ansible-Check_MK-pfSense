

# new upstream: 
https://github.com/deepthinkag/ansible-Check_MK-pfSense

# Ansible Playbook for setting up Check_MK agent on pfSense

Automatically installs the Check_MK agent on a pfSense firewall.
Adds ipmi, libstatgrab (for amd64) and an update check

based off 'the' pfSense forum post (https://forum.pfsense.org/index.php?topic=111517.0#top) with some cleanups. We also use /opt but with a more FHS-compliant
 vendor-path structure putting things under ```/opt/check_mk```. 




## Notes

### Setup

you need to initially install python27 i.e. using:
```ansible -m shell -a "pkg install python27" myfirewillhostname```

you'll also need a firewall rule to allow connecting to port 6556! :-)

### Connections

A connection using sshpass (-k) turned out to be extremely flaky.
You are very much advised to store a key for connecting with Ansible.

We normally also prefer to connect via SSH for Check_MK, that part is your choice. You can just disable the xinetd listener in that case.
That's using ```disable = yes``` in ./roles/check_mk-pfsense/files/check_mk.inet

### IPMI

Time constraints resulted in generally adding IPMI. It has no adverse effect on systems that do not support it, but of course a more granular support would be nicer.


### The path
/opt/MK would be correct, but we can't do that
