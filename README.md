# 🐳 Inception - 42 Project

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-117AC9?style=for-the-badge&logo=wordpress&logoColor=white)
![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-0D597F?style=for-the-badge&logo=alpine-linux&logoColor=white)

## 📖 À propos

Ce projet a pour but de découvrir l'administration système via **Docker**. L'objectif est de mettre en place une petite infrastructure composée de différents services fonctionnant sous des conteneurs isolés, orchestrés par **Docker Compose**.

Le projet impose de construire nos propres images Docker (Dockerfiles) et de configurer une stack LEMP complète (Linux, Nginx, MariaDB, PHP/WordPress) respectant des règles strictes de sécurité et d'architecture.

<img width="830" height="1079" alt="image" src="https://github.com/user-attachments/assets/0bb47243-6c5d-4b75-9e46-bf25eb4b0a0c" />


---

## 🏗️ Architecture et Structure

Chaque service tourne dans un conteneur dédié. Les conteneurs communiquent via un réseau Docker interne et les données sont persistées via des volumes Docker.

### Arborescence du projet
```text
.
├── docker-compose.yml
├── Makefile
└── srcs
    ├── mariadb
    │   └── Dockerfile
    ├── nginx
    │   ├── conf
    │   │   ├── inception.crt
    │   │   ├── inception.key
    │   │   └── nginx.conf
    │   └── Dockerfile
    ├── tools
    │   ├── mariadb.conf
    │   ├── setup_db.sh
    │   └── wp-setup.sh
    └── wordpress
        └── Dockerfile
```

## 🚀 Installation et Utilisation
### 1. Prérequis
- Docker Engine & Docker Compose

- Make

- Un système Linux (VM ou natif)

### 2. Configuration du DNS local
Pour que le projet fonctionne conformément au sujet, vous devez mapper le nom de domaine local [TON_LOGIN].42.fr vers votre adresse IP locale.

Ouvrez le fichier hosts :

```Bash

sudo nano /etc/hosts
Ajoutez la ligne suivante :

127.0.0.1   [TON_LOGIN].42.fr
(Remplace [TON_LOGIN] par ton login 42)
```
### 3. Commandes Makefile
Le Makefile à la racine permet de gérer l'ensemble du cycle de vie de l'application.

Lancer l'application (Build & Up) :

```Bash

make
```
Cette commande crée les volumes nécessaires, compile les images Docker et lance les conteneurs en arrière-plan.

Arrêter les services :

```Bash

make down
```
Nettoyage total (Attention : supprime aussi les volumes de données) :

```Bash

make fclean
```
Afficher les logs :

```Bash

make logs
```
Une fois lancé, le site est accessible via : https://mmouaffa.42.fr

## 🛠️ Explication des Services & Technologies
### 🖥️ NGINX (Point d'entrée)
Rôle : Serveur Web et Reverse Proxy.

Technique : C'est le seul conteneur exposé sur l'extérieur (port 443). Il gère le protocole TLS v1.2/v1.3 pour une connexion sécurisée HTTPS.

Config : Il redirige les requêtes PHP vers le conteneur WordPress via le port 9000. Les certificats SSL (inception.crt et inception.key) sont utilisés pour chiffrer le trafic.

### 📝 WordPress + PHP-FPM
Rôle : Le CMS (Content Management System) et l'interpréteur de code.

Technique : Utilisation de PHP-FPM (FastCGI Process Manager) pour une meilleure performance.

Config : Le script wp-setup.sh (dans srcs/tools) utilise probablement WP-CLI pour installer et configurer WordPress automatiquement au démarrage du conteneur (création d'admin, lien avec la DB, etc.).

### 🗄️ MariaDB
Rôle : Base de données relationnelle.

Technique : Stocke toutes les données du site WordPress (articles, utilisateurs, configs).

Config : Le script setup_db.sh initialise la base de données et l'utilisateur spécifique à WordPress au premier lancement, assurant que la base est prête à recevoir des connexions.

## ⚠️ Difficultés Rencontrées
### 1. PID 1 et Processus en premier plan
Docker arrête un conteneur dès que son processus principal (PID 1) se termine.

Difficulté : Nginx et PHP-FPM ont tendance à se lancer en mode "daemon" (arrière-plan) par défaut, ce qui fermait instantanément les conteneurs.

Solution : Configurer les services pour tourner en foreground (daemon off; pour Nginx, -F pour PHP-FPM) dans les Dockerfiles ou les scripts de lancement.

### 2. Communication Inter-Conteneurs
Difficulté : Faire communiquer WordPress avec MariaDB sans utiliser d'adresses IP fixes.

Solution : Utilisation des noms de services définis dans le docker-compose.yml. Docker résout automatiquement le nom d'hôte mariadb vers l'IP interne du conteneur correspondant.

### 3. Gestion des Volumes et Permissions
Difficulté : Erreurs "Permission Denied" ou "403 Forbidden" sur WordPress.

Solution : S'assurer que les fichiers dans /var/www/html appartiennent bien à l'utilisateur qui exécute PHP-FPM et Nginx (souvent www-data ou nginx), et que les volumes sont montés correctement dans le docker-compose.yml.

### 4. Certificats SSL
Difficulté : Configurer HTTPS proprement avec des certificats auto-signés.

Solution : Génération des clés et certificats (.crt, .key) et configuration correcte des blocs server dans Nginx pour forcer le TLS.

👤 Auteur
Mouaffak Mehdi

42 Login : mmouaffa
