# Guide d'installation de la VM G2-RouteurVyos

## Description
- **Nom GUI Proxmox :** G2-RouteurVyos  
- **Nom machine :** RouteurVyOS  
- **Type :** VM VyOS  
- **Fonction :** Routeur inter-VLAN  

---

## Prérequis
- Serveur Proxmox avec ressources allouées (RAM, CPU, stockage)
- ISO VyOS (dernière version stable) disponible dans la bibliothèque Proxmox ou via téléchargement
- Plan d’adressage réseau défini
- Accès à la console Proxmox

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface web Proxmox.
- Cliquez sur **Créer VM**.
- Configurez les paramètres :
  - **Nom :** G2-RouteurVyos
  - **VM ID :** 202 (ou autre disponible)
  - Sélectionnez l’ISO VyOS pour le démarrage.
  - Disque dur : 8 Go minimum.
  - RAM : 1 Go minimum.
  - CPU : 1 ou 2 vCPU selon besoin.
  - Configurez autant d’interfaces réseau que nécessaire pour les VLANs et le WAN.

### 2. Installation de VyOS
- Démarrez la VM et ouvrez la console via Proxmox.
- VyOS démarre sur son installateur en ligne de commande.
- Installer VyOS sur le disque avec la commande suivante :
  ```shell
  install image
