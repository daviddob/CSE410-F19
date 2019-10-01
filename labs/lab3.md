# CSE410 - Lab 3
## Due: 10/09/2019 09:00

This lab will cover deploying vSphere on top of your ESXI hypervisor, setting up
virtual networking, datastores, and user accounts. At the end of this lab you'll
have an environment that is ready for virtual machine installs. 

Everything in this lab should be able to be performed remotely using iDRAC and
ESXI management consoles so we should not need to schedule server suite access.
If for some reason you need physical access feel free to do what you need as
there shouldn't be contention over access with this lab. That said, please
start the lab early to ensure you finish on time.

## Hardware and Network Assignments

Please refer to the Google Sheets document linked below for the Network
Configuration information for your group. This lab will require you select an IP
address for the vSphere management console so take your previous assignments
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

## Base Hypervisor Configuration

Before we can set up the VMWare vCenter virtual machine, we need to set up
networking and storage on the underlying ESXI hypervisor. Starting with storage,
create 2 new datastores from the RAID arrays that were created in the previous
lab.

For networking you should see that ESXI automatically created a vSwitch with two
Port Groups attached to it (Management and VM Network). As we will be setting up
more complex networking in a future lab, you should remove the 'VM Network'
port group and create a new one (also on vSwitch 0) with a more meaningful
name as this new port group will be used for VMs that need external
(128.205.X.X) IP addresses. Finally, you'll need to modify the default
vSwitch 0 to add your secondary physical NIC for redundancy and load
balancing.

## VMWare vCenter Installation 

You'll first need to obtain the licensing information from the [UB VMWare
website](https://e5.onthehub.com/WebStore/ProductsByMajorVersionList.aspx?cmi_mnuMain=f1f60417-9a88-e511-9412-b8ca3a5db7a1&ws=bcc13a83-ebc9-e011-ae14-f04da23e67f6&vsro=8).
Once you have signed in, select *VMWare vCenter Server 6 Standard*, add it to
your cart, and check out. Come up with a name for your lab and enter `1` for the
number of machines onto which you will be installing the product. This will give
you a license key to use once you have installed vCenter as well as the
installation media to download.

Once downloaded, you can mount the ISO on your local machine and browse for the
installer under the vcsa-ui-installer directory. This will take you through the
installer for setting up vCenter on your server. When asked, you'll want to
choose the Embedded Platform Services Controller, choose a memorable SSO domain
name (either ending in .local, or part of a domain you already own), select Tiny
for the appliance size, the more reliable of your two datastores, and your
newly created virtual network. The other options are up to you to fill out, just
be sure to document your process.

Once you complete the installer, you should be able to open your browser and
access vCenter on the IP address you specified in the configuration. Take note
that there are two UI options (Flash and HTML5) - while HTML5 is the preferred
option, it does not have full functionality and you may need to go back to the
flash UI to complete some tasks.

Now that you are signed into the vCenter UI using the administrator credentials,
create new user accounts for each of you and myself (daviddob) and assign each
administrator privileges using the Administrator group. At this point you should
also make it so you can log in using just the username without needing to
specify the domain as well.

Once you have new users created, apply your licensing information, create a
Datacenter and Cluster and add your Host to it.

## Updated Diagrams

Update your diagram from the previous lab once again to now include, Virtual
Machines, Virtual Networks, and IP address assignments where applicable

## Submission

Submission of this lab can be performed by writing up your documentation (in
Markdown format) and committing it to your repository under a 'labs' folder -
either its own Markdown file or in a subfolder as a README.