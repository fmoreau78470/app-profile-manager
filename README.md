# app-profile-manager
🚀 Installation & Utilisation
🍎 Sur macOS (app_manager.command)

    Télécharge ou clone ce dépôt.

    Déplace app_manager.command à l'emplacement souhaité.

    Rend le fichier exécutable (une seule fois) via le Terminal :
    Bash

    chmod +x /chemin/vers/app_manager.command

    Double-clique sur app_manager.command pour lancer le gestionnaire.

    Stockage des profils : Les profils sont enregistrés au format .plist dans ~/Documents/APP_Profiles/.

🪟 Sur Windows (app_manager.bat)

    Télécharge ou clone ce dépôt.

    Déplace app_manager.bat sur ton Bureau ou dans le dossier de ton choix.

    Double-clique sur app_manager.bat pour lancer le gestionnaire.

    Stockage des profils : Les profils sont enregistrés au format .reg dans %USERPROFILE%\Documents\APP_Profiles\.

✨ Fonctionnalités

    🌐 Bilingue : Choix de la langue (Français / English) au premier démarrage (sauvegardé pour les sessions suivantes).

    💾 Sauvegarde des profils : Exporte les préférences de configuration d'APP dans le dossier Documents/APP_Profiles.

    ⚡ Chargement express : Applique un profil enregistré et relance APP immédiatement en une seule étape.

    🔒 Sécurité : Vérifie si APP est déjà ouvert avant de modifier ou sauvegarder une configuration afin d'éviter toute corruption de données.

    🧹 Mode discret : La fenêtre de terminal / commande se ferme automatiquement dès qu'APP est lancé.

⚙️ Prérequis

    Astro Pixel Processor installé sur le système.

    Aucune dépendance externe requise (utilise uniquement les outils système natifs : defaults sur macOS, reg sur Windows).

🇬🇧 English

A lightweight and bilingual profile manager for Astro Pixel Processor (APP), available for both macOS (.command) and Windows (.bat).

It allows you to export, import, and switch between different APP configurations on the fly (e.g., LRGB, SHO, DSLR setups) without launching the app first.
📁 Repository Structure
Plaintext

├── app_manager.command   # Execution script for macOS (Zsh/Bash)
├── app_manager.bat       # Execution script for Windows (Batch)
└── README.md             # Bilingual documentation

🚀 Installation & Usage
🍎 On macOS (app_manager.command)

    Download or clone this repository.

    Move app_manager.command to your preferred location.

    Make the script executable (once) via Terminal:
    Bash

    chmod +x /path/to/app_manager.command

    Double-click app_manager.command to run the manager.

    Profile Storage: Profiles are saved as .plist files in ~/Documents/APP_Profiles/.

🪟 On Windows (app_manager.bat)

    Download or clone this repository.

    Move app_manager.bat to your Desktop or preferred folder.

    Double-click app_manager.bat to run the manager.

    Profile Storage: Profiles are saved as .reg files in %USERPROFILE%\Documents\APP_Profiles\.

✨ Features

    🌐 Bilingual: Choose language (French / English) on first launch (saved for future runs).

    💾 Save Profiles: Exports APP settings directly to the Documents/APP_Profiles directory.

    ⚡ Express Load: Apply a saved profile and relaunch APP immediately in a single step.

    🔒 Safety Check: Detects if APP is already running before making changes to prevent data corruption.

    🧹 Clean Exit: The terminal / command prompt window automatically closes once APP is launched.

⚙️ Prerequisites

    Astro Pixel Processor installed on your system.

    No external dependencies required (uses native OS tools: defaults on macOS, reg on Windows).

📄 License

Project released under the MIT License — Free to use, modify, and distribute.
