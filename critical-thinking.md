# CRITICAL THINKING: Subnetting Plan for a Growing Organization

## You are a network administrator tasked with designing a subnetting plan for a growing organization with six departments for the start. You want to efficiently allocate IP addresses and subnets while ensuring that each department is logically separated

1. **Identify Subnet Requirements: Determine how many subnets you need based on the organization's departments, future growth, and network topology. Ensure that you have enough subnets to accommodate these requirements.**

    - Departments:
        - Finance
        - Human Resources
        - Sales
        - Marketing
        - IT
        - Operations
    - Future Growth:
       - Plan for at least 50% growth in each department over the next five years.
    - Network Topology:
        - Centralized data center for servers.
        - Each department has its own floor in the office building.

        **As the network administrator, I would design the network so that each department has its own subnet. This will make the network easier to manage, improve security, and allow the organization to grow without redesigning the whole network.**

    - **Identifying the Subnet Requirements**: The organization currently has six departments:

      - Finance
      - Human Resources
      - Sales
      - Marketing
      - IT
      - Operations

    Since the organization expects 50% growth in each department over the next five years, I need to plan for more users than the current number.

    |Department|Current Hosts|50% Growth|Planned Hosts|
    |--------|--------|-------|-------|
    |Finance|50|25|75|
    |Human Resources|30|15|45|
    |Sales|70|35|105|
    |Marketing|40|20|60|
    |IT|100|50|150|
    |Operations|80|40|120|

    **I would therefore create at least six departmental subnets. I would also keep some additional address space available for future departments, guest networks, management devices, and the data center.**

2. **Allocate IP Addresses: Allocate IP addresses to each subnet. Considering the number of hosts required for each department, be mindful of addressing efficiency.**

    - **Subnets:**
        - Finance: 50 hosts
        - Human Resources: 30 hosts
        - Sales: 70 hosts
        - Marketing: 40 hosts
        - IT: 100 hosts
        - Operations: 80 hosts
    - Total Subnets Required: 6

    **IP Address Allocation: For the organization, I would use the private network 10.10.0.0/16. This provides a large amount of address space for future expansion.**

    **I would use VLSM so that each department gets a subnet appropriate for its size.**

    - **Proposed Subnetting Plan**

        |Department|Network Address|Subnet Mask|Usable Hosts|
        |-----|-----|-----|------|
        |IT|10.10.0.0/24|255.255.255.0|254|
        |Operations|10.10.1.0/25|255.255.255.128|126|
        |Sales|10.10.2.0/25|255.255.255.128|126|
        |Finance|10.10.3.0/25|255.255.255.128|126|
        |Marketing|10.10.4.0/26|255.255.255.192|62|
        |Human Resources|10.10.5.0/26|255.255.255.192|62|

        **I chose these subnet sizes because they can accommodate the expected number of users after the 50% growth.**

3. **Subnet Masking: Choose appropriate subnet masks for each subnet for each department. Make sure you understand how subnet masks affect the number of available hosts and subnets.**

    - **Subnet Masking:** Subnet masks determine how many IP addresses are available in each subnet.

        For example:

        /24 provides 254 usable host addresses.
        /25 provides 126 usable host addresses.
        /26 provides 62 usable host addresses.

        For example, the IT subnet would be:

        **Network:** 10.10.0.0/24
        **Usable range:** 10.10.0.1 – 10.10.0.254
        **Broadcast:** 10.10.0.255

        Using different subnet masks is more efficient than giving every department the same-size subnet.

4. **Documentation: Create documentation that outlines the subnetting plan. Include information about the IP address ranges you choose, subnet masks, and the purpose of each subnet.**

    **Network Documentation:** I would document the purpose of each subnet so that it is easy to understand and troubleshoot later.

    |Department|Network|Purpose|
    |----------|--------|-------|
    |Finance|10.10.3.0/25|Financial transactions and accounting|
    |HR|10.10.5.0/26|Employee records and payroll|
    |Sales|10.10.2.0/25|CRM and sales information|
    |Marketing|10.10.4.0/26|Marketing campaigns and analytics|
    |IT|10.10.0.0/24|IT infrastructure and administration|
    |Operations|10.10.1.0/25|Production and supply-chain systems|

    Since the organization has a centralized data center, I would also create a separate subnet for the servers, for example:

    **Data Center: 10.10.10.0/24**

    Keeping the servers separate from the departments would make it easier to control access to important systems.

5. **Troubleshooting Scenarios:**

    - **Connectivity Issues:**
      - If there is connectivity issues, i will check routing tables for correct subnet routes.
      - Verify firewall rules for inter-subnet communication.
    - **IP Conflicts:**
      - If there is IP conflicts, i will Use DHCP server logs to identify conflicting IP addresses.
      - Manually assign IP addresses to resolve conflicts.
    - **Overlapping:**
      - If there is overlapping issues, i will Ensure each subnet has a unique IP address range.
      - Adjust subnet masks to avoid overlapping ranges.

    - **Troubleshooting**: If users cannot connect to another department or to a server, I would first check their IP address, subnet mask, and default gateway. I would then check the routing table and firewall rules.

        For example, I could use:

            ip addr
            ip route
            ping 10.10.10.10

        For IP conflicts, I would check the DHCP server logs to identify which devices are using the same address. I could then change a manually assigned address or create a DHCP reservation.

        I would also make sure that no two subnets overlap. Each subnet must have its own unique IP range.

6. **Future Growth:**

    - **Expand Subnets:**
      - Increase subnet sizes by adjusting subnet masks.
      - Add new subnets for additional departments or teams.
    - **Modify Documentation:**
      - Update IP address ranges and subnet masks accordingly.
      - Keep track of changes for future reference.

    - **Future Growth**: I have deliberately chosen 10.10.0.0/16 because it gives the organization plenty of room to expand.

        If another department is created in the future, I can allocate another subnet, for example:

            10.10.6.0/24
            10.10.7.0/24
            10.10.8.0/24

        I would also update the network documentation whenever an IP range, subnet, VLAN, or device is added or changed.

7. **Optimization:**

    - **Efficient Routing:**
      - Implement routing protocols to optimize traffic between subnets.
      - Use VLANs to segment traffic within departments.
    - **IP Address Use:**
      - Implement DHCP for dynamic IP address assignment.
      - Reserve static IP addresses for critical devices and servers.

        This subnetting plan efficiently allocates IP addresses for the organization's departments while providing scalability, logical separation, and a framework for troubleshooting and future growth.

    - **Optimization**: To improve the network, I would use VLANs to separate the departments logically. Each department could have its own VLAN, while the data center would have a separate VLAN.

        I would use DHCP for normal employee computers and reserve static IP addresses for important devices such as servers, routers, and switches.

        I would also use firewall rules or access control lists to control communication between departments. For example, Finance and HR may need access to certain servers but should not automatically have access to every other department.

        **Conclusion**

        My subnetting plan uses 10.10.0.0/16 and VLSM to provide each department with enough addresses for its current needs and the expected 50% growth. Separating the departments using subnets and VLANs will make the network more secure and easier to manage. The remaining address space can also be used when the organization grows or creates new departments.
