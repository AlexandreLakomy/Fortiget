#!/bin/bash

# Couleurs pour l'affichage
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # Reset des couleurs

# Fonction pour tester le ping
function test_ping() {
    local target=$1
    local label=$2
    local success=0

    for i in {1..5}; do
        if ping -c 1 -W 1 $target > /dev/null 2>&1; then
            success=1
            break
        fi
    done

    if [ $success -eq 1 ]; then
        echo -e "$label : ${GREEN}OK${NC}"
    else
        echo -e "$label : ${RED}NOK${NC}"
    fi
}

# Tests depuis Réseau Admin
echo "### Test depuis Réseau Admin ###"
ping_test "10.0.0.1"  # Réseau Admin
ping_test "10.1.0.1"  # Réseau User
ping_test "10.2.0.1"  # Réseau DMZ
ping_test "10.0.0.2"  #  Admin
ping_test "10.1.0.2"  #  User
ping_test "10.2.0.2"  #  DMZ
ping_test "8.8.8.8"       # Google

# Tests depuis Réseau DMZ
echo "### Test depuis Réseau DMZ ###"
ping_test "8.8.8.8"  # Serveur HTTP/HTTPS DMZ
ping_test "10.0.0.2" # Interface FortiGate

# Tests depuis Réseau USERS
echo "### Test depuis Réseau USERS ###"
ping_test "10.0.0.1"  # Réseau Admin
ping_test "10.1.0.1"  # Réseau User
ping_test "10.2.0.1"  # Réseau DMZ
ping_test "10.0.0.2"  #  Admin
ping_test "10.1.0.2"  #  User
ping_test "10.2.0.2"  #  DMZ

echo "Tous les tests de ping sont terminés."
