# Guide d'installation de la VM G2-Ser-Zabbix

## Description
- **Nom GUI Proxmox :** G2-Ser-Zabbix  
- **Nom machine :** ServerZabbix  
- **Type :** VM Ubuntu Server  
- **Fonction :** Serveur de supervision Zabbix  

---

## Prérequis
- Serveur Proxmox avec ressources suffisantes (CPU, RAM, stockage)
- ISO Ubuntu Server (version stable recommandée, ex: 22.04 LTS) disponible
- Réseau configuré selon l’architecture (bridge ou VLAN)
- Accès Internet pour récupération des paquets

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface web Proxmox.
- Cliquez sur **Créer VM**.
- Paramétrez la VM :
  - **Node :** sélectionner le serveur Proxmox approprié.
  - **VM ID :** 199 (ou ID libre disponible)
  - **Nom :** G2-Ser-Zabbix
- Sélectionnez l’ISO Ubuntu Server.
- Configurez le disque dur (minimum 40 Go recommandé).
- Allouez la RAM (4 Go recommandé).
- Configurez les CPUs (2 vCPUs recommandé).
- Configurez la carte réseau selon le VLAN ou bridge défini pour la supervision.

### 2. Installation d’Ubuntu Server
- Démarrez la VM et accédez à la console Proxmox.
- Suivez la procédure d’installation standard d’Ubuntu Server.
- Configurez le nom de la machine : `ServerZabbix`.
- Créez un utilisateur administrateur avec mot de passe sécurisé.
- Configurez la connexion réseau (DHCP ou IP statique selon plan).
- Installez OpenSSH pour accès distant.
- Finalisez l’installation et redémarrez la VM.

### 3. Installation de Zabbix
- Connectez-vous en SSH sur `ServerZabbix`.
- Mettez à jour les paquets :
  ```bash
  sudo apt update && sudo apt upgrade -y
