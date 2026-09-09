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

    - **Subnet Requirements for Finance Dept., Human Resources Dept., Sales Dept., Marketing Dept., IT Dept. and Operation Dept. with 50% growth. It is also good practice to reserve additional address space for future departments, guest networks, management networks, and the centralized data center.**

        |Department|Current Hosts|50% Growth|Planned Hosts|
        |------|-------|------|-------|
        |Finance|50|25|75|
        |Human Resources|30|15|45|
        |Sales|70|35|105|
        |Marketing|40|20|60|
        |IT|100|50|150|
        |Operations|80|40|120|

        The subnet sizes should be selected based on the planned hosts, not just the current number.

2. **Allocate IP Addresses: Allocate IP addresses to each subnet. Considering the number of hosts required for each department, be mindful of addressing efficiency.**

    - **Subnets:**
        - Finance: 50 hosts
        - Human Resources: 30 hosts
        - Sales: 70 hosts
        - Marketing: 40 hosts
        - IT: 100 hosts
        - Operations: 80 hosts
    - Total Subnets Required: 6

    - **IP Address Allocation**: A private Class A network such as 10.0.0.0/8 provides plenty of room for future expansion.

        **For this organization, i will use 10.10.0.0/16 as the organization's internal address space.**

        **The subnets can then be allocated using VLSM (Variable Length Subnet Masking). VLSM allows different departments to receive subnet sizes appropriate to their needs instead of giving every department the same-sized subnet.**

    - **Proposed Subnetting Plan**

        |Department|Network Address|CIDR|Subnet Mask|Usable Hosts|Planned Hosts|
        |-----|-----|-----|-----|------|----|
        |IT|10.10.0.0|/24|255.255.255.0|254|150|
        |Operations|10.10.1.0|/25|255.255.255.128|126|120|
        |Sales|10.10.2.0|/25|255.255.255.128|126|105|
        |Finance|10.10.3.0|/25|255.255.255.128|126|75|
        |Marketing|10.10.4.0|/26|255.255.255.192|62|60|
        |Human Resources|10.10.5.0|/26|255.255.255.192|62|45|

        This allocation leaves plenty of unused space in 10.10.0.0/16 for future networks.

3. **Subnet Masking: Choose appropriate subnet masks for each subnet for each department. Make sure you understand how subnet masks affect the number of available hosts and subnets.**

    - **The subnet mask determines how many IP addresses are available in each subnet.**

        /24 → 256 total addresses → 254 usable hosts
        /25 → 128 total addresses → 126 usable hosts
        /26 → 64 total addresses → 62 usable hosts

    - **Two addresses in every subnet are normally reserved:**

        Network address
        Broadcast address

        For example, the IT subnet is:

            10.10.0.0/24

        Its range is:

        Network: 10.10.0.0
        Usable: 10.10.0.1 – 10.10.0.254
        Broadcast: 10.10.0.255

4. **Documentation: Create documentation that outlines the subnetting plan. Include information about the IP address ranges you choose, subnet masks, and the purpose of each subnet.**

    - **Purpose for each departments:**

      - **Finance**: Financial transactions and accounting systems.
      - **Human Resources**: Employee data and payroll systems.
      - **Sales**: Customer relationship management (CRM) and sales data.
      - **Marketing**: Marketing campaigns and analytics.
      - **IT**: Network infrastructure and servers.
      - **Operations**: Production and supply chain management.

    |Department|IP Range|Purpose|
    |----------|--------|-------|
    |IT|10.10.0.0/24|Network infrastructure, administrators and IT systems|
    |Operations|10.10.1.0/25|Production and supply-chain management|
    |Sales|10.10.2.0/25|CRM and sales applications|
    |Finance|10.10.3.0/25|Financial transactions and accounting|
    |Marketing|10.10.4.0/26|Marketing campaigns and analytics|
    |Human Resources|10.10.5.0/26|Employee records and payroll systems|

    **Data Center**

    Because the organization has a centralized data center, I would not put the servers inside the IT departmental subnet. A separate server subnet provides better security and makes firewall policies easier to manage.

    For example:

    Data Center:

        10.10.10.0/24

    This subnet could contain:

      - Web servers
      - Database servers
      - Application servers
      - DNS/DHCP servers
      - Monitoring systems
      - Backup servers

    This gives the network administrator the ability to control which departments can access specific servers.

5. **Troubleshooting Scenarios:**

    - **Connectivity Issues:**
      - Check routing tables for correct subnet routes.
      - Verify firewall rules for inter-subnet communication.
    - **IP Conflicts:**
      - Use DHCP server logs to identify conflicting IP addresses.
      - Manually assign IP addresses to resolve conflicts.
    - **Overlapping:**
      - Ensure each subnet has a unique IP address range.
      - Adjust subnet masks to avoid overlapping ranges.

    - **Connectivity Issues**

        If Finance cannot communicate with a server:

      - Check the device's IP address and subnet mask.
      - Check the default gateway.
      - Check the routing table.
      - Test connectivity using ping.
      - Check VLAN configuration.
      - Check firewall rules.
      - Verify that the server is listening on the required port.

    For example:

        ip addr
        ip route
        ping 10.10.10.10

    - **IP Address Conflicts**

        If two devices have the same IP address:

      - Check DHCP server logs.
      - Identify the conflicting devices.
      - Check whether one device has a manually configured address.
      - Change the conflicting static IP or create a DHCP reservation.
      - Restart/reconnect the affected device.

    - **Overlapping Subnets**

        Overlapping networks can cause routing problems.

        For example, these would be problematic:

            10.10.1.0/24
            10.10.1.128/25

        The second subnet exists inside the first subnet.

        The proposed design avoids this by giving each department a separate, non-overlapping network range.

6. **Future Growth:**

    - **Expand Subnets:**
      - Increase subnet sizes by adjusting subnet masks.
      - Add new subnets for additional departments or teams.
    - **Modify Documentation:**
      - Update IP address ranges and subnet masks accordingly.
      - Keep track of changes for future reference.

    - **Future Growth**

        The design deliberately leaves significant unused space within 10.10.0.0/16.

        For example, future networks could include:

            10.10.6.0/24    Future Department
            10.10.7.0/24    Future Department
            10.10.8.0/24    Guest Network
            10.10.9.0/24    Network Management
            10.10.10.0/24   Data Center
            10.10.11.0/24   Backup/Storage

        If a department eventually outgrows its subnet, its subnet can be redesigned, although changing a subnet mask is not always as simple as just changing the mask because the new address range must not overlap other networks.

7. **Optimization:**

    - **Efficient Routing:**
      - Implement routing protocols to optimize traffic between subnets.
      - Use VLANs to segment traffic within departments.
    - **IP Address Use:**
      - Implement DHCP for dynamic IP address assignment.
      - Reserve static IP addresses for critical devices and servers.

    This subnetting plan efficiently allocates IP addresses for the organization's departments while providing scalability, logical separation, and a framework for troubleshooting and future growth.

    - **Optimization**

        The network can be optimized by:

      - Using VLSM to avoid wasting IP addresses.
      - Using VLANs to logically separate departments.
      - Using DHCP for normal client devices.
      - Reserving static IP addresses for servers, routers, switches and other critical infrastructure.
      - Using inter-VLAN routing for controlled communication between departments.
      - Applying firewall/ACL rules to restrict sensitive departmental traffic.
      - Keeping the data center on a separate subnet.
      - Maintaining accurate network documentation.
      - Reserving unused address space for future departments.

    **Final Recommendation**

    The proposed design uses 10.10.0.0/16 with VLSM and departmental VLANs. The largest departments receive larger subnets, while smaller departments receive smaller ones. This provides enough capacity for the required 50% five-year growth while leaving substantial address space for additional departments and network services.

        10.10.0.0/16
        │
        ├── VLAN 10  Finance     10.10.3.0/25
        ├── VLAN 20  HR          10.10.5.0/26
        ├── VLAN 30  Sales       10.10.2.0/25
        ├── VLAN 40  Marketing   10.10.4.0/26
        ├── VLAN 50  IT          10.10.0.0/24
        ├── VLAN 60  Operations  10.10.1.0/25
        └── VLAN 100 Data Center 10.10.10.0/24
