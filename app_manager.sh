#!/bin/bash

# Configuration des dossiers
PROFILES_DIR="$HOME/Documents/APP_Profiles"
PREFS_FILE="$HOME/Library/Preferences/com.apple.java.util.prefs.plist"
LAST_CHARGED_FILE="$PROFILES_DIR/.last_loaded"
LANG_FILE="$PROFILES_DIR/.language"
APP_PATH="/Applications/AstroPixelProcessor.app"

# Créer le répertoire de profils s'il n'existe pas
mkdir -p "$PROFILES_DIR"

# -----------------------------------------------------------------------------
# GESTION DE LA LANGUE
# -----------------------------------------------------------------------------
if [ ! -f "$LANG_FILE" ]; then
    clear
    echo "=========================================="
    echo "   LANGUAGE SELECTION / CHOIX DE LANGUE"
    echo "=========================================="
    echo " 1) Français"
    echo " 2) English"
    echo "=========================================="
    read -p "Choice / Choix [1-2] : " LANG_CHOICE
    if [ "$LANG_CHOICE" == "2" ]; then
        echo "EN" > "$LANG_FILE"
    else
        echo "FR" > "$LANG_FILE"
    fi
fi

CURRENT_LANG=$(cat "$LANG_FILE")

# Dictionnaires de textes
if [ "$CURRENT_LANG" == "EN" ]; then
    TXT_TITLE="APP PROFILE MANAGER (macOS)"
    TXT_ACTIVE="Active profile loaded"
    TXT_NONE="None (system config)"
    TXT_M1="1) Launch APP (current configuration)"
    TXT_M2="2) Save current configuration"
    TXT_M3="3) Select a configuration"
    TXT_M4="4) Select a configuration AND launch APP"
    TXT_M5="5) Delete a saved configuration"
    TXT_M6="6) Switch language (FR/EN)"
    TXT_M7="7) Quit"
    TXT_CHOICE="Your choice [1-7] : "
    TXT_LAUNCHING="🚀 Launching Astro Pixel Processor..."
    TXT_APP_OPEN="⚠️ APP is currently running! Please close it first."
    TXT_PRESS_ENTER="Press [Enter] to continue..."
    TXT_NO_PREFS="❌ Preferences file not found in ~/Library/Preferences/."
    TXT_ENTER_NAME="Enter profile name (e.g., LRGB_Default) : "
    TXT_INVALID_NAME="❌ Invalid name."
    TXT_EXISTS="⚠️ Profile already exists. Overwrite? (y/N) : "
    TXT_SAVED="✅ Configuration saved as"
    TXT_SELECT_PROMPT="Select a profile number : "
    TXT_NO_PROFILES="❌ No saved profiles found in"
    TXT_APPLIED="✅ Profile applied successfully!"
    TXT_CONFIRM_DEL="⚠️ Delete profile permanently? (y/N) : "
    TXT_DELETED="🗑️ Profile deleted."
    TXT_BYE="Goodbye!"
else
    TXT_TITLE="GESTIONNAIRE DE PROFILS - APP (macOS)"
    TXT_ACTIVE="Profil actif chargé"
    TXT_NONE="Aucun (config système)"
    TXT_M1="1) Lancer APP (configuration actuelle)"
    TXT_M2="2) Sauvegarder la configuration actuelle"
    TXT_M3="3) Choisir une configuration"
    TXT_M4="4) Choisir une configuration ET lancer APP"
    TXT_M5="5) Supprimer une configuration enregistrée"
    TXT_M6="6) Changer de langue (FR/EN)"
    TXT_M7="7) Quitter"
    TXT_CHOICE="Ton choix [1-7] : "
    TXT_LAUNCHING="🚀 Lancement d'Astro Pixel Processor..."
    TXT_APP_OPEN="⚠️ APP est ouvert ! Veuillez le fermer d'abord."
    TXT_PRESS_ENTER="Appuie sur [Entrée] pour continuer..."
    TXT_NO_PREFS="❌ Fichier de préférences introuvable dans ~/Library/Preferences/."
    TXT_ENTER_NAME="Entre le nom du profil (ex: LRGB_Default) : "
    TXT_INVALID_NAME="❌ Nom invalide."
    TXT_EXISTS="⚠️ Le profil existe déjà. L'écraser ? (o/N) : "
    TXT_SAVED="✅ Configuration enregistrée sous"
    TXT_SELECT_PROMPT="Choisis un numéro de profil : "
    TXT_NO_PROFILES="❌ Aucun profil enregistré dans"
    TXT_APPLIED="✅ Profil appliqué avec succès !"
    TXT_CONFIRM_DEL="⚠️ Supprimer définitivement le profil ? (o/N) : "
    TXT_DELETED="🗑️ Profil supprimé."
    TXT_BYE="Au revoir !"
fi

# -----------------------------------------------------------------------------
# FONCTIONS
# -----------------------------------------------------------------------------
check_app_running() {
    if pgrep -x "AstroPixelProcessor" > /dev/null || pgrep -f "astropixelprocessor" > /dev/null; then
        return 0
    else
        return 1
    fi
}

clear_mac_cache() {
    killall cfprefsd 2>/dev/null
}

close_terminal() {
    (sleep 0.5 && osascript -e 'tell application "Terminal" to close window 1') &
    exit
}

launch_app() {
    echo ""
    echo "$TXT_LAUNCHING"
    open "$APP_PATH"
}

save_config() {
    echo ""
    if check_app_running; then
        echo "$TXT_APP_OPEN"
        read -p "$TXT_PRESS_ENTER"
        return
    fi

    if [ ! -f "$PREFS_FILE" ]; then
        echo "$TXT_NO_PREFS"
        read -p "$TXT_PRESS_ENTER"
        return
    fi

    read -p "$TXT_ENTER_NAME" PROFILE_NAME

    if [ -z "$PROFILE_NAME" ]; then
        echo "$TXT_INVALID_NAME"
        read -p "$TXT_PRESS_ENTER"
        return
    fi

    TARGET="$PROFILES_DIR/${PROFILE_NAME}.plist"

    if [ -f "$TARGET" ]; then
        read -p "$TXT_EXISTS" CONFIRM
        if [[ "$CONFIRM" != "o" && "$CONFIRM" != "O" && "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
            return
        fi
    fi

    clear_mac_cache
    cp "$PREFS_FILE" "$TARGET"
    echo "$TXT_SAVED : ${PROFILE_NAME}.plist"
    read -p "$TXT_PRESS_ENTER"
}

select_and_apply_config() {
    echo ""
    if check_app_running; then
        echo "$TXT_APP_OPEN"
        read -p "$TXT_PRESS_ENTER"
        return 1
    fi

    shopt -s nullglob
    PROFILES=("$PROFILES_DIR"/*.plist)
    shopt -u nullglob

    if [ ${#PROFILES[@]} -eq 0 ]; then
        echo "$TXT_NO_PROFILES $PROFILES_DIR"
        read -p "$TXT_PRESS_ENTER"
        return 1
    fi

    echo "--- Profiles ---"
    for i in "${!PROFILES[@]}"; do
        FILENAME=$(basename "${PROFILES[$i]}" .plist)
        echo " [$((i+1))] $FILENAME"
    done
    echo "----------------"

    read -p "$TXT_SELECT_PROMPT" CHOICE

    if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "${#PROFILES[@]}" ]; then
        echo "$TXT_INVALID_NAME"
        read -p "$TXT_PRESS_ENTER"
        return 1
    fi

    SELECTED_FILE="${PROFILES[$((CHOICE-1))]}"
    SELECTED_NAME=$(basename "$SELECTED_FILE" .plist)

    cp "$SELECTED_FILE" "$PREFS_FILE"
    clear_mac_cache
    
    echo "$SELECTED_NAME" > "$LAST_CHARGED_FILE"
    echo "$TXT_APPLIED"
    return 0
}

delete_config() {
    echo ""
    shopt -s nullglob
    PROFILES=("$PROFILES_DIR"/*.plist)
    shopt -u nullglob

    if [ ${#PROFILES[@]} -eq 0 ]; then
        echo "$TXT_NO_PROFILES"
        read -p "$TXT_PRESS_ENTER"
        return
    fi

    echo "--- Profiles ---"
    for i in "${!PROFILES[@]}"; do
        FILENAME=$(basename "${PROFILES[$i]}" .plist)
        echo " [$((i+1))] $FILENAME"
    done
    echo "----------------"

    read -p "$TXT_SELECT_PROMPT" CHOICE

    if [ "$CHOICE" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "${#PROFILES[@]}" ]; then
        echo "$TXT_INVALID_NAME"
        read -p "$TXT_PRESS_ENTER"
        return
    fi

    SELECTED_FILE="${PROFILES[$((CHOICE-1))]}"
    SELECTED_NAME=$(basename "$SELECTED_FILE" .plist)

    read -p "$TXT_CONFIRM_DEL" CONFIRM
    if [[ "$CONFIRM" == "o" || "$CONFIRM" == "O" || "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
        rm "$SELECTED_FILE"
        echo "$TXT_DELETED"
        if [ -f "$LAST_CHARGED_FILE" ] && [ "$(cat "$LAST_CHARGED_FILE")" == "$SELECTED_NAME" ]; then
            rm "$LAST_CHARGED_FILE"
        fi
    fi
    read -p "$TXT_PRESS_ENTER"
}

# -----------------------------------------------------------------------------
# MENU PRINCIPAL
# -----------------------------------------------------------------------------
while true; do
    clear
    LAST_PROFILE="$TXT_NONE"
    if [ -f "$LAST_CHARGED_FILE" ]; then
        LAST_PROFILE=$(cat "$LAST_CHARGED_FILE")
    fi

    echo "=========================================="
    echo "   $TXT_TITLE"
    echo "   $TXT_ACTIVE : [$LAST_PROFILE]"
    echo "=========================================="
    echo " $TXT_M1"
    echo " $TXT_M2"
    echo " $TXT_M3"
    echo " $TXT_M4"
    echo " $TXT_M5"
    echo " $TXT_M6"
    echo " $TXT_M7"
    echo "=========================================="
    read -p "$TXT_CHOICE" MENU_CHOICE

    case $MENU_CHOICE in
        1)
            launch_app
            close_terminal
            ;;
        2)
            save_config
            ;;
        3)
            select_and_apply_config
            if [ $? -eq 0 ]; then
                read -p "$TXT_PRESS_ENTER"
            fi
            ;;
        4)
            if select_and_apply_config; then
                launch_app
                close_terminal
            fi
            ;;
        5)
            delete_config
            ;;
        6)
            rm -f "$LANG_FILE"
            exec "$0"
            ;;
        7)
            echo "$TXT_BYE"
            close_terminal
            ;;
        *)
            ;;
    esac
done