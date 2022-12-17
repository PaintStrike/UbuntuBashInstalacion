#!/bin/bash

#Autor: Tomas Dominguez
#
#Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
espacio="\n"

trap ctrl_c INT

ctrl_c(){
  echo ""
  echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
  exit 1
}

clear
echo -e " ${yellowColour}                 _                 _         "
echo -e "             _   _| |__  _   _ _ __ | |_ _   _ "
echo -e "            | | | | '_ \| | | | '_ \| __| | | |"
echo -e "            | |_| | |_) | |_| | | | | |_| |_| |"
echo -e "             \__,_|_.__/ \__,_|_| |_|\__|\__,_|"
echo -e "    Mi Setup Ubuntu 20.04 Tomas Dominguez \n \n \n${endColour}"
echo -e " ${turquoiseColour}Lista de paquetes a instalar:
  -VirtualBox 
  -Terminator(Terminal)
  -Python 
  -Pip 
  -Htop
  -Vim
  -TorNetwork
  -Discord
  -ShellCheck 
  -Visual Studio Code
  -VLC 
  -Ubuntu restricted 
  -GitHub 
  -Gnome Tweeks 
  -Paquetes de Compresion: [rar, unrar, p7zip-full, p7zip-rar] 
  -OpenJDK-11 Java 
  -Net Tools \n ${endColour}"
echo -e "${purpleColour}\t\tLista de cambios visuales 
  -Cambia el Theme a oscuro
  -Cambia el background
  -Cambia de Lugar el dock y otras configs 
  -Esconde el basurero del Desktop 
  -Esconde la carpeta de user en Desktop 
  -Nunca se apaga la pantalla${endColour}\n"

echo -e "  [1] Instalacion de VM Rapida (Update y Upgrade + Reboot Opcional)
  [2] Actualizar e instalar los paquetes dentro del script (Sistema principal)
  [3] Cambios visuales e internos (General)
  [4] DEBUG \n"
read -r -p " Tu Eleccion: " eleccion

if [[ "$eleccion" == "2" ]]; then
  echo ""
  read -r -p "Reiniciar maquina despues de la instalacion [Y/N]" rebot
fi

reiniciar(){
segundos=5
  while [[ "$segundos" -gt "0" ]];do
    sleep 1
    echo -e "${redColour}\t [!] Reinicio en: $segundos \n${endColour}"
    ((segundos--))
    if [[ "$segundos" -eq "0" ]]; then
      echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
      shutdown -r now
    fi
  done
}

actualizar(){
  sudo apt -y update
  sudo apt-get -y dist-upgrade
  sudo apt -y upgrade
}

instalar(){
lista_paquetes=("terminator" "vlc" "gnome-tweaks" "rar" "unrar" "p7zip-full" "p7zip-rar" "openjdk-11-jdk" "net-tools" "git" "shellcheck" "htop" "vim" "curl" "virtualbox" "python3-pip")
for paquete in "${lista_paquetes[@]}"; do
  echo -e "\n${yellowColour}Instalando: ${paquete%%_*}...${endColour}\n"
  sudo apt install -y "${paquete}"
  sleep 1
done
}

tweeks(){
  sudo echo #Pide permiso de administrador
  read -r -p "$( echo -e " $espacio ")¿Cambiar fondo de pantalla? (Se necesita connecion a internet) [Y/N] $( echo -e " $espacio ") $( echo -e " $espacio ") Tu Eleccion: " internet  #Pregunta si tenes internet para el fondo
  echo -e "${greenColour}Configuraciones internas de Ubuntu...${endColour}\n"
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Cambia de Lugar el dock
  echo -e "${greenColour}[✓] ${endColour}Cambiar de Lugar el Dock"
  dconf write /org/gnome/desktop/interface/gtk-theme '"Yaru-dark"' #Cambia el Theme a oscuro
  echo -e "${greenColour}[✓] ${endColour}Cambiar al Dark Theme"
  gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'steam.desktop','code.desktop']" #Agrega steam, Visual Studio a Favoritos
  echo -e "${greenColour}[✓] ${endColour}Agregar a favoritos diferentes apps"
  dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 40 #Cambia de tamaño los iconos
  echo -e "${greenColour}[✓] ${endColour}Cambiar el tamaño de los iconos"
  dconf write /org/gnome/desktop/session/idle-delay "uint32 0" #Nunca se apaga la pantalla
  echo -e "${greenColour}[✓] ${endColour}La pantalla nunca se apaga"
  gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
  gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED #Arriba y abajo, todo sobre el dock
  gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
  gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false 
  echo -e "${greenColour}[✓] ${endColour}El Dock ahora se ve mucho mejor"
  dconf write /org/gnome/shell/extensions/desktop-icons/show-home false # Esconde la carpeta de home en desktop
  echo -e "${greenColour}[✓] ${endColour}Carpeta \"$USER\" ya no es visible en el escritorio"
  dconf write /org/gnome/shell/extensions/desktop-icons/show-trash false # Esconde el basurero de home en Desktop
  echo -e "${greenColour}[✓] ${endColour}El Basurero ya no es visible en el escritorio"
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false # Esconde el dock
  echo -e "${greenColour}[✓] ${endColour}El dock ahora se esconde cada vez que abris una aplicacion.\n"
  if [[ "${internet^^}" == "Y" ]];then
    wget -qcP /home/"$USER"/Pictures/ https://www.hdwallpaper.nu/wp-content/uploads/2019/01/rick_and_morty-18.png
    echo -e "${greenColour}[✓] ${endColour}Fondo de pantalla cambiado"
    gsettings set org.gnome.desktop.background picture-options 'zoom' # Estilo de fondo "Zoom/Center/"
    gsettings set org.gnome.desktop.background picture-uri 'file:///home/'"$USER"'/Pictures/rick_and_morty-18.png' #Cambia fondo de pantalla a RICK-Gris # Necesitas coneccion a internet.
    gsettings set org.gnome.desktop.background primary-color '#000000' # Cambia color primary a 0
  fi
  }

#Menu
case "$eleccion" in
  [1])
    clear
    sudo echo
    clear
    echo -e "${greenColour}\n\nActualizando...\n${endColour}"
    actualizar 
    echo -e "${redColour}FIN DE LA INSTALACION \n\n${endColour}"
    read -r -p "Queres reiniciar el sistema ahora mismo? [Y/N]: " rebot
    ;;
  [2])
    read -r -p "Agregar cambios visuales al finalizar la instalacion? [Y/N]: " visual
    echo -e " ${greenColour}Instalando actualizaciones...${endColour}"
    actualizar
    echo
    instalar
    echo
    echo -e "${yellowColour}Instalando Discord...${endColour}"
    echo -e "Es normal que tarde un poquito..."
    sudo snap install discord
    echo "Done"
    echo -e "${yellowColour}Instalando Visual Studio...${endColour}"
    wget -P /home/$USER/Downloads https://az764295.vo.msecnd.net/stable/f80445acd5a3dadef24aa209168452a3d97cc326/code_1.64.2-1644445741_amd64.deb
    sudo apt -y install /home/$USER/Downloads/code*.deb
    echo "Done"
    sleep 1
    if [[ "${visual^^}" == "Y" ]]; then
      tweeks
    fi
    actualizar
    sudo apt -y autoremove
    echo -e "${redColour}\nFIN DE LA INSTALACION\n${endColour}"
    ;;
  [3]) #ToDo -> Poner mejoras y aprender un poco mas del tweeks. Tambien estaria bueno mostrar cambio por cambio
    tweeks
    exit
    ;;
  [4])
    echo "Nothing here"
    ;;
esac

if [[ "${rebot^^}" == "Y" ]]; then   # ^^ -> Lo que tenga rebot, lo pasa a mayusculas sin modificar la variable
  reiniciar
elif [[ "${rebot^^}" == "N" || "${internet^^}" == "N" ]]; then
  echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
  sleep 1
else
    echo -e "\n${redColour}[!] Error, Saliendo...\n${endColour}"
fi
