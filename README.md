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

| Semaine | Scrum Master  | Product Owner  | Développeur  |
|---------|---------------|----------------|--------------|
| 1       | Stéphane      | Chahine        | Mohamed      |
| 2       | Chahine       | Mohamed        | Stéphane     |
| 3       | Mohamed       | Stéphane       | Chahine      |
| 4       | Chahine       | Mohamed        | Stéphane     |
| 6       | Stéphane      | Chahine        | Mohamed      |
| 7       | Mohamed       | Stéphane       | Chahine      |
| 8       | Chahine       | Mohamed        | Stéphane     |
| 10      | Stéphane      | Chahine        | Mohamed      |
| 11      | Mohamed       | Stéphane       | Chahine      |
| 12      | Chahine       | Mohamed        | Stéphane     |
| 13      | Mohamed       | Chahine        | Stéphane     |
| 14      | Chahine       | Stéphane       | Mohamed      |

## Choix techniques

### OS utilisé
- **Serveurs** : Windows Server 2022 pour le serveur Active Directory, DNS, DHCP et le serveur de fichiers.
- **Clients** : Windows 10 pour les postes de travail des utilisateurs.
- **Hyperviseur** : Proxmox pour la gestion des VMs et l'hébergement des serveurs et clients virtuels.

### Version de l'OS
- **Windows Server** : 2022
- **Ubuntu Server** : 20.04 (pour certaines applications spécifiques comme Gitlab)
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
