## Guide d'installation – G2-SrvDebian-GLPI

**Nom Proxmox** : `G2-SrvDebian-GLPI`
**Nom machine** : `DebianServ`
**Rôle** : Serveur GLPI (ITSM + Inventaire)

---

### 1. Création de la VM dans Proxmox

* **ID Proxmox** : `195`
* **Type** : VM Debian 11 ou 12
* **Nom** : `G2-SrvDebian-GLPI`
* **CPU** : 2 vCPU
* **RAM** : 4096 Mo
* **Disque** : 32 à 64 Go (VirtIO, ext4 ou xfs)
* **Réseau** : Interface sur VLAN SERV (vmbr0)

---

### 2. Installation de Debian

* Utiliser l’ISO Debian NetInstall
* Partitionnement personnalisé ou guidé
* Choisir uniquement **SSH server** et **Standard system utilities** lors de l'installation

---

### 3. Configuration réseau

Configurer une IP statique :

```bash
nano /etc/network/interfaces
```

Exemple :

```bash
iface enp0s18 inet static
  address 192.168.10.15/24
  gateway 192.168.10.1
  dns-nameservers 192.168.10.10 8.8.8.8
```

Redémarrer le service :

```bash
systemctl restart networking
```

---

### 4. Mise à jour système

```bash
apt update && apt full-upgrade -y
```

---

### 5. Installation des dépendances GLPI

```bash
apt install -y apache2 mariadb-server php php-mysql php-curl php-gd php-intl \
php-ldap php-apcu php-xml php-mbstring php-bz2 php-imap php-zip unzip wget
```

---

### 6. Configuration de MariaDB

```bash
mysql_secure_installation
mysql -u root -p
```

Créer la base et l’utilisateur :

```sql
CREATE DATABASE glpidb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'glpiuser'@'localhost' IDENTIFIED BY 'MotDePasseSecurise';
GRANT ALL PRIVILEGES ON glpidb.* TO 'glpiuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

### 7. Installation de GLPI

```bash
cd /var/www/html
wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
 tar -xzf glpi-10.0.15.tgz
mv glpi/* .
chown -R www-data:www-data /var/www/html
rm -rf glpi glpi-10.0.15.tgz
```

---

### 8. Activation du site Apache

```bash
a2enmod rewrite
systemctl restart apache2
```

---

### 9. Accès Web

* Ouvrir un navigateur : [http://192.168.10.15](http://192.168.10.15)
* Suivre l’assistant de configuration GLPI (langue, base de données, utilisateur)
* Supprimer le répertoire `/install` après installation :

```bash
rm -rf /var/www/html/install
```

---

### 10. Sécurisation complémentaire

* Sauvegarde régulière DB : script cron avec `mysqldump`
* Firewall `ufw` ou `iptables`
* Mettre à jour régulièrement avec :

```bash
apt update && apt upgrade -y
```

---
