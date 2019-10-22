# CSE410 - Lab 5
## Due: 11/06/2019 09:00

This lab will cover internal vs external networking, NAT, gateways, firewalls,
VPNs and SSL. You will be configuring your own Gateway using pfSense to provide
a larger internal network as well as a VPN to access the internal network.
You'll also be configuring haproxy with SSL termination as a load-balancer for
ingress to internal services.

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

## pfSense Gateway

To set up an internal network for this lab we are going to use
[pfSense](https://www.pfsense.org/), an open source firewall and gateway
solution. You can download the ISO image from their website to later boot from.
While that is downloading, we need to prepare the new virtual network
environment. In a previous lab, you should have created an "External" Virtual
Network port group off of the default vSwitch0. To create a new "internal"
virtual network, you'll need to create a new vSwitch and a new "Internal" port
group off of that.

Now that you have a new "Internal" network, we can create the pfSense VM as a
Gateway between the two vSwitches and provide internet access for "Internal"
VMs. When creating the new VM, look up the recommended system requirements, add
one network interface from both the "Internal" and "External" networks, mount
the boot ISO, and fire it up to begin installation. This should have you run
through a quick wizard to partition your drive and install pfSense. Once
complete, it should have you reboot and begin configuration.

Once installed, you should be able to use the CLI to select your interfaces (one
for WAN, one for LAN), set up IP addresses for those interfaces (you get to
choose the internal network range you want), and set up DHCP for the internal
network.

To test that everything is working, create a new VM on the "internal" network,
ensure it is assigned an IP address in the DHCP range you configured, and ensure
you have internet access from that new VM.

## pfSense VPN

The rest of the pfSense configuration can be performed from the web interface.
The only caveat here if you try to access the web interface from the "External"
IP address, it is not accessible. This is due to the fact that you do not want
anyone on the internet to be able to access your gateway settings. However in
this instance, it makes configuration interesting as you likely do not have a
machine on the inside with a web interface or a way to access the internal
interface yet from your laptop out on the UB network. So to get around this
there are two options - create a VM on the internal network with a desktop
environment and web browser, or temporarily disable the firewall via the
command-line interface. If you choose to disable the firewall temporarily, just
be aware that it likes to re-enable itself whenever you make configuration
changes.

To configure OpenVPN on pfSense I'd recommend using the VPN setup wizard located
under the VPN->OpenVPN->Wizards menu, however you are more than welcome to
configure it however you wish. The wizard should run you through creating the
necessary certificates, and configuring the relevant options (the defaults are
often pretty sane).

Now that you have OpenVPN set-up, its time to create users and generate config
files for them to use. As usual, create a user for each of you and myself
(daviddob) and assign them to the 'admins' group. To generate the OpenVPN config
files, I'd recommend installing the 'openvpn-client-export' package from the
WebUI package manager which will add a 'Client Export' menu item under the
VPN->OpenVPN menu. This should give you a bunch of options for automatically
generating config files for all sorts of different clients. 

Install the appropriate VPN client on your system and configure it accordingly
using the generated configs from pfSense. The configuration for my user can be
generated using 'Inline Configuration -> Most Clients' and stored in the repo.

Presuming you have everything set up correctly, you should be able to connect to
your VPN (if you are on the UB VPN/UB Network already) and be able to access the
VM you created on the "Internal" network using its IP as well as be able to
access the pfSense WebUI using its 'internal' IP Address.

## Load Balancing

If we are going to be creating VMs on the "internal" network, we need some way
of allowing external users to access services without requiring the use of the
VPN. As discussed in class, there are a few ways of going about this. For this
lab, we will be using Port Forwarding and haproxy Load-Balancing.

Firstly, take the three VMs you created in the previous lab and move them to the
"internal" network assigning new static IPs accordingly. You should now be able
to access them on their new IPs when connected to the VPN, however if you
disconnect from the VPN they should now be inaccessible.

The first approach you can use to access VMs behind the gateway is to use Port
Forwarding. Configure port forwarding so you can access one of the phpsysinfo
VMs using the pfSense external IP.

While the above approach works, it only allows you to associate one port with
one VM, so currently you have no way of accessing all three of the VMs you
created in the previous lab on their standard ports (http/80).

To do this, you'll need to implement a load-balancer which will live either on
the internal network and be accessible via port forwarding through the gateway,
or on the external network and also have an interface on the internal network
(similar to the gateway) - such that it can handle external requests and balance
them between the three internal webservers. Either approach is valid and up to
you to determine which you want to implement.

Create a new VM for the load-balancer according to your approach, install Ubuntu
server 18.04 on it, configure it with a user for each of you (and myself) with
key-based ssh access, and install the haproxy package using apt.

Now that you have haproxy installed, you should be able to use a relatively
simple round-robin balance algorithm using a front-end bound to port 80 (http) and
a back-end pointing at your three servers. (Example configs are easily searchable)

Remove the DNS records for the web-cluster you created in the previous lab to
implemented load balancing with DNS, and instead point at just the haproxy IP.
If you now keep hard-refreshing the page, you should see the "Listening IP"
change each time in a round-robin fashion.

## SSL Termination

Now that you have a load-balancer its important to ensure connections to your
backend webservers are secure over the internet. To accomplish this, we are
going to use LetsEncrypt to have a wildcard ssl certificate issued for our
domain. This way you only need one certificate to configure the load-balancer
with and it makes managing the configuration much easier.

There is a ton of documentation regarding setting up certbot on Ubuntu issue a
LetsEncrypt wildcard cert using the DNS challange. I'd recommend following one
of those guides to get set up and have your cert issued on your haproxy VM.

Now that you have a wildcard cert issued for your domain, configure the haproxy
frontend to use https and redirect http traffic to the new https endpoint. If
everything is working correctly, you should now have a secure https connection
to your webserver cluster as well as be set up for any other subdomains you'd
like to spin up on the internal network behind the load-balancer.

This is just beginning to scrape the surface of what haproxy can really do. If
you are interested in load-balancing different domains to different backends,
different paths to different backends, etc it can do all that and more. Check out
the documentation
[here](http://cbonte.github.io/haproxy-dconv/1.8/configuration.html) if you are
interested.

## Updated Diagrams

Now that you have both internal and external virtual networks, a gateway, and a
load-balancer, the previous network diagram needs to be updated to reflect all of
the changes. Your diagram should include the physical switches, virtual
switches, port groups/virtual networks (and their network ranges), and VMs + IP
assignments in their respective virtual networks.

In addition to the above updated network diagram, also include another diagram
showing how a web request from a laptop on the UB Network is served by your 3
webservers. Be sure to include the Webservers, Gateways, and Loadbalancers along
with their relevant IP Addresses where applicable. (Note: You may abstract away
any intermediate infrastructure between your Laptop and the Gateway for the Lab)

## Submission

Submission of this lab can be performed by writing up your documentation (in
Markdown format) and committing it to your repository under a 'labs' folder -
either its own Markdown file or in a subfolder as a README.