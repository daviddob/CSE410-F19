# CSE410 - Lab 2
## Due: 10/01/2019 17:00

This lab will cover configuring iDRAC (BMC Management), configuring a RAID
array, and installing the VMWare ESXI Hypervisor.

## Scheduling

As with the previous lab, we only have one rack that you are all working out of
and so
we will need to schedule time slots to ensure only one group is working at a
time. For this, we will use the below Google Sheets document where a group can
sign up for any available time-slots. I would recommend scheduling time early
and not waiting until the due date to ensure you have plenty of time to complete
the lab. Just add your names' to the corresponding time slots you'd like to
reserve (please limit to 2 hour consecutive blocks).

[Server Suite Scheduling Sheet](https://docs.google.com/spreadsheets/d/1ThT1EiMb8U6rE0Wi-b5N_OPGh5_YpP0jleBaVWVAJNY/edit?usp=sharing)

## Hardware and Network Assignments

Please refer to the Google Sheets document linked below for the Network
Configuration information for your group. This lab will require you to select an IP
address for iDRAC as well as an IP for the ESXI hypervisor management console,
so ensure that you select an IP from your team's assigned range when you reach
that section of the assignment.

[Hardware and Network Assignment Sheet](https://docs.google.com/spreadsheets/d/1oT5aFdJHxrpBRLtRfUloxs3zTLyxq5A6wlqUBfqjVgU/edit?usp=sharing)

## Diagrams and Documentation

Similar to the last lab, this lab will will focus heavily on diagrams and
documentation. They will be the primary means of demonstrating you completed
sections of the lab and will serve as a guide should you need to set up
infrastructure in the future. As such, your documentation should be
comprehensive and be able to serve as a guide for someone who has not completed
the process before.

## iDRAC Configuration

For remote management and console access we will be using the Integrated Dell
Remote Access Controller (iDRAC). When booting up your server, it will prompt you
for iDRAC network configuration as one of the options during POST. Select an IP
address from your range to use for iDRAC and configure it accordingly using the
network information provided in the above document. Once configured, you should
be able to open a browser and access the iDRAC interface as long as you are on
the UB network.

To log in to iDRAC for the first time, look up the default password and note it
in your documentation. Then, once in the iDRAC interface, you should change the
default root password and set up admin level users for each of you to access
iDRAC.

As discussed in class, you'll likely be using iDRAC for the Virtual Console and
remote power ON/OFF ability as well as health/status checking for your hardware.
Run through getting a Virtual Console session running and try performing the
rest of the lab via the Virtual Console (it'll make taking pictures/screenshots
much easier). Unfortunately it appears that the current version of Java doesn't
play nicely with the virtual console anymore so a slight workaround is required.
I have hosted older versions of the JRE (1.7.0_u80)
[here](https://drive.google.com/drive/folders/19z9QqDrbwgQwf83jzuy44CxG5by_W7I8?usp=sharing)
and the procedure for the workaround is located in this [github
gist](https://gist.github.com/xbb/4fd651c2493ad9284dbcb827dc8886d6). After
downloading the JRE corresponding to your Operating System and extracting it you
may have to modify the .bat or .sh script to point at the place you extracted
the JRE to. (Isn't working with legacy software fun?)

Take a quick tour around the iDRAC interface and document where you would look
to monitor different health checks and environmental readings as well as how to
power on, power off, or restart the server.

## Configuring RAID

When taking inventory in the last lab, you should have noticed that your server
falls into one of two configurations. It one of either:
 
* 1x internal SD Card, 2x 300GB HDDs, and 1x 1TB HDD
* 1x internal SD Card, 2x 300GB HDDs, and 2x 512GB SSDs.

When configuring RAID, ensure you end up with one 300GB volume as well as one 1TB
volume to ensure you have ample storage for the semester. This means you'll be
creating a RAID 1 volume out of the 300 GB drives and a RAID 0 volume from the
500GB SSDs (if applicable).

This will give us 300GB of storage for 'Critical Infrastructure' that can
survive a drive failure, as well as 1TB of storage for things that can be easily
rebuilt or restored from backups.

Similar to configuring iDRAC, RAID settings can also be accessed at startup
during POST. Create the above RAID volumes and document the procedure.

## Installing VMWare ESXI

The first step to installing ESXI is downloading the ESXI installer ISO. As we
need a specific version of ESXI (6.5) for the hardware we are using, and the
VMWare campus site only has 6.7 available for download, I have hosted the ISO
here for you. [Download ESXI 6.5 Installer](https://drive.google.com/file/d/1lBFE6gvCsrruynsEKecLylY75D0t6FRx/view?usp=sharing)

While that is downloading, you'll need to obtain the licensing information from
the [UB VMWare
website](https://e5.onthehub.com/WebStore/ProductsByMajorVersionList.aspx?cmi_mnuMain=f1f60417-9a88-e511-9412-b8ca3a5db7a1&ws=bcc13a83-ebc9-e011-ae14-f04da23e67f6&vsro=8).
Once you have signed in, select *VMware vSphere 6.7*, add it to your cart, and
check out. Come up with a name for your lab and enter `1` for the number of
machines onto which you will be installing the product. This will give you a
license key to use once you have installed ESXI.

Now that the ESXI installer ISO has finished downloading, either make a bootable
USB or burn it to a CD (the same process you used for UBCD in the previous lab).
Then, insert the bootable USB or CD into the server, reboot, and boot from the
appropriate boot device (using the iDRAC Virtual Console).

Once booted into the ESXI installer environment, run through the prompts to
configure which disk to install on (I recommend using the internal SD Card) as
well as the root password. Be sure to record the root password you configured as
it cannot be easily reset if forgotten.

After the install finishes and you reboot, it should load ESXI and be ready for
you to configure the network interface. If not, you may have to enter the BIOS
and ensure you configure it to boot from the apropriate device.


After configuring the management network interface and IP address, open your
browser and access the ESXI management interface via the IP you just configured.
Make sure there are no warnings or errors on the host summary page. If there
are, (there may be one related to scratch space), look up the corresponding
VMWare knowledgebase article to resolve the warning. Once everything looks good,
take a screenshot for your documentation.

Describe this procedure using screenshots or pictures where appropriate in your
documentation and include an updated diagram from Lab 1 including the
IP Address information that is now associated with each physical interface.

## Submission

Submission of this lab can be performed by writing up your documentation (in
Markdown format) and committing it to your repository under a 'labs' folder -
either its own Markdown file or in a subfolder as a README.