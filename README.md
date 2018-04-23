# Ansible Playbook for setting up Check_MK agent on pfSense

uses xinetd, ssh key would of course also work.
you can just disable the xinetd listener.

based off a pfSense forum post with some cleanups

adds ipmi, libstatgrab (for amd64) and an update check


you need to initially install python27 i.e. using:
```ansible -m shell -a "pkg install python27" myfirewillhostname```

