## Guide d'installation – FSMO-SCHEMA (G2-WinServ-FSMO-SCHEMA)

**Nom Proxmox** : `G2-WinServ-FSMO-SCHEMA`
**Nom machine** : `FSMO-PDC`
**Rôle** : Contrôleur de domaine secondaire avec rôle FSMO (Schema + PDC)

---

### 1. Création de la VM sous Proxmox

**ID Proxmox** : `185`
**Type** : VM Windows Server 2022 Standard

#### a) Paramètres de base :

* Nom : `G2-WinServ-FSMO-SCHEMA`
* OS : Windows Server 2022
* RAM : 4096 Mo
* CPU : 2 vCPU
* Disque : 60 Go (VirtIO SCSI, qcow2)
* Réseau : VirtIO (bridge `vmbr0`, VLAN selon plan)

#### b) ISO :

* Windows Server 2022 ISO officiel

---

### 2. Installation de Windows Server

1. Installation classique avec interface graphique.
2. Nom de l’administrateur local, mot de passe sécurisé.
3. Langue/français, fuseau horaire Europe/Paris.

---

### 3. Configuration initiale

#### a) Renommage

```powershell
Rename-Computer -NewName "FSMO-PDC" -Restart
```

#### b) Configuration IP

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.11 -PrefixLength 24 -DefaultGateway 192.168.10.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.10.10
```

#### c) Installation VirtIO si nécessaire

* Monter l’ISO VirtIO
* Mettre à jour les pilotes manuellement via le gestionnaire de périphériques

---

### 4. Rejoindre le domaine

```powershell
Add-Computer -DomainName "ekoloclast.local" -Credential ekoloclast\administrateur -Restart
```

---

### 5. Installation des rôles ADDS

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

---

### 6. Promotion en contrôleur de domaine

```powershell
Install-ADDSDomainController `
    -DomainName "ekoloclast.local" `
    -Credential (Get-Credential) `
    -SiteName "Default-First-Site-Name" `
    -InstallDns
```

* Redémarrage automatique après la promotion

---

### 7. Vérifications post-installation

* `dsa.msc` pour contrôler la réplication
* `netdom query fsmo` pour vérifier la détention des rôles
* Réplication :

```powershell
repadmin /replsummary
```

---

### 8. Transfert des rôles FSMO (facultatif si prévu)

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity "FSMO-PDC" -OperationMasterRole SchemaMaster, PDCEmulator
```

---

### 9. Sauvegarde

```powershell
Add-WindowsFeature Windows-Server-Backup
```

* Sauvegarde système après promotion et réplication OK

---
