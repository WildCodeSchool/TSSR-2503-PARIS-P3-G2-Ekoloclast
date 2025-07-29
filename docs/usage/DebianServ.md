## Gestion des services

Gérer les services via `systemctl` (exemple : `sudo systemctl restart apache2`).

### 2. Gestion des services

Installer, configurer, démarrer ou arrêter les services nécessaires (ex : Apache, Nginx, SSH, FTP, etc.).

Vérifier le statut des services avec :

```bash
sudo systemctl status <nom_service>
```

### 3. Surveillance et logs

Consulter les logs système dans `/var/log/` pour diagnostiquer les problèmes.

Utiliser `top`, `htop`, ou `vmstat` pour surveiller les ressources système.

### 4. Sécurité

- Maintenir le pare-feu actif (exemple : `ufw`).  
- Restreindre les accès SSH (clé publique, désactivation du login root).  
- Mettre en place les mises à jour de sécurité automatiques si nécessaire.

---

## Commandes utiles

| Commande               | Description                          |
|-----------------------|------------------------------------|
| `sudo apt update`      | Met à jour la liste des paquets     |
| `sudo apt upgrade -y`  | Met à jour tous les paquets installés |
| `sudo systemctl status`| Vérifie le statut d’un service      |
| `sudo journalctl -xe`  | Affiche les logs système récents    |
| `top` ou `htop`        | Surveillance des processus actifs   |

---

## Limitations et remarques

- VM utilisée comme serveur polyvalent, adapter les services selon les besoins.  
- Assurer des sauvegardes régulières des configurations et des données.

---

## Documentation et ressources

- [Doc installation G2-DebianServ](../docs/install/DebianServ.md)  
- [Doc usage G2-DebianServ](../docs/usage/DebianServ.md)
