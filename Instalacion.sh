#!/bin/bash

#Autor: Tomas Dominguez

#Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
espacio="\n"
trap ctrl_c INT

ctrl_c(){
  echo ""
  echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
  sleep 1
  exit 1
}

clear
echo "                   _                 _         "
echo "             _   _| |__  _   _ _ __ | |_ _   _ "
echo "            | | | | '_ \| | | | '_ \| __| | | |"
echo "            | |_| | |_) | |_| | | | | |_| |_| |"
echo "             \__,_|_.__/ \__,_|_| |_|\__|\__,_|"
echo -e "    Mi Setup Ubuntu 20.04 Tomas Dominguez - Mi primer script :P\n \n \n"
echo -e " ${turquoiseColour}\t\t\t\t\tLista de paquetes a instalar \n -Terminator(Terminal)\n -Discord \n -Visual Studio Code \n -VLC \n -Ubuntu restricted \n -GitHub \n -Gnome Tweeks \n -Paquetes de Compresion: [rar, unrar, p7zip-full, p7zip-rar] \n -Wine \n -OpenJDK-11 Java \n -Net Tools \n \n ${endColour}"
echo -e "${purpleColour}\t\t\t\t\tLista de cambios visuales\n -Cambia el Theme a oscuro \n -Cambia de Lugar el dock y otras configs \n -Esconde el basurero del Desktop \n -Esconde la carpeta de user en Desktop \n -Nunca se apaga la pantalla\n\n\n${endColour}"

read -r -p "  [1] Instalacion de VM Rapida (Update y Upgrade + Reboot Opcional) $( echo -e " $espacio ") [2] Actualizar e instalar los paquetes dentro del script (Sistema principal) $( echo -e " $espacio " ) [3] Cambios visuales e internos (General) $( echo -e " $espacio ") [4] DEBUG $( echo -e " $espacio $espacio ") Tu Eleccion: " eleccion
answer=N
if [[ "$eleccion" == "2" ]]; then
  echo ""
  read -p "Reiniciar maquina despues de instalar todo? [Y/N]" rebot
fi

reiniciar(){
segundos=5
  while [[ "$segundo" -gt "0" ]]
    do
    sleep 1
    echo -e "${redColour}$segundo Segundos para el reinicio \n${endColour}"
    ((segundo--))
    if [[ "$segundo" -eq "0" ]]; then
      echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
      sleep 1
      echo "Reboot"
    fi
  done
}

case "$eleccion" in
  [1])
    clear
    echo -e "${greenColour}\n\n-------------------- Actualizando --------------------\n${endColour}"
    sudo apt -y update 
    sudo apt-get -y dist-upgrade
    sudo apt -y upgrade
    echo -e "${redColour}-------------------- FIN DE LA INSTALACION --------------------\n\n${endColour}"
    read -p "Queres reiniciar el sistema ahora mismo? [Y/N]: " rebot
    ;;
  [2]) #Si, ya se que no es la manera mas optima para instalar paquetes, pero me gusta la visual de cada paquete instalandose
    clear
    echo -e " ${greenColour}-------------------- Instalando actualizaciones --------------------${endColour}"
    # touch ./Logs.txt   ToDo -> Hacer logs de todo lo que hace el script para debug
    sleep 1
    sudo apt -y update
    echo -e "${greenColour}-------------------- Instalando Upgrades --------------------${endColour}"
    sleep 1
    sudo apt -y upgrade
    sudo apt-get dist-upgrade
    echo
    echo -e "${yellowColour}-------------------- Instalando TERMINATOR --------------------${endColour}"
    sleep 1
    sudo apt -y install terminator
    echo
    echo -e "${yellowColour}-------------------- Instalando Visual Studio Code --------------------${endColour}"
    sleep 1
    sudo apt -q install software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt -y install code
    echo
    echo -e "${yellowColour}-------------------- Instalando VLC --------------------${endColour}"
    sleep 1
    sudo snap install vlc
    echo
    echo -e "${yellowColour}-------------------- UBUNTU RESTRICTED --------------------${endColour}"
    sleep 1
    sudo apt -y install ubuntu-restricted-extras
    echo
    echo -e "${yellowColour}-------------------- GNOME TWEEKS --------------------${endColour}"
    sleep 1
    sudo apt -y install gnome-tweaks
    echo
    echo -e "${yellowColour}-------------------- Paquetes de Compresión --------------------${endColour}"
    sleep 1
    sudo apt -y install rar unrar p7zip-full p7zip-rar
    echo
    echo -e "${yellowColour}-------------------- WINE --------------------${endColour}"
    sleep 1
    sudo apt -y install wine winetricks
    echo
    echo -e "${yellowColour}-------------------- OPENJDK-11 JAVA --------------------${endColour}"
    sleep 1
    sudo apt-get -y install openjdk-11-jdk
    echo
    echo -e "${yellowColour}-------------------- NET TOOLS --------------------${endColour}"
    sleep1
    sudo apt -y install net-tools
    echo
    echo -e "${yellowColour}-------------------- Discord --------------------${endColour}"
    sudo snap install discord
    echo
    echo -e "${yellowColour}-------------------- Steam --------------------${endColour}"
    sudo add-apt-repository multiverse
    sudo apt -y install steam
    echo
    echo -e "${yellowColour}-------------------- GitHub --------------------${endColour}"
    sudo apt install git
    echo
    echo -e "${redColour}\n-------------------- FIN DE LA INSTALACION --------------------\n\n${endColour}"
    ;;
  [3]) #ToDo -> Poner mejoras y aprender un poco mas del tweeks. Tambien estaria bueno mostrar cambio por cambio, pero tal vez no (?)
    echo -e "-------------------- Configuraciones internas de Ubuntu --------------------"
    clear
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # Cambia de Lugar el dock
    dconf write /org/gnome/desktop/interface/gtk-theme '"Yaru-dark"' #Cambia el Theme a oscuro
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'steam.desktop','code.desktop']" #Agrega steam, Visual Studio a Favoritos
    dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 40 #Cambia de tamaño los iconos
    dconf write /org/gnome/desktop/session/idle-delay "uint32 0" #Nunca se apaga la pantalla
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED #Arriba y abajo, todo sobre el dock
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
    gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false 
    dconf write /org/gnome/shell/extensions/desktop-icons/show-home false # Esconde la carpeta de home en desktop
    dconf write /org/gnome/shell/extensions/desktop-icons/show-home true # Esconde el basurero de home en Desktop
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false # Esconde el dock
    ;;
  [4])
    echo -e "Test"
    rebot=N
    ;;
esac

if [[ "${rebot^^}" == "Y" ]]; then   # ^^ -> Lo que tenga rebot, lo pasa a mayusculas sin modificar la variable
  reiniciar
elif [[ "${rebot^^}" == "N" ]]; then
  echo -e "\n${redColour}[!] Saliendo...\n${endColour}"
  sleep 1
else
    echo -e "\n${redColour}[!] Error, Saliendo...\n${endColour}"
fi
