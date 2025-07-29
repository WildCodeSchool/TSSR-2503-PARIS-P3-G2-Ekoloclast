# Guide d'installation de la VM G2-UbuntuServer-bareos

## Description
- **Nom GUI Proxmox :** G2-UbuntuServer-bareos  
- **Nom machine :** UbuntuServer  
- **Type :** VM Ubuntu Server  
- **Fonction :** Serveur de sauvegarde Bareos  

---

## Prérequis
- Serveur Proxmox opérationnel avec ressources disponibles (CPU, RAM, stockage)
- ISO Ubuntu Server (version stable recommandée, ex: 22.04 LTS) disponible sur le stockage Proxmox
- Réseau configuré selon l’architecture (bridge ou VLAN)
- Accès Internet ou dépôt local Ubuntu pour les mises à jour et paquets

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface web Proxmox.
- Cliquez sur **Créer VM**.
- Paramétrez la VM :
  - **Node :** sélectionner le serveur Proxmox approprié.
  - **VM ID :** 198 (ou ID libre disponible)
  - **Nom :** G2-UbuntuServer-bareos
- Sélectionnez l’ISO Ubuntu Server.
- Configurez le disque dur (minimum 40 Go recommandé).
- Allouez la RAM (4 Go recommandé).
- Configurez les CPUs (2 vCPUs recommandé).
- Configurez la carte réseau selon le VLAN ou bridge défini pour le serveur.

### 2. Installation d’Ubuntu Server
- Démarrez la VM et connectez-vous à la console Proxmox.
- Suivez la procédure d’installation standard d’Ubuntu Server.
- Configurez le nom de la machine : `UbuntuServer`.
- Configurez un utilisateur administrateur avec mot de passe sécurisé.
- Configurez la connexion réseau (DHCP ou IP statique selon plan d’adressage).
- Installez OpenSSH pour accès distant.
- Finalisez l’installation et redémarrez la VM.

### 3. Installation de Bareos
- Connectez-vous via SSH à la VM UbuntuServer.
- Mettez à jour la liste des paquets :
  ```bash
  sudo apt update && sudo apt upgrade -y
