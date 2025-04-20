## Wifi Training - Module 3

### Q1 : What are the different 802.11 PHY layer standards ? Compare their characteristics.

**802.11b** : Wifi2, DSSS, bandwidth 20Mbps, max speed 11 Mbps
**802.11a** : Wifi3, OFDM, bandwidth 20Mhz, max speed 54 Mbps
**802.11g** : Wifi3, OFDM, DSSS (CCK) - for backward compatibility, bandwidth 20 Mhz, max speed 54 Mbps
**802.11n** : Wifi4, OFDM, MIMO, bandwidth 40 MHz, max speed 600 Mbps.
**802.11ac** : Wifi5, OFDM, MU-MIMO, 256QAM, bandwidth 160 Mhz, max speed 6.9 Gbps
**802.11ax** : Wifi6, OFDMA, max bandwidth 160Mhz, max speed 9.6 GBps
**802.11be** : Wifi7, OFDMA, 4096QAM, max bandwidth 320Mhz, max speed 46GBps.


### Q2 : What are DSSS and FHSS ? How do they work ?

DSSS stands for Direct Sequence Spread Spectrum and FHSS stands for Frequency Hopping Spread Spectrum. Both are techniques to convert a narrow-band signal to a wideband signal. 
FHSS works by constantly changing transmitting frequency along the entire bandwidth. 
DSSS works by doing a mathematical operation on the data to be send with a fixed bit sequence called chip which is agreed upon both the transmitter and reciever end.

### Q3 : How do modulation schemes work in the PHY layer ? Compare different modulation schemes and their performance across various Wi-Fi standards.

Modulation refers to the change in carrier signal in accordance to the message signal. In the PHY layer, digital modulation can be one of following:  
Amplitude Shift Keying - ASK  
Frequency Shift Keying - FSK  
Phase Shift Keying - PSK
QAM: Combines ASK and PSK
BPSK : Binary Phase Shift Keying
QPSK : Qudrature PSK
DBPSK : Differential BPSK
DQPSK : Differential QPSK

### Q4 : What is the significance of OFDM in WLAN? How does it improve performance ?

ODFM uses the principle of orthogonality, by selecting frequencies such that the  sinc functino side lobes are at null in the place where a main lobe is at its peak. It improves performance as now many narrow-band signals are transmitted across a wide-band without overlapping - by using orthogonally spaced overlapping subcarriers.

### Q5 : How are frequency bands divided for Wi-Fi ? Explain different bands and their channels.

The Wi-Fi bands are:

**2.4 GHz Band** : Has 14 channel - three non-overlapping channels. 70 MHz wide spectrum.

**5 GHz Band** : Has upto 23 non-overlapping channels. 500 MHz wide spectrum.

**6 GHz Band** : Has upto 59 channels. 1200 MHz wide spectrum.

### Q6 : What is the role of guard intervals in WLAN transmission ? How does a short guard interval improve efficiency ?

Guard interval refers to the time interval between subsequent symbols during transmission. A short guard interval refers more signal transmission in a shorter time as the time interval between the symbols are reduced. This results in higher efficiency but with the downside of reduced reliability.

### Q7 : describe the structure of an 802.11 PHY layer frame. What are its key components ?

The key components of an 802.11 PHY layer frame are:  
**PREAMBLE** : Contains alternating bits for synchronization  
**HEADER** : Contains information about the frame.  
**PSDU** : PLCP service data unit - the actual data/payload.  

### Q8 : What is the difference between OFDM and OFDMA ?

|**OFDM**|**OFDMA**|
|:---:|:---:|
| Orthogonal Frequency Division Multiplexing | Orthogonal Frequency Division Multiple Access |
| Modulation scheme | Multi-access method to share the same spectrum |
| all subcarriers are used by a single user at a time | different subcarriers are used by multiple users simultaneously |

### Q9 : What is the difference between MIMO and MU-MIMO ?

|**MIMO**|**MU-MIMO**|
|:---:|:---:|
| Multiple Input Multiple Output | Stands Multi User - Multiple Input Multiple Output |
| Improves throughput of a single user | Improves throughput of the network |
| Single device receives multiple data streams | Multiple devices receive multiple data streams |
| Channel usage of only one device at a time | Channel usage of multiple devices at a time |

### Q10 : What are PPDU, PLCP, and PMD in the PHY layer ?  
**PLCP** : Physical Layer Conversion Procedure - A PHY sublayer that is responsible for encapsulation of PSDU in PPDU. 
**PMD** : Physical Medium Dependent - A PHY sublayer that is responsible for transmitting and recieving data in bits on the physical level.
**PPDU** :  PLCP Protocol Data Unit - The frame transmitted over the PHY layer. It consists of a preamble for synchronizaion, header containing frame details and the payload PSDU (PLCP Service Data Unit)


### Q11 : What are the types of PPDU ? Explain the PPDU frame format across different wi-fi generations

**802.11b**

SYNC SFD SIGNAL SERVICE LENGTH CRC* PSDU 

**802.11a/g**

SFT LFT RATE LENGTH PARITY TAIL PSDU 
 

**802.11n**  

HT-SIG1 HT-STF HT-LTF HT-SIG2  SERVICE LENGTH TAIL CRC PSDU 


**802.11ac**

L-SFT L-LFT L-SIG VHT SIG-A1 VHT SIG-A2 VHT STF VHT LTF VHT SIG-B SERVICE LENGTH TAIL CRC PSDU

**802.11ax**

L-SFT L-LFT L-SIG HE SIG-A HE SIG-B HE STF HE LTF SERVICE LENGTH TAIL CRC PSDU

### Q12 : How is the data rate calculated ?

data rate = (num. sub-carriers * coded bits per sub-carrier * coding * num. spatial streams) / (OFDM symbol duration*GI duration)