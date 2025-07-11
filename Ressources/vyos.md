pfSense → pInterfaces VLAN are-feu principal, passerelle vers Internet, NAT

VyOS →  routeur d’interconnexion interne entre les VLANs et le serveur, tout en bloquant la communication inter-VLAN.

NE PAS UTILISER LE VLAN TAG 1

# Pour connecter VYOS à pFsense pour avoir internet par exemple :

configure
set protocols static route 0.0.0.0/0 next-hop IP_PFSENSE
commit
save

# Pour avoir le DNS (ping google.com) : 

set system name-server 8.8.8.8


## Commandes de configuration

Création Interfaces VLAN - eth0 = VLAN-SRV = vmbr22 :


# VLAN 1 - DG
set interfaces ethernet eth0 vif 2 address 192.168.2.1/24

# VLAN 2 - RH
set interfaces ethernet eth0 vif 3 address 192.168.3.1/24

# VLAN 9 Serveurs
set interfaces ethernet eth0 vif 9 address 192.168.9.1/24

set firewall name VLAN2-IN default-action drop

# Autoriser RH vers RH (192.168.2.0/24)
set firewall name VLAN2-IN rule 10 action accept
set firewall name VLAN2-IN rule 10 source address 192.168.2.0/24
set firewall name VLAN2-IN rule 10 destination address 192.168.2.0/24
set firewall name VLAN2-IN rule 10 description "Allow RH to RH"

# Autoriser RH vers tout le réseau serveur (192.168.9.0/24)
set firewall name VLAN2-IN rule 20 action accept
set firewall name VLAN2-IN rule 20 source address 192.168.2.0/24
set firewall name VLAN2-IN rule 20 destination address 192.168.9.0/24
set firewall name VLAN2-IN rule 20 description "Allow RH to Servers"

set interfaces ethernet eth0 vif 2 firewall in name VLAN2-IN


set firewall name VLAN3-IN default-action drop

# Autoriser DG vers DG (192.168.3.0/24)
set firewall name VLAN3-IN rule 10 action accept
set firewall name VLAN3-IN rule 10 source address 192.168.3.0/24
set firewall name VLAN3-IN rule 10 destination address 192.168.3.0/24
set firewall name VLAN3-IN rule 10 description "Allow DG to DG"

# Autoriser RH vers tout le réseau serveur (192.168.9.0/24)
set firewall name VLAN3-IN rule 20 action accept
set firewall name VLAN3-IN rule 20 source address 192.168.3.0/24
set firewall name VLAN3-IN rule 20 destination address 192.168.9.0/24
set firewall name VLAN3-IN rule 20 description "Allow DG to Servers"

set interfaces ethernet eth0 vif 3 firewall in name VLAN3-IN


#Bloquer l'accès aux autres LAN
set firewall name VLAN3-IN rule 20 action drop
set firewall name VLAN3-IN rule 20 source address 192.168.3.0/24
set firewall name VLAN3-IN rule 20 destination address 192.168.0.0/16
set firewall name VLAN3-IN rule 20 description "Block access to other 192.168 networks"

# Permettre communication du serveur vers VLAN

set firewall name VLAN9-IN default-action drop
set firewall name VLAN9-IN rule 10 action accept
set firewall name VLAN9-IN rule 10 source address 192.168.1.0/24
set firewall name VLAN9-IN rule 20 action accept
set firewall name VLAN9-IN rule 20 source address 192.168.2.0/24

set interfaces ethernet eth0 vif 9 firewall in name VLAN9-IN


# NATer pour avoir Internet sur les clients

set nat source rule 100 outbound-interface eth1
set nat source rule 100 source address 192.168.0.0/16
set nat source rule 100 translation address masquerade


# Autoriser pings des clients à Internet

set firewall name VLAN2-IN rule 60 action accept
set firewall name VLAN2-IN rule 60 source address 192.168.2.0/24
set firewall name VLAN2-IN rule 60 protocol icmp
set firewall name VLAN2-IN rule 60 description "Allow ping to Internet"

commit
save









Notes annexes :



1️⃣ La VM DG envoie un paquet IP destiné à 192.168.9.10 (le serveur ADDS).
→ Elle met ce paquet dans une trame Ethernet avec un tag VLAN 1 (défini dans Proxmox avec le VLAN Tag = 1).

2️⃣ Cette trame est transmise au bridge Proxmox vmbr22, qui joue le rôle de switch.

3️⃣ Le bridge regarde les ports (les VMs connectées) :
→ Il ne l’envoie qu’à la VM VyOS, car elle est la seule à écouter tous les VLAN (elle n'a pas de tag dans Proxmox et utilise eth0 vif X pour lire les VLAN directement).

4️⃣ VyOS reçoit cette trame sur son interface eth0, plus précisément sur eth0 vif 1 (parce que c’est une trame VLAN 1).

5️⃣ VyOS consulte ses règles :
→ Le paquet vient de 192.168.1.X (DG) et est destiné à 192.168.9.10 (Serveur).
→ ✅ Il est autorisé car la règle firewall sur VLAN1-IN le permet vers VLAN9.

6️⃣ VyOS retransmet le paquet, mais cette fois avec un tag VLAN 9, via eth0 vif 9.

7️⃣ Le bridge Proxmox reçoit la trame VLAN 9, et la redirige uniquement vers la VM Serveur (ADDS) qui a le VLAN Tag 9 configuré dans Proxmox.

8️⃣ Le serveur ADDS reçoit le paquet.




Changer nom passerelle 192.168.240.1

PASSAGE DE TITRE pfsense glpi captures


vmbr23 pour lier vyos à pfsense

mettre drop en haut dans les règles
