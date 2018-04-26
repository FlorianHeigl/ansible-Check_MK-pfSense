# Ansible Playbook for setting up Check_MK agent on pfSense


## What it does

Automatically installs the __Check_MK__ agent on a __pfSense__ firewall.

The Playbook is based off 'the' pfSense forum post (https://forum.pfsense.org/index.php?topic=111517.0#top) with some cleanups. We also use /opt but with a more FHS-compliant.

It also sets up a few extras: 

* <ins>IPMI</ins> - interesting for achieving monitoring of the hardware sensors, and allows to use the hardware watchdog for less-than-rock-solid firewalls
* <ins>pfSense updates</ins> - alerts with warning status if you need to update your firewall (also from forum or somewhere else, could not identify the source)
* <ins>libstatgrab</ins> - needed for monitoring network devices (a amd64 package is included)
* <ins>squidclient</ins> - Squid client check


We adjusted the paths from the forum entry to a FHS-compliant structure including vendor path. That means we put things under ```/opt/check_mk```. 





## Setup

you need to initially install python27 i.e. using:
```ansible -m shell -a "pkg install python27" my-firewall-hostname```

you'll also need a firewall rule to allow connecting to port 6556! :-)

We set up ignore rules for some services

* NIC parameters for __lagg/vlan__
* Whole Interfaces like __ix__


## Notes

### Connections

A connection using sshpass (-k) turned out to be extremely flaky.
You are very much advised to store a key for connecting with Ansible.

We normally also prefer to connect via SSH for Check_MK, that part is your choice. You can just disable the xinetd listener in that case.
That's using ```disable = yes``` in ```./roles/check_mk-pfsense/files/check_mk.inet```

### IPMI

Time constraints resulted in generally adding IPMI. It has no adverse effect on systems that do not support it, but of course a more granular support would be nicer.


### The path
/opt/MK would be correct, but we can't do that :-)


## Contributions

Please, go ahead, there's still many things that could be improved for pfSense monitoring.
Let us know about missing docs, too.
