# Projet : Mise en place de l'infrastructure réseau pour Ekoloclast

## Présentation du projet

### Description
Le projet consiste à mettre en place une nouvelle infrastructure réseau pour la société **Ekoloclast**, une start-up innovante qui cherche à révolutionner l'approche de l'écologie. Cette infrastructure vise à optimiser la gestion des utilisateurs, des services et des ressources au sein de l'entreprise, tout en répondant aux besoins croissants de sécurité, de partage de données et de communication interne.

### Objectifs finaux
Les objectifs finaux du projet sont :
1. **Mettre en place un réseau sécurisé** pour tous les utilisateurs de l'entreprise.
2. **Centraliser la gestion des utilisateurs et des ressources** via Active Directory.
3. **Implémenter un serveur de fichiers** pour centraliser les données.
4. **Assurer une gestion optimale des machines** via des VMs dédiées au serveur et aux clients.
5. **Mettre en place des services de messagerie, DNS et DHCP** pour la gestion interne.

## Introduction : Mise en contexte

### Contexte de l'entreprise
**Ekoloclast** est une start-up qui a récemment levé des fonds pour soutenir son expansion. L'entreprise est composée de 183 employés répartis dans 10 départements et offre une solution innovante en matière de produits et services écologiques. Le besoin d'une infrastructure réseau fiable et sécurisée est devenu essentiel pour soutenir les processus internes et répondre aux défis futurs, notamment une fusion/acquisition prévue.

### Objectifs du projet
Le projet a pour objectif de concevoir et de mettre en place une infrastructure réseau évolutive et sécurisée, qui pourra facilement évoluer avec la croissance de l'entreprise. Il s'agit également de faciliter la gestion des utilisateurs et des ressources tout en garantissant une communication efficace entre les différents départements.

## Par Sprint

### Semaine 1 : Planification, conception et création initiale
- **Objectifs :**
  1. **Fournir un plan schématique du futur réseau :**
     - Nom des matériels
     - Configuration IP
  2. **Fournir un plan d'adressage réseau complet cohérent :**
     - Configuration IP de LAN/VLAN
     - Configuration IP des matériels réseaux
  3. **Faire la liste des serveurs/matériels nécessaires à l'élaboration de la future infrastructure réseau :**
     - Serveurs nécessaires à l'élaboration de la future infrastructure réseau
     - Matériels nécessaires à l'élaboration de la future infrastructure réseau
  4. **Mettre en place une nomenclature de nom :**
     - Serveurs, ordinateurs, utilisateurs et groupes
  5. **Création de VMs :**
     - Serveur : configuration, OS, fonctions/roles
     - Client : configuration, OS, fonctions/roles
     - Automatiser la création des VMs avec un script (création d'un domaine, création d'un serveur backup)
  6. **Création d'un domaine Active Directory :**
     - Créer l'arborescence
     - Nom du domaine AD
     - Configuration des paramètres de domaine

- **Tâches réalisées :**
  - Planification des besoins matériels et logiciels.
  - Réalisation du schéma réseau prévisionnel avec les adresses IP et les rôles des serveurs.
  - Liste des serveurs et matériels nécessaires pour l’infrastructure réseau.
  - Mise en place de la nomenclature pour la gestion des ressources réseau (serveurs, machines et utilisateurs).
  - Création des VMs pour le serveur et les clients, configuration des rôles et des systèmes d'exploitation.
  - Mise en place d'un domaine Active Directory.

## Membres du groupe de projet et rôles par sprint

| Semaine | Scrum Master  | Product Owner  |
|---------|---------------|----------------|
| 1       | Stéphane      | Chahine        |
| 2       | Chahine       | Stéphane       |
| 3       | Stéphane      | Chahine        |
| 4       | Chahine       | Stéphane       |
| 6       | Stéphane      | Chahine        |
| 7       | Chahine       | Stéphane       |
| 8       | Stéphane      | Chahine        |
| 10      | Chahine       | Stéphane       |
| 11      | Stéphane      | Chahine        |
| 12      | Chahine       | Stéphane       |
| 13      | Stéphane      | Chahine        |
| 14      | Chahine       | Stéphane       |

## Informations techniques


### 1 Liste des Serveurs et Équipements

- **Routeur principal** : Connecte les VLANs entre eux et assure la sortie vers Internet.
- **Switch administrable** : Permet de gérer les VLANs et la communication entre les différents services.
- **Box FAI** : Connexion Internet pour l'ensemble du réseau.
- **Serveur AD/DNS/DHCP** : Service de gestion de domaine, résolution DNS, et distribution d'adresses IP.
- **Serveur de fichiers** : Serveur pour le stockage des fichiers partagés.
- **Serveur GitLab** : Hébergement des dépôts GitLab pour les équipes de développement.

### 2. Plan d'adressage IP / VLAN

- **Réseau principal** : `192.168.0.0/24`
- **Plage disponible** : `192.168.0.1` à `192.168.12.254`
- **Masque sous-réseau global** : `/24` divisé en sous-réseaux `/27`

### VLANs et sous-réseaux associés :

| VLAN  | Nom du service                | Sous-réseau         | Plage DHCP                  | Adresses statiques principales                             |
|-------|-------------------------------|----------------------|-----------------------------|-------------------------------------------------------------|
| 10    | Direction Générale            | 192.168.1.0/24       | 192.168.1.101 à .150        | .1 (Routeur), .10 (Poste DG), .20 (Imprimante DG)           |
| 20    | Ressources Humaines           | 192.168.2.0/24       | 192.168.2.101 à .150        | .1 (Routeur), .10 (Serveur RH), .20 (Imprimante RH)         |
| 30    | Direction Financière          | 192.168.3.0/24       | 192.168.3.101 à .150        | .1 (Routeur), .10 (Serveur Finances), .20 (Imprimante)      |
| 40    | Ventes / Commerciaux          | 192.168.4.0/24       | 192.168.4.101 à .200        | .1 (Routeur), .10 (Serveur Ventes), .20 (Imprimante Ventes) |
| 50    | Communication                 | 192.168.5.0/24       | 192.168.5.101 à .150        | .1 (Routeur), .10 (Serveur Com), .20 (Scanner Com)          |
| 60    | Marketing                     | 192.168.6.0/24       | 192.168.6.101 à .150        | .1 (Routeur), .10 (Serveur Marketing), .20 (Imprimante)     |
| 70    | Juridique                     | 192.168.7.0/24       | 192.168.7.101 à .150        | .1 (Routeur), .10 (Serveur Juridique)                       |
| 80    | Services Généraux             | 192.168.8.0/24       | 192.168.8.101 à .150        | .1 (Routeur), .10 (Scanner SG)                              |
| 90    | DSI                            | 192.168.9.0/24       | 192.168.9.101 à .200        | .1 (Routeur) .10 (SRV-AD), .11 (SRV-DHCP), .12 (SRV-DNS), .13 (SRV-FICHIERS), .14 (SRV-GITLAB), .15 (SRV-SAUVEGARDE), .17 (SRV-APP)|
| 91    | FSMO                          | 192.168.10.0/24      | 192.168.10.100 à .120       | .1 (Routeur), .10 (Schema Master), .11 (PDC Emulator), .12 (RID Master), .13 (Domain Naming Master), .14 (Infrastructure Master) |
| 100   | R&D                            | 192.168.11.0/24      | 192.168.11.100 à .150       | .1 (Routeur), .10 (Gitlab), .11 (Poste test)                |
| 999   | Administration réseau         | 192.168.12.0/24      | (Pas de DHCP)               | .1 (Routeur), .10 (Switch Admin), .11 (Box FAI)             |

| Interface pfSense | VLAN | Nom             | Adresse       | Rôle                      |
| ----------------- | ---- | --------------- | ------------- | ------------------------- |
| vmbr1.10          | 10   | DG              | 192.168.1.1   | Passerelle VLAN 10        |
| vmbr1.20          | 20   | RH              | 192.168.2.1   | Passerelle VLAN 20        |
| ...               | ...  | ...             | ...           | ...                       |
| vmbr1.90          | 90   | DSI             | 192.168.9.1   | Passerelle DSI            |
| vmbr1.999         | 999  | Admin Réseau    | 192.168.12.1  | Accès à pfSense (web/ssh) |
| vmbr0 (WAN)       | —    | Internet Public | 192.168.240.X | Accès à Internet (NAT)    |

| Source                  | Source réseau / VLAN                              | Ports / Protocoles     | Destination                  | Commentaire                                   |
|-------------------------|-------------------------------------------------|-----------------------|------------------------------|-----------------------------------------------|
| Postes utilisateurs     | VLAN utilisateurs (vmbr3,4....) et réseau lié (ex : vmbr3, OPT2) | UDP/TCP 53            | 192.168.9.12 (SRV-DNS)       | Permet la connexion au rôle DNS d'ADDS        |
| Postes utilisateurs     | VLAN utilisateurs (vmbr3,4....) et réseau lié (ex : vmbr3, OPT2) | TCP/UDP 88, 389, 445  | 192.168.9.10 (SRV-ADDS)      | Permet l'authentification et l'ajout au domaine ADDS |
| Postes utilisateurs     | VLAN utilisateurs (vmbr3,4....) et réseau lié (ex : vmbr3, OPT2) | TCP 445, TCP 139      | 192.168.9.13 (SRV-FICHIERS)  | Permet d'accéder aux dossiers partagés Windows |
| Postes utilisateurs     | VLAN utilisateurs (vmbr3,4....) et réseau lié (ex : vmbr3, OPT2) | TCP 25, 465, 587, 993 | 192.168.200.10 (Messagerie)  | Permet l'accès messagerie (SMTP, IMAPS) vers SRV-MESSAGERIE |
| SRV-MESSAGERIE          | DMZ - OTP1                                       | TCP 25, 465, 587      | 192.168.240.0/24             | Envoi mails externes                           |
| Postes utilisateurs     | VLAN utilisateurs (vmbr3,4....) et réseau lié (ex : vmbr3, OPT2) | TCP 80, TCP 443       | 192.168.200.11 (Web)         | Intranet et applis Web internes (gestion stock, tickets etc) |
| LAN                     | LAN (vmbr2, LAN)                                | ANY                   | ANY                          | Permet toutes les connexions en provenance du LAN (règle par défaut) |




### Remarques importantes :
- Chaque sous-réseau VLAN (/27) permet 30 hôtes, suffisant pour les équipes actuelles.
- Le VLAN 99 est réservé aux équipements réseau critiques non accessibles au reste du réseau.
- Le DHCP sera configuré pour éviter les conflits avec les adresses statiques (réservations et exclusions).

### 3. Liste des serveurs nécessaires

- Serveur ADDS (AD/DNS/DHCP) : gestion du domaine, distribution IP, résolution de noms
- Serveur de fichiers : stockage et partage de documents par service
- Serveur GitLab : hébergement de dépôts de code pour l’équipe R&D
- Serveur de sauvegarde : pour les sauvegardes planifiées de l’ensemble des serveurs
- Serveur de messagerie : envoi et réception des emails internes et externes
- Serveur web : hébergement du site web de l’entreprise
- Serveur applicatif : hébergement des applications métiers (intranet, CRM, etc.)
- Serveur DMZ : hébergement sécurisé pour les services exposés (web, mail)
- Serveur FSMO - Schema Master : gestion du schéma AD
- Serveur FSMO - Domain Naming Master : gestion des noms de domaine
- Serveur FSMO - RID Master : attribution des identifiants uniques
- Serveur FSMO - PDC Emulator : compatibilité avec anciens DC et horloge réseau
- Serveur FSMO - Infrastructure Master : gestion des références entre domaines

### 4. Liste des matériels réseau nécessaires

- 1x Routeur principal inter-VLAN
- 1x Switch administrable L3
- 1x Box FAI ou modem
- 1x Baie de brassage (selon taille)
- Câblage Ethernet Cat 6 ou supérieur
- Panneaux de brassage et connecteurs RJ45

### 5. Nomenclature des noms

![Schéma de l'architecture](Ressources/schema3.jpg)

### Serveurs et IP associées
- SRV-ADDS : 192.168.9.10
- SRV-FICHIERS : 192.168.9.13
- SRV-GITLAB : 192.168.9.14
- SRV-SAUVEGARDE : 192.168.9.15
- SRV-MESSAGERIE : 192.168.200.10
- SRV-WEB : 192.168.200.11
- SRV-APP : 192.168.9.17
- SRV-DMZ : 192.168.200.0
- SRV-FSMO-SCHEMA : 192.168.9.20
- SRV-FSMO-DOMAIN : 192.168.9.21
- SRV-FSMO-RID : 192.168.9.22
- SRV-FSMO-PDC : 192.168.9.23
- SRV-FSMO-INFRASTRUCTURE : 192.168.9.24
- SRV-CORE : 192.168.9.25 (Redondance SRV ADDS)

Serveurs additionnels pour objectifs hebdomadaires:

- SRV-GLPI : 192.168.9.26
- SRV-ZABBIX : 192.168.9.30
- UBUNTU-SYSLOG : 192.168.200.87
- SRV-FREEPBX : 192.168.9.41
- GUIpfSense : 192.168.200.208
- SRV-GUACAMOLE : 192.168.9.29

Passerelle : 	192.168.9.1
Passerelle serveurs DMZ : 192.168.200.1

DNS : 192.168.9.10

Accés internet pour les VM via 
device : vmbr0 
réseau 192.168.240.0/24 
passerelle :192.168.240.1

Clients/serveurs additionnels pour objectifs hebdomadaires:
- WIN-GPI : 192.168.9.31
- Client-OPENVPN : 192.168.9.42
- PC-Admin : 192.168.9.50

Adresse Webconfigurator pfSense : 192.168.9.254
Connexion pfSense-Vyos : 10.0.0.1 pour pfsense et 10.0.0.2 pour Vyos, carte vmbr23

### Ordinateurs clients

Exemple de configuration IP pour le département DG : 

Adresse IP : 192.168.1.101 (dans la plage du VLAN DG)

Masque : 255.255.255.0

Passerelle : 192.168.1.1 (interface VLAN 10 sur le routeur VyOS)

DNS : 192.168.9.10 (serveur ADDS)

- PC-DG : 192.168.1.101
- PC-RH : 192.168.2.101
- PC-DF : 192.168.3.101
- PC-VENTES : 192.168.4.101
- PC-COM : 192.168.5.101
- PC-MARKETING : 192.168.6.101
- PC-JURIDIQUE : 192.168.7.101
- PC-SG : 192.168.8.101
- PC-RD : 192.168.11.101

- G2-WinClient-GPO : 192.168.9.28

### Utilisateurs
- Jean Lefèvre – CEO
- Sophie Moreau – Responsable RH
- Claire Dubois – Directrice Financière
- Thomas Girard – Responsable des Ventes
- Laura Meunier – Chargée de Communication
- Julie Fontaine – Responsable Marketing
- Manon Perez – Juriste
- Fatou Diallo – Responsable Services Généraux
- Antoine Leclerc – Administrateur Systèmes & Réseaux
- Inès Boudra – Administratrice Active Directory
- Nathan Caron – Développeur R&D
- Damien Rousseau – Ingénieur Réseau

### Groupes
- GRP-DEP-DG
- GRP-DEP-RH
- GRP-DEP-DF
- GRP-DEP-COM
- GRP-DEP-VENTE
- GRP-DEP-MARKETING
- GRP-DEP-JUR
- GRP-DEP-SG
- GRP-DEP-DSI
- GRP-DEP-R&D

---


## Choix techniques

### OS utilisé
- **Serveurs** : Windows Server 2022
- **Clients** : Windows 10 pour les postes de travail des utilisateurs.
- **Hyperviseur** : Proxmox pour la gestion des VMs et l'hébergement des serveurs et clients virtuels.

### Version de l'OS
- **Windows Server** : 2022
- **Proxmox** : Version la plus récente au moment de la mise en place du projet.

### Matériel
- **Serveurs** : Des serveurs virtuels créés sur Proxmox avec 2 CPU et 8 Go de RAM minimum pour chaque serveur.
- **Clients** : Des VMs avec 2 Go de RAM et 2 CPU pour simuler les postes de travail.

## Difficultés rencontrées

1. **Problème de compatibilité entre les versions des OS et Proxmox** : Lors de la configuration des VMs sous Proxmox, certaines versions des systèmes d’exploitation étaient incompatibles avec les paramètres par défaut de l'hyperviseur.
2. **Difficultés avec la configuration du DHCP et du DNS** : Il a été difficile de configurer correctement les services DHCP et DNS en raison de conflits d'adresses IP et de mauvaises configurations initiales.
3. **Problèmes de connectivité réseau entre VMs** : Des problèmes de communication entre les machines virtuelles ont été rencontrés, liés à des configurations réseau incorrectes dans Proxmox.

## Solutions trouvées

1. **Mise à jour des versions de Proxmox et des OS** : Après avoir identifié les versions incompatibles, nous avons mis à jour Proxmox et les systèmes d'exploitation des VMs pour garantir la compatibilité.
2. **Réconfiguration du serveur DHCP** : La configuration du serveur DHCP a été revue pour éviter les conflits d'adresses IP. Des réservations d'adresses IP ont été mises en place pour les VMs critiques.
3. **Reconfiguration du réseau de Proxmox** : Après des tests approfondis, nous avons modifié la configuration des VLANs dans Proxmox et vérifié les paramètres de routage pour résoudre les problèmes de connectivité.

## Améliorations possibles

1. **Optimisation de la gestion des ressources des VMs** : Bien que les performances soient satisfaisantes, une gestion plus fine des ressources (CPU/RAM) pourrait améliorer l'efficacité, notamment pour les serveurs.
2. **Mise en place de la gestion des sauvegardes** : Actuellement, il n'y a pas de solution de sauvegarde automatique pour les données des serveurs. Il serait utile d'ajouter un système de sauvegarde des VMs et des données critiques.
3. **Mise en place d'un système de gestion des accès plus avancé** : Bien que l'Active Directory gère les utilisateurs, l'intégration de solutions supplémentaires comme **RADIUS** ou un VPN pourrait renforcer la sécurité du réseau, surtout avec la mobilité des équipes commerciales.
4. **Migration vers un environnement hybride ou multi-cloud** : Avec la future fusion/acquisition, il serait pertinent d'envisager une extension de l'infrastructure vers un environnement hybride ou multi-cloud pour améliorer la flexibilité et la résilience du réseau.

---
