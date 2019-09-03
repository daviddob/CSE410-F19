# CSE410 - Assignment 1
## Due: 9/10/2019 18:00
This assignment will cover Capacity Planning and run through a exercise
for planning a new data center top-down, from Application all the way down to Hardware
planning.

This assignment can be submitted by committing an updated version of this file
to your course repo under an 'assignments' folder. It can be in its own markdown
file, or as the README of its own folder depending on your preference. If
calculations are easier for you to perform on pen and paper (as they usually are
for me), feel free to do so and embed images for your answers.

1. Define **Capacity** and **Demand** in your own words and provide examples of
   each
<br>
<br>
<br>
2. What is the difference between Design Capacity and Actual Capacity? How can we
   account for this difference when planning?
<br>
<br>
<br>
3. What are potential problems with increasing and decreasing capacity? Name
   three for each.
<br>
<br>
<br>
4. What types of businesses would likely plan to have capacity lead
   demand? Which types of businesses would likely plan to have capacity follow
   demand? Why?
<br>
<br>
<br>
The following questions are based on Company ABC, who is planning to build a
new data center to support their upcoming product. The product and
environmental specifications are provided below.

* Product Specifications:
    * 40,000 Total Peak Concurrent Connections
    * 12,000 Average Concurrent Connections
    * Seasonal demand spikes with flash sales

* Application Instance Specifications:
    * Can serve 500 concurrent connections
    * 2 CPU
    * 1536 MB RAM
    * 5 GB Disk
    * Runs on Ubuntu Linux (Assume OS requirements are 1 CPU, 512 MB RAM, and 2 GB
      Disk)

* Virtualization Specifications
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
6. What are the total application resource requirements?
<br>
<br>
<br>
7. How many physical servers does Company ABC need to purchase for this project?
   How many server racks are required to fit this gear?
<br>
<br>
<br>
8. Which resource (if any) is the bottleneck when purchasing the physical
   servers? What would be the ideal specifications be for a physical server to
   ensure no resources are wasted?
<br>
<br>
<br>
9. How much power is required to run the servers? If Company ABC wants to have
   redundant power, how many power circuits do they need?
<br>
<br>
<br>
10. What is the total heat output of the servers (in BTU)? How many CRAC units
   are required to dissipate the heat?
<br>
<br>
<br>
