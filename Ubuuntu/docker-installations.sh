#!/bin/bash

# ===== Colores =====
GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"
RESET="\e[0m"


# ===== Instalación de Docker =====
echo -e "${BLUE}=== Actualizando sistema... ===${RESET}"
sudo apt update -y

echo -e "${BLUE}=== Instalando paquetes que permitan paquetes HTTPS con Apt... ===${RESET}"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo -e "${BLUE}=== Agregando clave GPG oficial de Docker... ===${RESET}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "${BLUE}=== Agregando repositorio de Docker a las fuentes de Apt... ===${RESET}"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

echo -e "${BLUE}=== Actualizando sistema... ===${RESET}"
sudo apt update -y

echo -e "${BLUE}=== Verificando instalación de Docker desde el repositorio... ===${RESET}"
apt-cache policy docker-ce

echo -e "${BLUE}=== Instalando Docker... ===${RESET}"
sudo apt install docker-ce -y

echo -e "${BLUE}=== Instalando Upgrade de paquetes... ===${RESET}"
sudo apt upgrade -y

echo -e "${BLUE}=== Iniciando servicio Docker... ===${RESET}"
sudo systemctl enable docker
sudo systemctl start docker

echo -e "${GREEN}Docker instalado correctamente ✔${RESET}"
sudo systemctl status docker

# ===== Instalación de Docker Compose =====
echo -e "${BLUE}=== Instalando Docker Compose... ===${RESET}"
PLUGIN_DIR="/usr/libexec/docker/cli-plugins"
COMPOSE_BIN="$PLUGIN_DIR/docker-compose"
ARCH=$(uname -m)

echo -e "${BLUE}=== Configurando directorio de plugins ===${RESET}"
sudo mkdir -p "$PLUGIN_DIR"

echo -e "${BLUE}=== Descargando Docker Compose (${ARCH})... ===${RESET}"
sudo curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-${ARCH}" -o "$COMPOSE_BIN"

echo -e "${BLUE}=== Dando permisos de ejecución... ===${RESET}"
sudo chmod +x "$COMPOSE_BIN"

echo -e "${BLUE}=== Agregando usuario al grupo docker... ===${RESET}"
sudo usermod -aG docker ${USER}

echo -e "${GREEN}Docker Compose instalado correctamente ✔${RESET}"

echo -e "${GREEN}=== Instalación completada ===${RESET}"
echo -e "Versión de Docker: $(docker --version)"
echo -e "Versión de Docker Compose: $(docker compose version)"