#!/usr/bin/env bash
set -e

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"




##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"


#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


#FUNÇÕES

# Atualizando repositório e fazendo atualização do sistema

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------------------------------------------------------- #
# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

# ------------------------------------------------------------------------------ #


## Removendo travas eventuais do apt ##
#travas_apt(){
  #sudo rm /var/lib/dpkg/lock-frontend
  #sudo rm /var/cache/apt/archives/lock
#}

## Adicionando/Confirmando arquitetura de 32 bits ##
add_archi386(){
sudo dpkg --add-architecture i386
}
## Atualizando o repositório ##
just_apt_update(){
sudo apt update -y
}

##DEB SOFTWARES TO INSTALL

PROGRAMAS_PARA_INSTALAR=(
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
 
)

# ---------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_debs(){

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"


## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

}
## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.obsproject.Studio -y
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


# -------------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #


## Finalização, atualização e limpeza##

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}


# -------------------------------------------------------------------------- #
# ----------------------------- CONFIGS EXTRAS ----------------------------- #

#Cria pastas para produtividade no nautilus
extra_config(){


mkdir /home/$USER/TEMP
mkdir /home/$USER/AppImage
mkdir /home/$USER/Vídeos/'OBS Rec'

#Adiciona atalhos ao Nautilus

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/AppImage" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE
}

# -------------------------------------------------------------------------------- #
# -------------------------------EXECUÇÃO----------------------------------------- #

#travas_apt
testes_internet
#travas_apt
apt_update
#travas_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
extra_config
apt_update
system_clean

## finalização

  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
