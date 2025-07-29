## Guide d'installation – DebianServ (G2-DebianServ)

**Nom Proxmox** : `G2-DebianServ`
**Nom machine** : `DebianServ`
**Rôle** : Serveur Debian généraliste (outils CLI, script, routage secondaire, proxy, etc.)

---

### 1. Création de la VM sous Proxmox

**ID Proxmox** : `189`
**Type** : VM Debian 12 (Bookworm)

#### a) Paramètres Proxmox :

* Nom : `G2-DebianServ`
* OS : Debian 12
* RAM : 2048 Mo (modifiable selon l’usage)
* CPU : 2 vCPU
* Disque : 20 Go (VirtIO SCSI, qcow2)
* Réseau : VirtIO, bridge `vmbr0`, VLAN 10 (ou selon topologie réseau)

#### b) ISO :

* Debian 12 NetInstall (version stable)

---

### 2. Installation de Debian

1. Choisir l'installation standard.
2. Sélectionner les options suivantes :

   * Interface SSH
   * Utilitaires standards du système
   * Pas d'interface graphique
3. Partitionnement guidé (LVM ou disque entier).
4. Définir le mot de passe `root` et créer un utilisateur sudo séparé (`admin` recommandé).

---

### 3. Configuration réseau

#### a) Interface statique (exemple pour VLAN 10)

Éditer `/etc/network/interfaces` :

```bash
auto ens18
iface ens18 inet static
    address 192.168.10.11/24
    gateway 192.168.10.1
    dns-nameservers 192.168.10.10
```

Puis :

```bash
systemctl restart networking
```

#### b) Test de connectivité

```bash
ping -c 3 192.168.10.1
ping -c 3 1.1.1.1
ping -c 3 google.fr
```

---

### 4. Sécurisation de base

```bash
apt update && apt upgrade -y
apt install sudo ufw curl wget git net-tools -y
adduser admin
usermod -aG sudo admin
```

Activer le pare-feu :

```bash
ufw allow OpenSSH
ufw enable
```

---

### 5. Installation des outils utiles (selon mission)

```bash
apt install htop iftop nmap tcpdump vim netcat-traditional whois rsyslog -y
```

---

### 6. Ajout de services spécifiques (selon besoins projet)

* Serveur proxy (Squid ?)
* Serveur secondaire DNS
* Scripts internes de supervision
* Routage avec `iptables` / `ip rule`

---

### 7. Sauvegarde / snapshot

* Effectuer un snapshot Proxmox post-installation.
* Intégration dans Bareos ou autre solution backup si besoin.

---

### 8. Remarques

* La VM est prévue pour être multi-usage : tests, relais DNS, reverse proxy, monitoring, etc.
* Peut être clonée pour d’autres services Debian à faible empreinte.

---
