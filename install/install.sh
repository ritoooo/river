!#/bin/bash

# Cleaning the TTY.
clear

# Cosmetics (colours for text).
BOLD='\e[1m'
BRED='\e[91m'
BBLUE='\e[34m'
BGREEN='\e[92m'
BYELLOW='\e[93m'
RESET='\e[0m'

# Pretty print (function).
info_print () {
    echo -e "${BOLD}${BGREEN}[ ${BYELLOW}•${BGREEN} ] $1${RESET}"
}

# Virtualization check (function).
virt_check () {
    hypervisor=$(systemd-detect-virt)
    case $hypervisor in
        oracle )    info_print "VirtualBox has been detected, setting up guest tools."
                    pacstrap /mnt virtualbox-guest-utils &>/dev/null
                    systemctl enable vboxservice --root=/mnt &>/dev/null
                    ;;
    esac
}

########################
#
# Instalar dependecias
#
########################

# river es el wm
# ly es el gestor de sesinoes
# foot es la terminal
# polkit-gnome es para autenticarnos de modo gráfico
# waybar es la barra de estado
# wlr-randr es para ver el estado de nuestras pantallas
# kanshi es para configurarla de forma dinámica
# fuzzel es el lanzador
# swaybg es para el fondo de pantalla
# swaylock es para bloquear la pantalla
# swayidle es para controlar los periodos de inactividad
# swaync es para centro de notificaciones
# udiskie es para dispositivos externos, pendrives, etc

## FUENTES
# otf-font-awesome es para tener íconos para el waybar
# ttf-jetbrains-mono es para la terminal
# ttf-jetbrains-mono-nerd es para más íconos

# pavucontrol es para el control de volumen
# pamixer también es para control de volumen
# ufw como firewall
# grim para capturar pantallas
# slurp es para cortar regiones de pantalla
# wl-clipboard para portapapeles
# swappy es para editar capturas de pantalla
# ranger para editar ficheros en la terminal
# htop para monitorear el sistema
# lsd para darle color al ls
# firefox es el navegador
# file-roller es para archivos comprimidos
# pcmanfm es un gestor de archivos en gráfico
# mousepad es un editor de texto gráfico
# gvfs es como herramienta de sistema de archivos
# imv es para imágenes
# mpv es para videos
# nwg-look es para manejar los temas gtk
sudo pacman -S river ly foot polkit-gnome waybar wlr-randr kanshi fuzzel swaybg swaylock swayidle swaync udiskie otf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd pavucontrol pamixer ufw grim slurp wl-clipboard swappy ranger htop lsd firefox file-roller pcmanfm mousepad gvfs imv mpv nwg-look

sudo mkdir -p /usr/local/bin
sudo ln -s ./start-river /usr/local/bin/start-river
sudo chmod +x /usr/local/bin/start-river

sudo systemctl set-default graphical.target

sudo systemctl enable ly.service

# Associate our executable with river
sudo cp river.desktop /usr/share/wayland-sessions/river.desktop

# Enable firewall
sudo uwf enable

# Enable pipewire
systemctl --user enable pipewire
systemctl --user enable wireplumber

# Enable bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth


# Virtualization check.
virt_check

