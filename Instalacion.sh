#!/bin/bash

#Autor: Tomas Dominguez

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
echo -e "    Mi Setup Ubuntu 20.04 Tomas Dominguez - Mi primer script :P\n \n \n${endColour}"
echo -e " ${turquoiseColour}\t\tLista de paquetes a instalar \n -VirtualBox \n -Terminator(Terminal)\n -Python - Pip \n-Htop\n -Vim \n -TorNetwork\n -Discord\n -ShellCheck \n -Visual Studio Code \n -VLC \n -Ubuntu restricted \n -GitHub \n -Gnome Tweeks \n -Paquetes de Compresion: [rar, unrar, p7zip-full, p7zip-rar] \n -Wine \n -OpenJDK-11 Java \n -Net Tools \n \n ${endColour}"
echo -e "${purpleColour}\t\tLista de cambios visuales \n\n -Cambia el Theme a oscuro\n -Curl \n -Cambia el background \n -Cambia de Lugar el dock y otras configs \n -Esconde el basurero del Desktop \n -Esconde la carpeta de user en Desktop \n -Nunca se apaga la pantalla\n\n\n${endColour}"
read -r -p "  [1] Instalacion de VM Rapida (Update y Upgrade + Reboot Opcional) $( echo -e " $espacio ") [2] Actualizar e instalar los paquetes dentro del script (Sistema principal) $( echo -e " $espacio " ) [3] Cambios visuales e internos (General) $( echo -e " $espacio ") [4] DEBUG $( echo -e " $espacio $espacio ") Tu Eleccion: " eleccion

if [[ "$eleccion" == "2" ]]; then
  echo ""
  read -r -p "Reiniciar maquina despues de instalar todo? [Y/N]" rebot
fi

reiniciar(){
segundos=5
  while [[ "$segundos" -gt "0" ]]
    do
    sleep 1
    echo -e "${redColour}\t [!] Reinicio en: $segundos \n${endColour}"
    ((segundos--))
    if [[ "$segundos" -eq "0" ]]; then
      echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
      shutdown -r now
    fi
  done
}

case "$eleccion" in
  [1])
    clear
    sudo echo
    echo -e "${greenColour}\n\n-------------------- Actualizando --------------------\n${endColour}"
    sudo apt -y update 
    sudo apt-get -y dist-upgrade
    sudo apt -y upgrade
    echo -e "${redColour}-------------------- FIN DE LA INSTALACION --------------------\n\n${endColour}"
    read -r -p "Queres reiniciar el sistema ahora mismo? [Y/N]: " rebot
    ;;
  [2]) #Si, ya se que no es la manera mas optima para instalar paquetes, pero me gusta la visual de cada paquete instalandose
    clear
    sudo echo
    echo -e " ${greenColour}-------------------- Instalando actualizaciones --------------------${endColour}"
    # touch ./Logs.txt   ToDo -> Hacer logs de todo lo que hace el script para debug
    sudo apt -y update
    echo -e "${greenColour}-------------------- Instalando Upgrades --------------------${endColour}"
    sudo apt -y upgrade
    sudo apt-get dist-upgrade
    echo
    echo -e "${yellowColour}-------------------- Instalando TERMINATOR --------------------${endColour}"
    sudo apt -y install terminator
    echo
    echo -e "${yellowColour}-------------------- Instalando Visual Studio Code --------------------${endColour}"
    sudo apt -y install software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt -y install code
    echo
    echo -e "${yellowColour}-------------------- Instalando VLC --------------------${endColour}"
    sudo apt -y install vlc
    echo
    echo -e "${yellowColour}-------------------- UBUNTU RESTRICTED --------------------${endColour}"
    sudo apt -y install ubuntu-restricted-extras
    echo
    echo -e "${yellowColour}-------------------- GNOME TWEEKS --------------------${endColour}"
    sudo apt -y install gnome-tweaks
    echo
    echo -e "${yellowColour}-------------------- Paquetes de Compresión --------------------${endColour}"
    sudo apt -y install rar unrar p7zip-full p7zip-rar
    echo
    echo -e "${yellowColour}-------------------- WINE --------------------${endColour}"
    sudo apt -y install wine winetricks
    echo
    echo -e "${yellowColour}-------------------- OPENJDK-11 JAVA --------------------${endColour}"
    sudo apt-get -y install openjdk-11-jdk
    echo
    echo -e "${yellowColour}-------------------- NET TOOLS --------------------${endColour}"
    sudo apt -y install net-tools
    echo
    echo -e "${yellowColour}-------------------- Discord --------------------${endColour}"
    echo -e "Es normal que tarde un poquito..."
    sudo snap install discord
    echo
    echo -e "${yellowColour}-------------------- Steam --------------------${endColour}"
    sudo add-apt-repository multiverse
    sudo apt -y install steam
    echo
    echo -e "${yellowColour}-------------------- GitHub --------------------${endColour}"
    sudo apt install git
    echo
    echo -e "${yellowColour}-------------------- ShellCheck --------------------${endColour}"  
    sudo apt -y install shellcheck  
    echo
    echo -e "${yellowColour}-------------------- TorNetwork --------------------${endColour}" 
    echo
    echo -e "Descargando tor-browser-linux64-11.0_en-US.tar.xz..."; wget -qcP /home/$USER/Downloads/ https://dist.torproject.org/torbrowser/11.0/tor-browser-linux64-11.0_en-US.tar.xz;echo "Descarga completada, descomprimiendo y llevando al Desktop"; sleep 1; xz -d /home/$USER/Downloads/tor-browser-linux64-11.0_en-US.tar.xz; tar -xvf /home/$USER/Downloads/tor-browser-linux64-11.0_en-US.tar; rm -rf /home/$USER/Downloads/tor-browser-linux64-11.0_en-US.tar;
    echo -e "${yellowColour}-------------------- Htop --------------------${endColour}" 
    sudo apt -y install htop
    echo -e "${yellowColour}-------------------- Vim --------------------${endColour}" 
    sudo apt -y install vim
    echo -e "${yellowColour}-------------------- Curl --------------------${endColour}" 
    sudo apt -y install curl
    echo -e "${yellowColour}-------------------- VirtualBox --------------------${endColour}" 
    sudo apt -y install virtualbox
    sudo apt -y install virtualbox-ext-pack
    echo -e "${yellowColour}-------------------- Python3-Pip --------------------${endColour}"
    sudo apt -y install python3-pip
    echo -e "${redColour}\n-------------------- FIN DE LA INSTALACION --------------------\n\n${endColour}"
    ;;
  [3]) #ToDo -> Poner mejoras y aprender un poco mas del tweeks. Tambien estaria bueno mostrar cambio por cambio, pero tal vez no (?)
    sudo echo
    read -r -p "$( echo -e " $espacio ")¿Cambiar fondo de pantalla? (Se necesita connecion a internet) [Y/N] $( echo -e " $espacio ") $( echo -e " $espacio ") Tu Eleccion: " internet  #Pregunta si tenes internet para el fondo
    echo -e "${greenColour}-------------------- Configuraciones internas de Ubuntu --------------------${endColour}\n"
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
      wget -qcP /home/$USER/Pictures/ https://www.hdwallpaper.nu/wp-content/uploads/2019/01/rick_and_morty-18.png
      echo -e "${greenColour}[✓] ${endColour}Fondo de pantalla cambiado"
      gsettings set org.gnome.desktop.background picture-options 'zoom' # Estilo de fondo "Zoom/Center/"
      gsettings set org.gnome.desktop.background picture-uri 'file:///home/tomas/Pictures/rick_and_morty-18.png' #Cambia fondo de pantalla a RICK-Gris # Necesitas coneccion a internet.
      gsettings set org.gnome.desktop.background primary-color '#000000' # Cambia color primary a 0
    fi
    exit
    ;;
  [4])
    sudo apt-get -f install
    rebot=y
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
