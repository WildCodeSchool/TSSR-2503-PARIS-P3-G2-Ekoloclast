# Guide d'utilisation – G2-WinServ-FSMODOMAIN  
*Serveur Windows FSMO Domain Controller*

---

# 1. Connexion

- Se connecter à la VM via RDP (Bureau à distance) :  
  - Adresse : IP_de_la_VM  
  - Utilisateur : administrateur domaine (ex : AdminDOM)  
  - Mot de passe : fourni par l’administrateur

- Ou en PowerShell / CMD via WinRM si configuré.

---

# 2. Gestion des rôles FSMO

- Vérifier les rôles FSMO sur ce serveur avec la commande PowerShell :  
  ```powershell
  netdom query fsmo
