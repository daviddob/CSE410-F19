# CSE410 - Lab 4
## Due: 10/16/2019 09:00

This lab will cover the basics of linux server installation / administration,
multi-factor authentication setup, webserver setup, domain regirstraion, and DNS
record creation. At the end of the lab you should have a decent understanding of
the utilities and principles for administering and working remotely on a unix
system.

## Hardware and Network Assignments

Please refer to the Google Sheets document linked below for the Network
Configuration information for your group. This lab will require you select an IP
address for a couple Virtual Machines so take your previous assignments
into consideration.

[Hardware and Network Assignment
Sheet](https://docs.google.com/spreadsheets/d/1oT5aFdJHxrpBRLtRfUloxs3zTLyxq5A6wlqUBfqjVgU/edit?usp=sharing)

## Diagrams and Documentation

Similar to the last lab, this lab will will focus heavily on diagrams and
documentation. They will be the primary means of demonstrating you completed
sections of the lab and will serve as a guide should you need to set up
infrastructure in the future. As such, your documentation should be
comprehensive and be able to serve as a guide for someone who has not completed
the process before.

## Ubuntu Server Installation

Create a new VM on the external network and install the latest long term support
version of Ubuntu Server. It will just host a simple webserver so the resource
allocation does not need to be crazy. Look into the recommended Ubuntu webserver
hardware requirements and allocate accordingly.

Once you have the server installed, we need to set up a few new users - mainly
one for each of you as well as myself (daviddob). Each of these users should
have super user access on the server.

## Linux Server Administration

Lets go through the basics of linux systems administration and perform a few
common tasks and explore where different configuration options are stored. This
lab will only begin to scratch the surface of tasks you may need to perfom as a
linux admin, however it should at least hopefully have you practice looking for
solutions or how to do something you may never have had to do before.

Start be creating a new group `cse410` and adding all three users you created to
it. Then verify the users have been added to the group by running a command to
print out the user's id as well as all of the groups they are a member of.

Next, create three test files (`example1`, `example2`, and `example3`). For
`example1`, change the owner and group to `daviddob` and make the permissions
read/write or just `daviddob`. For `example2`, change the group to be `cse410`
and make it read-only just for the group and owner of the file. For `example3`,
make the file read-write for both of your users and read-only for `daviddob`
(you may need to be a bit creative here).

Now, create a symbolic link called `exampleLink` and point it at `example1` - it
should also have the same permissions as `example1`.

A common issue with servers is time drift, where the clock on the server
eventually drifts from the accutate time (just like cars, microwaves, etc). To
solve this problem, servers use network time protocol to sync with a time-server
and ensure accurate time. To prevent this issue from occurring on your Ubuntu
server, install and configure NTP to point at a few local time servers.

Because software is fairly easy to install on modern systems, and often
automatically install a number of dependencies, it can be easy to lose track of
what software is installed on your server. How can you generate a list of
currently installed software? What are a few useful packages that come
preinstalled with the latest version of Ubuntu?

When looking at the filesystem, you often want to see when a disk is getting
full. List all of the filesystems on your server along with the current usage.
In addition to the filesystem as a whole, it can be quite useful to see how much
space part of the filesystem is currently using. List the sizes of `/usr`,
`/var`, and `/etc` (be careful with permissions).

Lastly, we should look at network configuration. You initially configured it
during the installer, but how can you change it once the server has been
initially configured? Start by using a utility to find the currently configured
IP, subnet mask, gateway, mac address, and hostname. Then look into where you
would need to change these configuration options (you may have to perform this
later in the lab).

In addition to the servers configuration, it can also be important to find what
applications are listening for network traffic (i.e. webservers, ssh, etc).
Discover how to list all processes that are listening for network traffic as
well as what port, protocol, PID (Process ID #), and program name they are
using.

## SSH Authentication Setup

While administering a server from the vCenter Virtual Console isn't terrible
(especially when you compare it to iDRAC), usually direct access to the server
is preferred via SSH. Set up SSH access for each of your users as well as mine
([my ssh keys are available on github](https://github.com/daviddob.keys)). For
security, you should disable SSH authentication via password and force users to
use ssh keys.

In addition to forcing the use of SSH keys, for this lab you will also implement
multi-factor authentication. I would recommend using Google Authenticator for
multi-factor support, however you are welcome to use whatever method youd like
(just include the relevant information in your documentation that ill need to
log-in).

## WebServer Setup

Next, youre going to install either the Apache or Nginx webserver (id recommend
Apache for this as it requires PHP for which Apache has native integration -
i.e. LAMP) and we are going to install
[PHPSysInfo](http://phpsysinfo.github.io/phpsysinfo/) to display some basic
statistics and info about the server you've installed it on via a webpage.

There are several ways to install phpsysinfo and several guides out there for
accomplishing each. To get the most current version installed you just need to
download the newest release from their github page and extract it to the Apache
webroot. If you just see a text webpage that looks like the following, you
likely forgot to install PHP.

``` php
<?php
/**
 * start page for webaccess
 * redirect the user to the supported page type by the users webbrowser (js available or not)
 *
 * PHP version 5
```

Once you have phpsysinfo set up, spin up 2 more exact copies of the server you
just configured (using different hostnames, IPs, etc) and ensure you can access
phpsysinfo from all three of them. (Hint - for this take advantage of the clone
feature in vCenter and just change the relevant configs once they spin up).

Now that we have three webservers spun up, its time to set up DNS.

## Domain Registration and DNS Setup

To set up a domain, visit you [Github Educational
Pack](https://education.github.com/pack/offers) and check out the offers from
NameCheap, Name.com, and .TECH which all offer free domains for one year for
students. The domain name does not have to be specific for the class, so feel
free to create one that you'd like to use going forward for something (i.e. a
personal website). If you already have a domain name, feel free to use that as
well.

After registering for a domain, set up the following dns records to point at the
the services you now can use names for. The names you use for these records are
up to you to decide, just note them accordingly in your documentation.

A record for IPMI (i.e. ipmi.mylab.com)

A record for ESXI (i.e. esxi.mylab.com)

A record for vCenter (i.e. vcenter.mylab.com)

A record for web server 1 (i.e. web1.mylab.com)

A record for web server 2 (i.e. web2.mylab.com)

A record for web server 3 (i.e. web3.mylab.com)

Then create A records that point the same name at all three webservers (i.e. webcluster.mylab.com)

After entering your records and waiting a bit for them to propogate, you can try
accessing your services via their new names. You should also use `dig` to look
up a few if your records to make sure they are entered correctly - especially
for the webcluster.mylab.com records.

Now that you have everything working, try going to the phpsysinfo website via
the webcluster DNS record and refreshing the page a bunch of times. Do you
always get the same backend webserver? How can you tell? Why do you think this
is the case? What happens if you stop the webserver on one of the servers?

## Updated Diagrams

Update your diagram from the previous lab once again to now include the
additional Virtual Machines, Virtual Networks, and IP address assignments where
applicable

## Submission

Submission of this lab can be performed by writing up your documentation (in
Markdown format) and committing it to your repository under a 'labs' folder -
either its own Markdown file or in a subfolder as a README.