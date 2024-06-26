#!/usr/bin/env bash
set -e




# -------------- Files and Directories ------------------ #

DOWNLOAD_DIR="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"


# ------ Colors ------- #

RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'


# ------------------- Functions -------------------- #

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# ___________________ Reqs and Tests _______________ #

# Internet connection
connection_test(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${RED}[ERROR] - No internet connection$
  NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Good internet connection$
  NO_COLOR}"
fi
}

# ------------------------------------------------------------------------------ #


# Removing apt locks
apt_lock() {
  while sudo fuser /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do
    echo -e "${RED}[AVISO] - Other process using apt. On hold..."$
    NO_COLOR}
    sleep 1
  done
  sudo rm -f /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/cache/apt/archives/lock
}

# Adding 32bits arch
add_archi386(){
sudo dpkg --add-architecture i386
}
## Atualizando o repositório ##
just_apt_update(){
sudo apt update -y
}

# ---------------- Deb apps to install ----------------- #

DEBS_INSTALL=(
  snapd
  winff
  virtualbox
  timeshift
  gufw
  synaptic
  code
  gnome-sushi
  folder-color
  git
  thunderbird
  gimp
  wget
  ubuntu-restricted-extras
  gparted

)

# Download and install Deb apps

install_debs(){

echo -e "${GREEN}[INFO] - Downloading .debs${NO_COLOR}"

mkdir "$DOWNLOAD_DIR"

# Install apt apps
echo -e "${GREEN}[INFO] - Instalando pacotes apt do repositório${NO_COLOR}"

for app_name in ${DEBS_INSTALL[@]}; do
  if ! dpkg -l | grep -q $app_name; then # Only install if not installed
    sudo apt install "$app_name" -y
  else
    echo "[INSTALADO] - $app_name"
  fi
done

}
# Installing Flatpaks
install_flatpaks(){

  echo -e "${GREEN}[INFO] - Installing Flatpaks${NO_COLOR}"

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.freedesktop.Piper -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub com.bitwig.BitwigStudio -y
flatpak install flathub com.dropbox.Client -y
flatpak install flathub com.github.KRTirtho.Spotube -y
flatpak install flathub com.github.wwmm.pulseeffects -y
flatpak install flathub com.nextcloud.desktopclient.nextcloud -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.stremio.Stremio -y
flatpak install flathub dev.storyapps.starc -y
flatpak install flathub io.github.Bavarder.Bavarder -y
flatpak install flathub io.github.fsobolev.TimeSwitch -y
flatpak install flathub io.missioncenter.MissionCenter -y
flatpak install flathub io.unobserved.espansoGUI -y
flatpak install flathub nz.mega.MEGAsync -y
flatpak install flathub org.gnome.World.PikaBackup -y
flatpak install flathub org.zotero.Zotero -y
flatpak install flathub com.librumreader.librum -y
flatpak install flathub org.gnome.DejaDup -y
flatpak install flathub net.cozic.joplin_desktop -y
flatpak install flathub me.hyliu.fluentreader -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub io.gitlab.news_flash.NewsFlash -y
flatpak install flathub com.vixalien.sticky -y
flatpak install flathub com.logseq.Logseq -y
flatpak install flathub com.elsevier.MendeleyDesktop -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.authy.Authy -y
flatpak install flathub com.anydesk.Anydesk -y
flatpak install flathub org.upscayl.Upscayl -y
flatpak install flathub md.obsidian.Obsidian -y

}

# Installing Espanso
install_espanso(){
  
  echo -e "${GREEN}[INFO] - Installing Espanso and setting services${NO_COLOR}"

wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
sudo apt install ./espanso-debian-x11-amd64.deb
espanso service register

# Start espanso
espanso start
}

# ----------------------------- Post Install ----------------------------- #

# Clean and updates

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}

# ----------------------------- Extra Configs ----------------------------- #

# Productivity folders on Nautilus
extra_config(){

mkdir /home/$USER/TEMP
mkdir /home/$USER/AppImage
mkdir /home/$USER/Vídeos/'OBS Rec'

#Adiciona atalhos ao Nautilus

if test -f "$FILE"; then
    echo "$FILE already exist"
else
    echo "$FILE creating..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/AppImage" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE
}

# ----------------- Executions ------------------ #

apt_lock
connection_test
apt_lock
apt_update
apt_lock
add_archi386
just_apt_update
install_debs
install_flatpaks
extra_config
apt_update
system_clean

# Finishing

echo -e "${GREEN}[INFO] - Script finalizado, instalação concluída! :)${NO_COLOR}"