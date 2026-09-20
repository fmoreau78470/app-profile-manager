# Astro Pixel Processor (APP) — Profile Manager

---

### 🌐 Select your language / Choisissez votre langue

|  🇬🇧 [English Version](https://github.com/fmoreau78470/app-profile-manager/blob/main/README.md#-english) | 🇫🇷 [Version Française](https://github.com/fmoreau78470/app-profile-manager/blob/main/README.md#-fran%C3%A7ais) | 
| --- | --- |
| Cliquez pour lire en français | Click to read in English |

---

## 🇬🇧 English

A lightweight and bilingual profile manager for **Astro Pixel Processor (APP)**, available for both **macOS** (`.command`) and **Windows** (`.bat`).

It allows you to export, import, and switch between different APP configurations on the fly (e.g., LRGB, SHO, DSLR setups) without launching the app first.

### 📁 Repository Structure

* `app_manager.sh` : Execution script for macOS (Zsh/Bash)
* `app_manager.bat` : Execution script for Windows (Batch)
* `README.md` : Project documentation

### 🚀 Installation & Usage

#### 🍎 On macOS (`app_manager.command`)

1. Download or clone this repository.
2. Move `app_manager.command` to your preferred location.
3. Make the script executable (once) via Terminal:
`chmod +x /path/to/app_manager.command`
4. Double-click `app_manager.command` to run the manager.

> **Profile Storage:** Profiles are saved as `.plist` files in `~/Documents/APP_Profiles/`.

#### 🪟 On Windows (`app_manager.bat`)

1. Download or clone this repository.
2. Move `app_manager.bat` to your Desktop or preferred folder.
3. Double-click `app_manager.bat` to run the manager.

> **Profile Storage:** Profiles are saved as `.reg` files in `%USERPROFILE%\Documents\APP_Profiles\`.

### ✨ Features

* 🌐 **Bilingual:** Choose language (French / English) on first launch (saved for future runs).
* 💾 **Save Profiles:** Exports APP settings directly to the `Documents/APP_Profiles` directory.
* ⚡ **Express Load:** Apply a saved profile and relaunch APP immediately in a single step.
* 🔒 **Safety Check:** Detects if APP is already running before making changes to prevent data corruption.
* 🧹 **Clean Exit:** The terminal / command prompt window automatically closes once APP is launched.

### ⚙️ Prerequisites

* **Astro Pixel Processor** installed on your system.
* No external dependencies required (uses native OS tools: `defaults` on macOS, `reg` on Windows).

---

## 🇫🇷 Français

Un gestionnaire de profils léger et bilingue pour **Astro Pixel Processor (APP)**, disponible pour **macOS** (`.command`) et **Windows** (`.bat`).

Il permet d'exporter, d'importer et d'échanger à la volée différentes configurations d'APP (ex: paramétrages spécifiques LRGB, SHO, DSLR, etc.) sans ouvrir l'application.

### 📁 Structure du projet

* `app_manager.command` : Script d'exécution pour macOS (Zsh/Bash)
* `app_manager.bat` : Script d'exécution pour Windows (Batch)
* `README.md` : Documentation du projet

### 🚀 Installation & Utilisation

#### 🍎 Sur macOS (`app_manager.command`)

1. Télécharge ou clone ce dépôt.
2. Déplace `app_manager.command` à l'emplacement souhaité.
3. Rend le fichier exécutable (une seule fois) via le Terminal :
`chmod +x /chemin/vers/app_manager.command`
4. Double-clique sur `app_manager.command` pour lancer le gestionnaire.

> **Stockage des profils :** Les profils sont enregistrés au format `.plist` dans `~/Documents/APP_Profiles/`.

#### 🪟 Sur Windows (`app_manager.bat`)

1. Télécharge ou clone ce dépôt.
2. Déplace `app_manager.bat` sur ton Bureau ou dans le dossier de ton choix.
3. Double-clique sur `app_manager.bat` pour lancer le gestionnaire.

> **Stockage des profils :** Les profils sont enregistrés au format `.reg` dans `%USERPROFILE%\Documents\APP_Profiles\`.

### ✨ Fonctionnalités

* 🌐 **Bilingue :** Choix de la langue (Français / English) au premier démarrage (sauvegardé pour les sessions suivantes).
* 💾 **Sauvegarde des profils :** Exporte les préférences de configuration d'APP dans le dossier `Documents/APP_Profiles`.
* ⚡ **Chargement express :** Applique un profil enregistré et relance APP immédiatement en une seule étape.
* 🔒 **Sécurité :** Vérifie si APP est déjà ouvert avant de modifier ou sauvegarder une configuration afin d'éviter toute corruption de données.
* 🧹 **Mode discret :** La fenêtre de terminal / commande se ferme automatiquement dès qu'APP est lancé.

### ⚙️ Prérequis

* **Astro Pixel Processor** installé sur le système.
* Aucune dépendance externe requise (utilise uniquement les outils système natifs : `defaults` sur macOS, `reg` sur Windows).

---

## 📄 License

Project released under the [MIT](https://www.google.com/search?q=LICENSE&utm_source=gemini) License — Free to use, modify, and distribute.
