## Wifi Training - Module 2

### Q1 : Brief about SplitMAC architecture and how it improves the AP's performance ?

Split MAC architecture refers to an architecture where APs are connected to WLC and the lower MAC functions such as broadcasting beacon frame, answering probe requests, MU-MIMO/OFDMA, encrypting data are done by the AP while the upper MAC functions such as QoS, load balancing, traffic shaping, RF management, Authentication are performed by the WLC. This offloads the upper MAC functions from the APs and hence the APs can work more effectively carrying out only the lower MAC tasks, effectively improving the network performance.

### Q2 : Describe about CAPWAP, explain the flow between AP and controller

CAPWAP refers to **Control and provisioning of wireless access points**. This is a protocol that is used for communication between APs and WLC.

The flow between AP and WLC is as follows:

- First IP address is assigned to AP by a DHCP server in the network, following the DORA process
- Then a discovery request is given by the AC to WLC and the WLC responds with a discovery response. This is the **AC discovery** step.
- Then a Join request is given by the AC to WLC and the WLC responds with a Join response. This is the **AP access control** step.
- This is followed by **configuration delivery** step, where configuration status request and response packets are exchanged, alongwith Change state event request and response.
- Then the CAPWAP tunnel is established.

### Q3 : Where this CAPWAP fits in OSI model, what are the two tunnels in CAPWAP and its purpose.

CAPWAP fits in **layer 4 (transport layer)** of the OSI model.

The two tunnels in CAPWAP are:

- **Control Tunnel** : For the control and management of the APs.
- **Data Tunnel** : For all the data that pass between the AP and WLC.

### Q4 : Whats the difference between Lightweight APs and Cloud-based APs

| **Lightweight APs**                             | **Cloud Based APs**                        |
| ----------------------------------------------- | ------------------------------------------ |
| WLCs are local                                  | WLCs are in the cloud                      |
| uses CAPWAP protocol and split-MAC architecture | CAPWAP tunneling is done over internet     |
| Ideal for large scale uniform networks          | Ideal for large scale distributed networks |

### Q5 : How the CAPWAP tunnel is maintained between AP and controller

The CAPWAP tunnel is maintained with the help of **KeepAlive** signals from the AP to the WLC. Also echo request is sent from the AP to the WLC to which the WLC responds to the AP with echo response.

### Q6 : Whats the difference between Sniffer and monitor mode, use case for each mode

**Sniffer Mode** : The AP does not offer BSS but instead acts as a device that captures packets passively and sends them to the controller for processing.

Use case : Packet capture for analysus

**Monitor Mode** : The AP does not offer BSS but instead collects information about rogue devices, and other information for analytics and sends them to WLC.

Use Case : RF monitoring and security

### Q7 : If WLC deployed in WAN, which AP mode is best for local network and how ?

If WLC is deployed in WAN, the Cloud Based WLC can be used and the APs can be configured in FlexConnect mode. This is advantageous as the APs behave as local APs by default and switch to autonomous mode when the connection to WLC is lost.

### Q8: What are challenges if deploying autonomous APs (more than 50) in large network like university
- If deploying autonomous APs in large networks, each AP must be managed individually as they are self contained and don't rely on WLC. 
- Each AP must have a dedicated management IP, all security parameters must be configured manually for each AP.
- If any update is to be rolled out, each AP must be updated manually.
- A seperate management VLAN is required to manage the APs

### Q9 : What happens on wireless client connected to Lightweight AP in local mode if WLC goes down.

- Existing connections drop immediately as the AP cannot authenticate clients.
- No new clients can connect to the AP as the authentication and session management is done by the WLC.
- The AP keeps broadcasting SSIDs but no data passes through as there is not CAPWAP tunnel.
- This can be prevented by implementing FlexConnect AP mode where the APs behave in autonomous mode when the connection to WLC is lost.
