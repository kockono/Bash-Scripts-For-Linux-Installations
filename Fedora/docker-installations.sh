# ===== Instalación de Docker =====
echo -e "${BLUE}=== Actualizando sistema... ===${RESET}"
sudo dnf update -y

echo -e "${BLUE}=== Instalando Docker... ===${RESET}"
sudo dnf install docker -y

echo -e "${BLUE}=== Iniciando servicio Docker... ===${RESET}"
sudo systemctl enable docker
sudo systemctl start docker

echo -e "${GREEN}Docker instalado correctamente ✔${RESET}"

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

echo -e "${BLUE}=== Agregando usuario ec2-user al grupo docker... ===${RESET}"
sudo usermod -aG docker ec2-user

echo -e "${GREEN}Docker Compose instalado correctamente ✔${RESET}"

echo -e "${GREEN}=== Instalación completada ===${RESET}"
echo -e "Versión de Docker: $(docker --version)"
echo -e "Versión de Docker Compose: $(docker compose version)"