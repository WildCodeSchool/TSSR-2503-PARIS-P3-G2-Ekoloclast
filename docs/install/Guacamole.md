# Guide d'installation de la VM G2-Debian-Guacamole

## Description
- **Nom GUI Proxmox :** G2-Debian-Guacamole  
- **Nom machine :** DebianServ  
- **Type :** VM Debian Linux  
- **Fonction :** Serveur d’accès distant Guacamole (client HTML5 pour RDP, VNC, SSH)  

---

## Prérequis
- Serveur Proxmox opérationnel  
- ISO Debian (version stable recommandée, ex: Debian 11 Bullseye) disponible dans Proxmox  
- Accès root ou utilisateur avec droits sudo  
- Plan réseau avec IP statique ou DHCP configuré  
- Accès à la console Proxmox  

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface web Proxmox.  
- Cliquez sur **Créer VM**.  
- Paramétrez la VM :  
  - **Nom :** G2-Debian-Guacamole  
  - **VM ID :** 207 (ou autre libre)  
  - **ISO d’installation :** Debian stable (ex: debian-11.iso)  
  - **Disque dur :** Minimum 20 Go recommandé  
  - **RAM :** Minimum 2 Go (4 Go conseillé selon charge)  
  - **CPU :** 2 vCPU minimum  
  - **Réseau :** Interface réseau connectée au VLAN adéquat  

### 2. Installation de Debian
- Démarrez la VM et ouvrez la console Proxmox.  
- Suivez l’installation classique de Debian :  
  - Choix de la langue, du fuseau horaire  
  - Partitionnement (partition principale ext4 + swap)  
  - Installation des paquets de base  
  - Création d’un utilisateur sudo  
  - Configuration du réseau (statique ou DHCP)  

### 3. Installation de Guacamole

#### 3.1. Installation des dépendances
```bash
sudo apt update
sudo apt install -y build-essential libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin libossp-uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev tomcat9 tomcat9-admin tomcat9-common mysql-server mysql-client mysql-common mysql-server-core-8.0 mysql-client-core-8.0
