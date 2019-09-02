# CSE410 - Assignment 1

This assignment will cover Capacity Planning and run through a top-down exercise
for planning a new data center from Application all the way down to Hardware
planning. 

1. Define **Capacity** and **Demand** in your own words and provide examples of
   each
<br>
<br>
<br>
<br>
<br>
<br>
2. What is the difference between Design Capacity and Actual Capacity? How can we
   account for this difference when planning?
<br>
<br>
<br>
<br>
<br>
<br>
3. What are potential problems with increasing and decreasing capacity? (Name
   three for each)
<br>
<br>
<br>
<br>
<br>
<br>
4. What types of businesses would likely plan to have capacity lead
   demand? Which ones would likely plan to have capacity follow demand? Why?
  
<br>
<br>
<br>
<br>
<br>
<br>
The following questions are based on Company ABC, who is planning to build a
new data center to support their upcoming product. The product and
environmental specifications are provided below.

* Product Specifications:
    * 25,000 Total Peak Concurrent Connections
    * 6,000 Average Concurrent Connections
    * Seasonal demand spikes with flash sales

* Application Instance Specifications:
    * Can serve 500 concurrent connections
    * 2 CPU
    * 1536 MB RAM
    * 5 GB Disk
    * Runs on Ubuntu Linux (Assume OS requirements are 1 CPU 512 MB RAM and 2 GB
      Disk)

* Virtualization Specifications
    * Overhead for Virtual Machines is 5%
    * Hypervisor requires 1 CPU, 2 GB RAM, and 4 GB Disk

* Hardware Specifications (Each Physical Server has the following specifications)
    * 2x 12CPU Processors
    * 72 GB RAM
    * 1 TB Disk
    * 750W Power Draw (Assume 100% efficiency)
    * 2U Chassis

* Environmental Specifications
    * Electrical Circuits are 120V and 15A (Assume they can be used to 100%
      Load)
    * Cooling will be provided by 1 Ton CRAC Units
    * Racks will be 42U Tall


5. How many application instances are required during non-peak hours? What about
   peak hours?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
6. What are the total application resource requirements?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
7. How many physical servers does Company ABC need to purchase for this project?
   How many server racks are required to fit this gear?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
8. Which resource (if any) is the bottleneck when purchasing the physical
   servers? What would be the ideal specifications be for a physical server to
   ensure no resources are wasted?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
9. How much power is required to run the servers? If Company ABC wants to have
   redundant power, how many power circuits do they need?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
10. What is the total heat output of the servers (in BTU)? How many CRAC units
   are required to dissipate the heat?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
