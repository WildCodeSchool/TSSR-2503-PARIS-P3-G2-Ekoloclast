# Guide d'usage – G2-SrvDebian-GLPI

## Présentation
VM Debian dédiée au service GLPI (Gestionnaire Libre de Parc Informatique) pour la gestion des tickets, inventaire, et administration IT.

---

## 1. Connexion à la machine
- Accès SSH : `ssh utilisateur@IP_de_la_VM`
- Utiliser un terminal avec les droits nécessaires.

---

## 2. Gestion du service GLPI
- Pour démarrer le service Apache (qui sert GLPI) :
  ```bash
  sudo systemctl start apache2
