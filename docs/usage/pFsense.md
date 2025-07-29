# Guide d'usage - G2-Pfsense

## Présentation
G2-Pfsense est une appliance firewall basée sur pfSense, utilisée pour sécuriser et gérer le trafic réseau au sein de l'infrastructure.

---

## Accès à l’interface Web

- Depuis une machine connectée au réseau LAN, ouvrir un navigateur web.
- Accéder à l’interface pfSense via l’adresse IP LAN (exemple : `https://192.168.1.1`).
- Se connecter avec les identifiants administrateur (par défaut ou ceux configurés).

---

## Gestion des règles de pare-feu

- Naviguer dans **Firewall > Rules**.
- Ajouter, modifier ou supprimer des règles pour contrôler le trafic entrant et sortant.
- Prioriser les règles via l’ordre dans la liste (plus haut = priorité plus élevée).
- Appliquer les modifications en cliquant sur **Save** puis **Apply Changes**.

---

## Gestion des interfaces réseau

- Aller dans **Interfaces > Assignments**.
- Configurer les interfaces WAN, LAN, et éventuellement d’autres VLANs ou interfaces virtuelles.
- Modifier les paramètres IP, DHCP, DNS, etc.
- Valider et appliquer les changements.

---

## Surveillance et diagnostic

- Consulter les logs via **Status > System Logs** pour analyser les événements, alertes et erreurs.
- Utiliser **Diagnostics > Ping** ou **Traceroute** pour tester la connectivité réseau.
- Vérifier l’état des interfaces dans **Status > Interfaces**.
- Surveiller la bande passante avec **Status > Traffic Graphs**.

---

## Sauvegarde et restauration de la configuration

- Exporter la configuration actuelle via **Diagnostics > Backup & Restore**.
- Importer une configuration sauvegardée pour restaurer les paramètres.
- Planifier des sauvegardes régulières pour éviter les pertes de données.

---

## Mise à jour du système

- Aller dans **System > Update**.
- Vérifier les mises à jour disponibles et les appliquer en suivant les instructions.
- Redémarrer pfSense si nécessaire après la mise à jour.

---

## Sécurité et bonnes pratiques

- Modifier régulièrement le mot de passe administrateur.
- Désactiver l’accès à l’interface Web depuis WAN si non nécessaire.
- Configurer un accès VPN sécurisé pour l’administration à distance.
- Restreindre les services et ports ouverts aux seuls nécessaires.
- Garder pfSense et ses packages à jour.

---

## Commandes utiles via SSH (si accès shell activé)

```bash
# Redémarrer pfSense
sudo reboot

# Vérifier l'état des interfaces
ifconfig

# Visualiser les logs système
cat /var/log/system.log

# Redémarrer le service DHCP
sudo pfSsh.php playback svc restart dhcpd
```

---

## Ressources

- Documentation officielle pfSense : https://docs.netgate.com/pfsense/en/latest/
- Forum pfSense : https://forum.netgate.com/
- Documentation interne projet : [Doc usage G2-Pfsense]

---
