## Guide d'installation – pfSense (G2-Pfsense)

**Nom Proxmox** : `G2-Pfsense`
**Nom machine** : `pfSense`
**Rôle** : Pare-feu, NAT, interconnexion VLAN, portail captif, DHCP relai, sécurité réseau

---

### 1. Création de la VM sous Proxmox

**ID Proxmox** : `192`
**Type** : Appliance BSD – pfSense 2.7.x ou supérieur

#### a) Paramètres Proxmox :

* Nom : `G2-Pfsense`
* OS : Other / Unknown
* RAM : 2048 Mo (minimum)
* CPU : 2 vCPU
* Disque : 8 Go (VirtIO ou SCSI recommandé)
* BIOS : SeaBIOS
* Machine : i440fx
* Réseau :

  * `vmbr0` (WAN, tag VLAN si besoin)
  * `vmbr1` (LAN – interconnexion vers VLAN internes, en NAT ou bridge)

#### b) ISO :

* Télécharger l’ISO depuis : [https://www.pfsense.org/download/](https://www.pfsense.org/download/)
* Version AMD64, installation Live CD VGA, architecture compatible KVM

---

### 2. Installation de pfSense

1. Démarrer sur l’ISO
2. Choisir « Install pfSense »
3. Mode partition : Auto (UFS recommended)
4. Accepter les paramètres par défaut
5. Redémarrer une fois l’installation terminée

---

### 3. Configuration initiale

#### a) Affectation des interfaces :

```
WAN  -> vtnet0 (ou ens18)
LAN  -> vtnet1 (ou ens19)
```

**Note** : les noms d’interfaces dépendent de la version de Proxmox et du type de carte réseau choisie.

#### b) Adresse IP statique LAN

* Exemple : 192.168.99.1/24
* Permet l'accès à l'interface web

---

### 4. Accès à l'interface Web

Depuis une autre machine sur le même réseau LAN :

* URL : `https://192.168.99.1`
* Identifiants par défaut :

  * **Utilisateur** : `admin`
  * **Mot de passe** : `pfsense`

Lancer l’assistant (Setup Wizard) pour finaliser :

* Hostname, domaine local
* IP LAN/WAN si non définies
* DNS, accès internet

---

### 5. Configuration minimale recommandée

* Configurer accès SSH (System > Advanced)
* Changer mot de passe admin
* Mettre à jour pfSense (System > Update)
* Créer un utilisateur local non-root

---

### 6. Fonctionnalités clés à activer

* NAT / Firewall rules pour les VLANs
* Relais DHCP si serveur DHCP central
* Portail captif (Captive Portal)
* Redirection de ports (port forwarding)
* Interfaces VLAN (avec `assign VLAN`) si utilisé

---

### 7. Sauvegarde / snapshot

* Sauvegarde manuelle via WebGUI (`Diagnostics > Backup & Restore`)
* Exporter fichier `.xml`
* Snapshot Proxmox post-installation stable

---

### 8. Problèmes fréquents

* Interface LAN inaccessible : vérifier IP / câblage virtuel
* Connexion WAN inactive : corriger VLAN ou règles NAT
* Mémoriser l’adresse LAN d’accès Web : sinon reset nécessaire via console

---
