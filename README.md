# France Travail - Dashboard Assurance Chômage

Ce projet est une application web interactive permettant de visualiser les indicateurs clés de l'assurance chômage. Il propose une interface sécurisée avec des vues différenciées selon le rôle, des graphiques dynamiques et un accès aux données brutes.

## Inventaire et Description des Fichiers

### 1. Backend & Configuration (Node.js)

* **`package.json`** : Fichier manifeste du projet. Il définit les métadonnées et les dépendances : `express`, `mysql2`, `body-parser`, `express-session` et `bcrypt`. Il contient la commande de démarrage : `npm start`.
* **`server.js`** : Point d'entrée du serveur. Ce fichier :
    * Lance l'application Express sur le port **8080**.
    * Gère la connexion MySQL à la base `projet_tp9`.
    * Définit les routes d'authentification (`/auth`, `/logout`) et la protection des pages via `requireLogin`.
    * Redirige conditionnellement les utilisateurs vers le tableau de bord correspondant à leur rôle (`admin` ou `user`).
* **`hashUtil.js`** : Module de sécurité. Utilise `bcrypt` pour hacher les mots de passe avant insertion en base et pour les vérifier lors de la connexion.
* **`create_default_users.js`** : Script utilitaire Node.js. Il initialise la base de données en créant les utilisateurs par défaut (`admin` et `user`) avec des mots de passe sécurisés.

### 2. Base de Données & Données Sources

* **`projet_tp9.sql`** : Script SQL d'initialisation. Il crée la base de données `projet_tp9` (si elle n'existe pas), la table `users`, et insère les comptes par défaut.
* **`evolution_indicateurs_cles_ac.json`** : Fichier source contenant les données historiques (Allocataires, Dépenses, etc.) utilisées pour alimenter les graphiques et les tableaux de l'application.

### 3. Frontend - Vues HTML

* **`login.html`** : Page d'authentification. Affiche le formulaire de connexion qui envoie les identifiants au serveur via une requête POST.
* **`dashboard_admin.html`** : Vue principale pour l'**Administrateur**.
    * Intègre une carte interactive (`<div id="map">`) via Leaflet.
    * Affiche les filtres complets et les graphiques de synthèse.
* **`dashboard_user.html`** : Vue principale pour l'**Utilisateur**.
    * Similaire à la vue admin mais remplace la carte interactive par un message informatif ("Visualisation géographique réservée aux administrateurs").
* **`indicateurs.html`** : Page d'analyse détaillée. Présente des statistiques approfondies (Niveau de protection, Profil d'activité, Territoires, Flux).
* **`donnees_brutes.html`** : Page de consultation tabulaire. Elle permet d'afficher les données brutes (Année, Mois, Région, Département, Allocataires, Dépenses) sous forme de tableau pour une lecture précise des valeurs.

### 4. Frontend - Styles et Scripts

* **`style.css`** : Feuille de style globale. Définit la charte graphique (couleurs France Travail), la mise en page (Navbar, Cards, Grid) et le style des tableaux de données.
* **`script.js`** : Script principal pour les tableaux de bord et la gestion des données.
    * Charge le fichier `evolution_indicateurs_cles_ac.json`.
    * Gère l'affichage dynamique de la carte (si présente) et des graphiques Chart.js.
    * Gère la logique des filtres (Année, Mois, Région).
* **`indicateurs.js`** : Script spécifique à la page `indicateurs.html`. Il effectue des calculs statistiques avancés (moyennes, répartitions) et génère les graphiques spécifiques à cette page.

## Guide d'Installation

1.  **Installation des dépendances** :
    ```bash
   installer node js : https://nodejs.org/dist/v24.11.1/node-v24.11.1-x64.msi
    ```
2.  **Lancement Simulation Base de données en ligne** :
   Lancer Xampp. 
   * Mettre Apache en "admin"
   * Mettre Mysql en "admin"

3.  **Configuration BDD** :
   Assurez-vous d'avoir un serveur MySQL local.
    * Aller sur http://localhost/phpmyadmin/
    * Importez le fichier `projet_tp9.sql` dans votre SGBD.
    * *Sinon*, lancez `node create_default_users.js` pour initialiser les utilisateurs.

4.  **Démarrage** :
    ```bash
    cd "Chemin du dossier de l'application"
    npm start
    ```
   L'application est accessible sur `http://localhost:8080`.

## Identifiants par défaut

| Rôle | User | Pass | Accès |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin1234` | Complet (Carte + Données) |
| **User** | `user` | `user1234` | Restreint (Pas de carte sinon accès total) |
| **Invité** | Restreint (Accès qu'aux données du json) |