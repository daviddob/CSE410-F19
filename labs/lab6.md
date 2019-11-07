# CSE410 - Lab 6
## Due: 11/15/2019 09:00

This lab will cover Infrastructure as Code using Terraform and Cloud-Init. It
will have you spin up several VMs, configure software of your choice, and
understand how scaling up/down works at scale. This can serve as a basis for
future work in IaC using Terraform for either vSphere or public clouds (AWS,
GCP, Azure, etc) with some modifications.

## Hardware and Network Assignments

Please refer to the Google Sheets document linked below for the Network
Configuration information for your group. This lab will require you select an IP
address for a couple Virtual Machines, so take your previous assignments into
consideration.

[Hardware and Network Assignment
Sheet](https://docs.google.com/spreadsheets/d/1oT5aFdJHxrpBRLtRfUloxs3zTLyxq5A6wlqUBfqjVgU/edit?usp=sharing)

## Diagrams and Documentation

Similar to the last lab, this lab will will focus heavily on diagrams and
documentation. These will be the primary means of demonstrating you completed
sections of the lab and will serve as a guide should you need to set up
infrastructure in the future. As such, your documentation should be
comprehensive and be able to serve as a guide for someone who has not completed
the process before.

## Creating a vSphere template for terraform

The first step when utilizing Infrastructure as Code via Terraform is
figuring out what VM Image you want to use as a base. When using vSphere, a
VM image takes the form of a vSphere VM Template, but when using other
infrastructures, it could be an AWS AMI, GCP Image, Azure Managed Image, etc.

Depending on your use case, the image could be as general or specific as you
require. It could just have a base OS distribution or it could have many
additional packages, configurations, and customizations baked in.

For the purposes of this lab, we will be using the current Ubuntu Bionic
Cloud Image available at https://cloud-images.ubuntu.com. We will then use
Cloud-Init to configure and provision VMs from this base OS image.

Start by importing the VM Template image and leave all of the customization
parameters blank (userdata, keys, hostname, etc). This will serve as a basis
for your IaC deployments.

## Spinning up templates using the vSphere UI

To test that your VM instance is working properly, clone your template to a
new virtual machine and fill out the vApp properties. Note that you may need
to use the Flash vSphere UI to be able to see the vApp properties. Fill out
the Public Keys, Password, Hostname, Instance-ID, and User-Data fields. The
Instance-ID can be the same as your Hostname. For the user-data field take
the
[user-data.yml](https://github.com/daviddob/CSE410-F19/blob/master/terraform/user-data.yml.template)
template provided for you in the repo, modify the network according to your
lab specifications, and base64 encode the resulting contents.

Your user-data should look something like:

```
I2Nsb3VkLWNvbmZpZwoKIyBDaGVjayB0aGlzIG91dCBmb3IgZnVydGhlciBjb25maWcgc3BlY2lmaWNhdGlvbiBodHRwczovL2Nsb3VkaW5pdC5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvdG9waWNzL2V4YW1wbGVzLmh0bWwKIyBBZGQgdG8gdGhlIGNvbmZpZyBiZWxvdyAoZG8gbm90IHJlbW92ZSBpdCBvciB5b3VyIG5ldHdvcmsgY29uZmlnIHdpbGwgZmFpbCkKCnVzZXJzOgogIC0gZGVmYXVsdAoKd3JpdGVfZmlsZXM6Ci0gY29udGVudDogfAogICAgbmV0d29yazoKICAgICAgZXRoZXJuZXRzOgogICAgICAgICAgZW5zMTkyOgogICAgICAgICAgICAgIGRoY3A0OiBmYWxzZQogICAgICAgICAgICAgIGRoY3A2OiBmYWxzZQogICAgICAgICAgICAgIGFkZHJlc3NlczogWzEwLjEwLjEwLjIvMjRdCiAgICAgICAgICAgICAgZ2F0ZXdheTQ6IDEwLjEwLjEwLjEKICAgICAgICAgICAgICBuYW1lc2VydmVyczoKICAgICAgICAgICAgICAgICAgYWRkcmVzc2VzOiBbMTAuMTAuMTAuMSwgMS4xLjEuMV0KICAgICAgdmVyc2lvbjogMgogIHBhdGg6IC9ldGMvbmV0cGxhbi81MC1jbG91ZC1pbml0LnlhbWwKCnJ1bmNtZDoKICAtIHN1ZG8gbmV0cGxhbiBhcHBseSAmJiBzbGVlcCA1
```

After you have filled out the vApp properties, spin up your VM. After it
finishes booting up you should be able to log-in using the `ubuntu` user and the
password you set. You should also be able to ssh in using the same user on the
IP address you encoded in the user-data. It may take a minute for the
network configuration to be applied after the machine initially boots up.

Now that you have a template that can be spun up and automatically configured,
it's time to automate it with Terraform.

## Spinning up templates using Terraform

A base configuration for vSphere Terraform has been provided for you in [this
repository](https://github.com/daviddob/CSE410-F19/tree/master/terraform). If
you pull down the template files and fill out the variables section in
`terraform.tfvars`, you should be able to spin up new blank template VMs with
a `ubuntu` default user, the VMs from which should be accessible with the
configured ssh keys.

Install Terraform v0.12 or higher - it can be downloaded from
https://www.terraform.io/downloads.html or downloaded via a package manager
for several systems (i.e. brew for MacOS)

Spin up 3 new VMs using Terraform and ensure you can SSH into each of them
using the key you provided.

Take a look through the Terraform configuration and ensure you understand how
it works. Understand what the different configuration options correspond to
and how they get from the variables file into the final configuration. For
sake of time, I have provided quite a bit to work off of and to show how
pre-built IaC can be run without intimate knowledge of the entire codebase.

## Use Cloud-Init to install software

Now that you are able to spin up VMs repeatably with terraform, it's time to
provision software on the VMs (blank VMs are only so good). This can
be accomplished using Cloud-Init (the provisioner that works off of
user-data). As you used in the previous section, the user-data file is what
can handle installing packages, configuring users/groups, writing files,
running commands/scripts, and more. The relevant documentation can be found
[here](https://cloudinit.readthedocs.io/en/latest/topics/examples.html).

Using Cloud-Init user-data, configure users for yourself and me (daviddob).
Leverage the ability to pull my ssh public keys from Github. I expect the
shell for my user to be `/bin/bash` - you can choose whatever you like for
yours. Multi-factor authentication for ssh on these VMs is not required.

Once you have users configured, it's time to install software. This lab is left open-ended in that you can run whatever it
is you want with a few caveats:

First, you must be able to horizontally scale the service. In other words, it
must benefit from running multiple copies of the gameserver, webserver,
software, etc.

Also, it must have some level of configuration after installation. For
example, installing a webserver, cloning down a website repo and configuring
the server to serve the website, or installing a gameserver, or configuring the
server rules.

**Once you have an idea of what you want to run, shoot me a message via Slack
with your idea for approval. Start thinking of ideas start this assignment
early.**

To lessen the number of test iterations required when writing the user-data
automation for running commands, setting up configuration, etc., it can be
helpful to spin up a blank VM and configure the software manually. You can
then take note of the commands you manually ran, and then use those to write
your user-data file.

If you are spinning up webservers, don't forget that you already have an
HAProxy from the previous lab you can use, with certificates configured on it
for wildcard domains.

For non-HTTP/HTTPS-based services (TCP/UDP), you may need to configure more
port forwarding rules, DNAT, or other load-balancing services to ensure your
services can be accessed dynamically once you spin them up.

## Testing

Once you are finished, you should be able to create and configure all of your
VMs for use with a single command. You should also be able to tear everything
down with a single command.

## Submission

Submission of this lab can be performed by writing up your documentation in
Markdown format and committing it to your repository under a 'labs' folder,
either as its own Markdown file or in a subfolder as a README.

In addition to the documentation, add your IaC to your repository in a folder
next to your documentation.
