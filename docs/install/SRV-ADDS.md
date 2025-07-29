## Guide d'installation – SERV-ADDS (G2-WinServ-SRV-ADDS)

**Nom Proxmox** : `G2-WinServ-SRV-ADDS`
**Nom machine** : `SERV-ADDS`
**Rôle** : Contrôleur principal de domaine Active Directory + serveur DNS

---

### 1. Création de la VM sous Proxmox

**ID Proxmox** : `175`
**Type** : VM Windows Server 2022 Standard

#### a) Paramètres de base :

* Nom : `G2-WinServ-SRV-ADDS`
* OS : Windows Server 2022
* RAM : 4096 Mo
* CPU : 2 vCPU (type host)
* Disque : 80 Go (VirtIO SCSI, format qcow2)
* Réseau : VirtIO (bridge `vmbr0`, VLAN selon plan d’adressage)

#### b) ISO :

* Choisir une ISO officielle de Windows Server 2022 (stockée localement sur le nœud Proxmox ou sur NFS).

---

### 2. Installation de Windows Server

1. Lancer la VM sur l’ISO.
2. Choisir "Windows Server 2022 Standard avec expérience utilisateur".
3. Suivre l'installation standard (partition, fuseau horaire, mot de passe admin).

---

### 3. Configuration post-installation

#### a) Renommage de la machine

```powershell
Rename-Computer -NewName "SERV-ADDS" -Restart
```

#### b) Adresse IP statique

Configurer via l'interface graphique ou PowerShell :

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.10 -PrefixLength 24 -DefaultGateway 192.168.10.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
```

#### c) Installation des drivers VirtIO (si requis)

* Monter l’ISO VirtIO dans Proxmox
* Installer les drivers manuellement via le Gestionnaire de périphériques

---

### 4. Installation des rôles ADDS et DNS

```powershell
Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
```

---

### 5. Promotion en contrôleur de domaine principal

```powershell
Install-ADDSForest `
    -DomainName "ekoloclast.local" `
    -DomainNetbiosName "EKOLOCLAST" `
    -InstallDNS `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM" -AsPlainText -Force)
```

* Valider et redémarrer automatiquement

---

### 6. Vérifications post-installation

* Ouvrir :

  * `dsa.msc` pour ADUC (Utilisateurs et ordinateurs Active Directory)
  * `dnsmgmt.msc` pour le DNS
* Tester :

  * Adhésion d’un client au domaine `ekoloclast.local`
  * Résolution DNS interne

---

### 7. Sauvegarde

* Installer la fonctionnalité :

```powershell
Add-WindowsFeature Windows-Server-Backup
```

* Créer une première sauvegarde système

---
