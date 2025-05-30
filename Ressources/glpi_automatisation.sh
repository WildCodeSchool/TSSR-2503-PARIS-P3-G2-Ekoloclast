#!/bin/bash

# Variables personnalisables
domaine="glpi.mondomaine.local"
rep_glpi="/var/www/$domaine"
user_sql="glpi"
pass_sql="motDePasse"
db_sql="glpidb"

# Mise à jour du système
echo "🔧 Mise à jour du système..."
sudo apt-get update && sudo apt-get upgrade -y

# Installation d'Apache
echo "🌐 Installation d'Apache..."
sudo apt-get install apache2 -y
sudo systemctl enable apache2

# Installation de MariaDB
echo "💾 Installation de MariaDB..."
sudo apt-get install mariadb-server -y

# Installation de PHP et modules
PHP_VERSION="8.1"
echo "⚙️ Installation de PHP $PHP_VERSION et modules..."
sudo apt-get install php$PHP_VERSION libapache2-mod-php$PHP_VERSION -y
sudo apt-get install php-$PHP_VERSION-{ldap,imap,apcu,xmlrpc,curl,common,gd,json,mbstring,mysql,xml,intl,zip,bz2} -y

# Sécurisation de MariaDB
sudo mysql_secure_installation

# Création de la base GLPI
echo "📂 Création de la base de données GLPI..."
sudo mysql -u root <<EOF
CREATE DATABASE $db_sql CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON $db_sql.* TO '$user_sql'@'localhost' IDENTIFIED BY '$pass_sql';
FLUSH PRIVILEGES;
EOF

# Récupération de GLPI
echo "📥 Téléchargement de GLPI..."
wget https://github.com/glpi-project/glpi/releases/download/10.0.10/glpi-10.0.10.tgz

# Décompression et copie
echo "📁 Décompression et installation de GLPI dans $rep_glpi..."
sudo mkdir -p "$rep_glpi"
sudo tar -xvzf glpi-10.0.10.tgz
sudo cp -R glpi/* "$rep_glpi/"

# Droits d'accès
echo "🔐 Attribution des droits..."
sudo chown -R www-data:www-data "$rep_glpi"
sudo chmod -R 775 "$rep_glpi"

# Configuration Apache
echo "📝 Configuration d'Apache..."
sudo sed -i "s|DocumentRoot .*|DocumentRoot $rep_glpi|" /etc/apache2/sites-available/000-default.conf

# Configuration PHP
echo "⚙️ Configuration de PHP..."
sudo sed -i 's/^memory_limit.*/memory_limit = 64M/' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's/^max_execution_time.*/max_execution_time = 600/' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's/^file_uploads.*/file_uploads = On/' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's/^session.auto_start.*/session.auto_start = 0/' /etc/php/$PHP_VERSION/apache2/php.ini
sudo sed -i 's/^session.use_trans_sid.*/session.use_trans_sid = 0/' /etc/php/$PHP_VERSION/apache2/php.ini

# Redémarrage
echo "🔁 Redémarrage d'Apache..."
sudo systemctl restart apache2

echo "✅ Installation de GLPI terminée. Rendez-vous sur http://$domaine pour finir l'installation via le navigateur."

