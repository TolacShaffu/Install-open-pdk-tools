#!/bin/bash

# Fonction pour afficher un message et attendre la validation de l'utilisateur
function user_verification {
    echo "--------------------------------------------------"
    echo "$1"
    echo "Appuyez sur 'c' pour continuer ou 'q' pour quitter."
    read -r choice
    if [ "$choice" == "q" ]; then
        echo "Installation interrompue par l'utilisateur."
        exit 0
    elif [ "$choice" != "c" ]; then
        echo "Choix invalide. Veuillez entrer 'c' pour continuer ou 'q' pour quitter."
        user_verification "$1"
    fi
}
cd
# Étape 1: Installation des dépendances
echo "Installation des dépendances..."
sudo apt-get install -y build-essential
sudo apt-get install -y qtbase5-dev qttools5-dev
sudo apt-get install -y clang cmake libtool autoconf
sudo apt-get install -y python3 python3-dev python3-pip python3-virtualenv python3-venv
sudo apt-get install -y ruby ruby-dev

sudo apt-get install -y btop tree xterm graphviz git
sudo apt-get install -y octave

sudo apt-get install -y python3-sphinx python3-sphinx-autoapi python3-pandas python3-tk python3-pytest
sudo apt-get install -y libqt5xmlpatterns5-dev qtmultimedia5-dev libqt5multimediawidgets5 libqt5svg5-dev libqt5opengl5
sudo apt-get install -y tcl8.6 tcl-dev tcl8.6-dev
sudo apt-get install -y tk8.6 tk8.6-dev
sudo apt-get install -y flex clang gawk xdot pkg-config bison curl help2man perl time
sudo apt-get install -y libxpm4 libxpm-dev libgtk-3-dev libffi-dev
sudo apt-get install -y libjpeg-dev libfl-dev libfl2
sudo apt-get install -y libreadline-dev gettext
sudo apt-get install -y libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev
sudo apt-get install -y libx11-6 libx11-dev
sudo apt-get install -y libxrender1 libxrender-dev
sudo apt-get install -y libxcb1 libx11-xcb-dev
sudo apt-get install -y libcairo2 libcairo2-dev libxaw7-dev
sudo apt-get install -y libgz libfl2 libfl-dev zlibc zzlib1g zlib1g-dev libz-dev libgit2-dev
sudo apt-get install -y libgoogle-perftools-dev
sudo apt-get install -y gengetopt groff pod2pdf libhpdf-dev
sudo apt-get install -y libfftw3-dev
sudo apt-get install -y libxml-libxml-perl libgd-perl
sudo apt-get install -y libsuitesparse-dev gfortran swig libspdlog-dev libeigen3-dev liblemon-dev

sudo apt-get install -y gperf

user_verification "Dépendances installées. Continuer ?"

# Étape 2: Création des répertoires
echo "Création des répertoires..."
cd
mkdir microelectronics
cd microelectronics
mkdir PDK
mkdir projects
mkdir tools
mkdir tools_sources
cd PDK
mkdir IHP
cd ..
cd projects
git clone https://github.com/TolacShaffu/Projet_ZigBee.git
cd

user_verification "Répertoires créés. Continuer ?"

# Étape 3: Installation de IHP
echo "Installation de IHP..."
# Ajoutez ici les commandes pour installer IHP
cd microelectronics/PDK/IHP
git clone --recursive https://github.com/IHP-GmbH/IHP-Open-PDK.git
cd IHP-Open-PDK
echo "export PDK_ROOT=\$HOME/your_directory/IHP-Open-PDK" >> ~/.bashrc
echo "export PDK=ihp-sg13g2" >> ~/.bashrc
echo "export KLAYOUT_PATH=\"\$HOME/.klayout:\$PDK_ROOT/\$PDK/libs.tech/klayout\"" >> ~/.bashrc
echo "export KLAYOUT_HOME=\$HOME/.klayout" >> ~/.bashrc
source ~/.bashrc

user_verification "IHP installé. Continuer ?"

# Étape 4: Tirage de Openvaf
echo "Tirage de Openvaf..."
# Ajoutez ici les commandes pour tirer Openvaf

cd ~microelectronics/tools
wget https://datashare.tu-dresden.de/s/deELsiBGyitSS3o/download/openvaf_devel-x86_64-unknown-linux-gnu.tar.gz
tar -xzf openvaf_23_5_0_linux_amd64.tar.gz
sudo chmod +x openvaf

user_verification "Openvaf tiré. Continuer ?"

# Étape 5: Installation de QUCS
echo "Installation de QUCS..."
# Ajoutez ici les commandes pour installer QUCS
cd
echo 'deb http://download.opensuse.org/repositories/home:/ra3xdh/xUbuntu_24.04/ /' | sudo tee /etc/apt/sources.list.d/home:ra3xdh.list
curl -fsSL https://download.opensuse.org/repositories/home:ra3xdh/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_ra3xdh.gpg > /dev/null
sudo apt update
sudo apt install -y qucs-s ngspice 

export PATH="$PATH:$HOME/microelectronics/tools/" >> ~/.bashrc
export PATH="$PATH:$HOME/microelectronics/tools/"
source ~/.bashrc

cd ~/microelectronics/PDK/IHP/IHP-Open-PDK/ihp-sg13g2/libs.tech/qucs
python3 install.py

qucs-s

user_verification "QUCS installé. Continuer ?"

# Étape 6: Vérification de l'utilisateur
user_verification "Vérification de l'utilisateur. Continuer ?"

# Étape 7: Installation de OpenEMS
echo "Installation de OpenEMS..."
# Ajoutez ici les commandes pour installer OpenEMS
cd
sudo apt install -y build-essential cmake git libhdf5-dev libvtk9-dev libboost-all-dev libcgal-dev libtinyxml-dev qtbase5-dev libvtk9-qt-dev python3-numpy python3-matplotlib cython3 python3-h5py python3-gdspy
cd ~microelectronics/tools_sources
git clone --recursive https://github.com/thliebig/openEMS-Project.git
cd openEMS-Project
./update_openEMS.sh ~/microelectronics/tools/openEMS --python
export PATH="$PATH:$HOME/microelectronics/tools/openEMS/bin" >> ~/.bashrc
export PATH="$PATH:$HOME/microelectronics/tools/openEMS/bin"

user_verification "OpenEMS installé. Continuer ?"
cd ~/microelectronics/PDK/IHP/IHP-Open-PDK/ihp-sg13g2/libs.tech/openems/testcase/SG13_Octagon_L2n0/OpenEMS_Python/
python3.12 SG13_L2n0_mesh1.5um_v2.py

# Étape 8: Vérification de l'utilisateur
user_verification "Vérification de l'utilisateur. Continuer ?"

# Étape 9: Installation de Klayout
echo "Installation de Klayout..."
# Ajoutez ici les commandes pour installer Klayout
sudo apt install klayout
mkdir -p  ~/.klayout/tech
ln -s ~/microelectronics/PDK/IHP/IHP-Open-PDK/ihp-sg13g2/libs.tech/klayout/tech ~/.klayout/tech/ihp-sg13g2
ln -s ~/.klayout/tech/ihp-sg13g2/sg13g2.lyp ~/.klayout/tech/
mkdir -p  ~/.klayout/python
ln -s ~/microelectronics/PDK/IHP/IHP-Open-PDK/ihp-sg13g2/libs.tech/klayout/python/* ~/.klayout/python/

user_verification "Klayout installé. Continuer ?"

klayout &
# Étape 10: Vérification de l'utilisateur
user_verification "Vérification de l'utilisateur. Continuer ?"

echo "Installation terminée avec succès."
