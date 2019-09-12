# CSE410 - Assignment 2
## Due: 9/17/2019 17:00
This assignment will cover network planning and basic networking concepts

This assignment can be submitted by committing an updated version of this file
to your course repo under an 'assignments' folder. It can be in its own markdown
file, or as the README of its own folder depending on your preference.

1. What is the difference between the Network Edge and the Network Core? Which
   types of devices belong in the Edge? Which types of devices belong in the Core?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
2. What are the two methods of IP Address assignment? When would you want to use
   one over the other?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
3. Convert the following CIDR notation to IP Address ranges and corresponding
   subnet masks (show your work) (i.e. 10.0.0.0-10.0.0.255, 255.255.255.0)
   * 10.128.0.0/16
   * 58.105.46.0/25
   * 192.168.0.0/19
<br>
<br>
<br>
<br>
<br>
<br>
<br>
4. What would the smallest CIDR block be to accommodate 2192 hosts? What about 29812?
   How about 435? (i.e. /24, /16, etc)
<br>
<br>
<br>
<br>
<br>
<br>
<br>
5. Why would we want to use a hierarchical over a flat network? Whats the
   difference?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
6. Assume you have a network with the following topology where all hosts are trying
   to use as much bandwidth as possible when communicating and bandwidth is
   shared among connections equally. 
   
```
                              / --- Host E
   Host A --- 3G --- 5G --- 10G --- Host B
                \             \ --- Host D
                 \ --- Host C
```
    * Host A is talking to Host C
    * Host D is talking to Host A
    * Host E is talking to Host B

    What are the effective speeds of the above connections?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
7. With a link speed of 1Gbps how long would it take to download a 55GB file?
   What if the link speed was 300Mbps?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
8. If you are moving to a new data center and you currently have 55TB of data
   and a 1Gbps link between the data centers, would it be faster to send the
   data over the wire or would it be faster to ship via FedEx with
   guaranteed delivery in 5 total days?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
9. Assuming you purchased a domain cse410.com and wanted to set up DNS, which
   type of DNS server would you put A, CNAME, MX, SRV, and TXT DNS entries in? 
   (root, tld, etc). Give an example entry for setting cse410.com to the IP
   address 10.128.10.1 and setting an alias for www.cse410.com to the same IP
   address.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
10. What are the pros/cons to having a long TTL on DNS entries? When would you
    want to have a record with a long (i.e. 86400) TTL? When would you want to
    have a record with a short (i.e.
    60) TTL? Why?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
