
Règles PFsense :  



1) Allow VLAN To DMZ

Firewall > Rules > DMZ

Ajoute une règle :

Source : 192.168.0.0/16

Destination : 192.168.200.0/24

Action : Pass

2) Allow DMZ to VLAN

Firewall > Rules > DMZ

Source : 192.168.200.0/24

Destination : 192.168.0.0/16

Action : Pass

3) Allow VYOS To pfSense

Firewall > Rules > OTP1VYOSLINK (vmbr23)

Source :  OTP1VYOSLINK net

Destination : any

Action : Pass
