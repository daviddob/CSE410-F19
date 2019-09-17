# CSE410 - Lab 1

This lab will cover getting your servers tested, mounted into the server racks,
and have you start diagramming and documenting the install you'll be building
off of for the rest of the semester.

## Scheduling

As we only have one rack that you are all working out of, we will need to schedule
time slots to ensure only one group is working at a time. For this, we will use
the below Google Sheets document where a group can sign up for any available
time-slots. I would recommend scheduling time early and not waiting until the due
date to ensure you have plenty of time to complete the lab. Just add your
names' to the corresponding time slots you'd like to reserve (please limit to 2
hour consecutive blocks).

[Server Suite Scheduling Sheet](https://docs.google.com/spreadsheets/d/1ThT1EiMb8U6rE0Wi-b5N_OPGh5_YpP0jleBaVWVAJNY/edit?usp=sharing)

## Hardware and Network Assignments

Please refer to the Google Sheets document linked below for Server Assignment,
Rack Location, and Network Configuration information for your group.

[Hardware and Network Assignment Sheet](https://docs.google.com/spreadsheets/d/1oT5aFdJHxrpBRLtRfUloxs3zTLyxq5A6wlqUBfqjVgU/edit?usp=sharing)

## Diagrams and Documentation

This lab, as with the majority of labs this semester, will focus heavily on
diagrams and documentation. They will be the primary means of demonstrating you
completed sections of the lab and will serve as a guide should you need to set
up infrastructure in the future. As such, your documentation should be
comprehensive and be able to serve as a guide for someone who has not completed
the process before. This documentation for this lab will benefit heavily from
diagrams and pictures so be sure to include them.

## Server Testing

Before installing any server into a rack, it needs to be tested to ensure that it
is in proper working order and that the specifications match what was ordered.

For this lab, we will perform testing using the built-in Diagnostic Utility as
well as checking out the [Ultimate Boot CD](https://www.ultimatebootcd.com/). It
is a free bootable environment filled with tons of quick utilities for hardware
troubleshooting, testing, and diagnostics.

For the purposes of this lab, running the following tests should be sufficient.
However, for production environments, longer burn-in tests are recommended to
ensure performance and stability.

Look up and document the procedure for running hardware diagnostics on your
PowerEdge R710 Server (Hint - They are 11th Generation)

This process should take 15-20 minutes to complete. There may be warnings during
the testing due to missing media (i.e. CD Drive/etc). You can ignore these
warnings and have the testing proceed as we will not be testing those
components. Be sure to document the 'results' and 'errors' information - other
than CD Drive related warnings/errors, everything should be marked PASS. 

While the built-in diagnostic utility is running, download the UBCD ISO and
write it to a USB drive (or a CD). For making bootable USB drives, I'd recommend
checking out UNetBootin or similar utilities. 

Once the built-in diagnostic utility is complete, note the results and
power off the server. Then, insert the UBCD into your server, power it on, and
boot from the corresponding device by selecting the boot menu option. Once
booted into the UBCD environment, run the following tests. *Note: You'll need to
reboot the server after each test to return to the UBCD environment.*

- CPU/CPUstress -> System Stability Tester - Should finish quickly
- CPU/CPUstress -> CPU Burn-In v1.00 - Run for 5min then document and quit
- Memory/Memtest86 v4.3.7 - Run for 5min then document and quit (A full test
  will take hours)

Be sure to record the results of the tests as well as the steps you took to
perform the tests in your documentation. *Hint: Some of those steps can be
pulled directly from this document with slight modification*

## Inventory

After testing, your server needs to be added into inventory with its model number and
serial number (or similar identifying information) along with the corresponding
specifications.

Ensure you document the following in your 'inventory':
- Model of your server 
- Service Tag and Express Service Code
- CPU, RAM, HDD, and Power Supply specifications
 
Be sure to document where the above information was found. *Note: Do not remove
CPU heatsinks or RAM. (HDDs and PSUs can be carefully removed and inspected if
necessary)*

## Server Racking

When installing the server rails into the rack, please take note of the
locations assigned to you and install your rails accordingly. If improperly
installed, you could block the installation for other teams - impacting them,
and your score.

Install the cage nuts, screw in your rails using the provided screws, and test
that you can slide both rails out smoothly. Once your rails are securely mounted,
carefully lift your server into place, line up the pins on the side of the
server with the corresponding slots in the rails, and gently lower it into
place. Once it is secure in the rails, gently slide it back into the rack. Be
sure to describe each step of the process in your documentation.

## Cable Management

Now that your server has been tested and installed into a rack, it is time to
connect it to power and the network. For this section, you will create a diagram
showing the physical connections for your server such that if everything was
disconnected it could be accurately reconnected. 

Starting with power, route one power cable from your server to each of the PDUs
mounted in the rear side of the rack enclosure. Be sure to note which PSU is
plugged into which receptacle in each PDU for your diagram. For networking, route
three ethernet cables from your assigned drops in the top of the rack switch to
your server. One should be for the iDRAC port, the other two for VM Traffic and
VMWare Management.

Lastly, ensure your cables are neatly managed and labeled. I'm not looking for
perfection, but it is expected that teams have clean cables that are easy to
follow/troubleshoot and remove/replace if necessary. Servers will remain in
place and will not need to be slid in/out on the rails so take that into
consideration.

## Submission

Submission of this lab can be performed by writing up your documentation (in
Markdown format) and committing it to your repository under a 'labs' folder -
either its own Markdown file or in a subfolder as a README.