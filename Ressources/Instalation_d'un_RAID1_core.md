## Installation RAID1 sur Windows Server core

    Lancer Diskpart

diskpart

    Lister les disques

listdisk

    Selectionner le disque 0 et le convertir en dynamic

select disk 0
convert dynamic

    Idem pour le nouveau disque ajouté

select disk 1
convert dynamic

    Lister les volumes

list volume

    Selectionner le disque C et ajouter le deuxième disque

select volume V
add disk=1

    Vérification

list disk
list volume

