#!/bin/sh
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ROSE="\\033[1;35m"
BLEU="\\033[1;34m"
BLANC="\\033[0;02m"
BLANCLAIR="\\033[1;08m"
JAUNE="\\033[1;33m"
CYAN="\\033[1;36m"

if [ $(id -u) != 0 ] ; then
  echo "Les droits de super-utilisateur (root) sont requis pour l'installation"
  echo "Veuillez lancer 'sudo $0' ou connectez-vous en tant que root, puis relancez $0"
  exit 1
fi

step_1_upgrade() {
  echo "---------------------------------------------------------------------"
  echo "${JAUNE}Commence l'étape 1 | Mise a jour du système.${NORMAL}"

  apt-get update
  apt-get full-upgrade -y
  echo "${VERT}Mise a jour réussie.${NORMAL}"
}

step_2_mainpackage() {
  echo "---------------------------------------------------------------------"
  echo "${JAUNE}CInstallation des logiciel de base.${NORMAL}"
  add-apt-repository non-free
  apt-get update
  apt-get -y install sudo
  apt-get -y install curl
  apt-get -y install htop
  apt-get -y install wget
  apt-get -y install dpkg
  apt-get -y install unzip
  
  echo "${VERT}Tout les logiciel ont été installer${NORMAL}"
}

STEP=0
VERSION=V1-Test
INSTALLATION_TYPE='standard'

while getopts ":s:v:m:i:" opt; do
  case $opt in
    s) STEP="$OPTARG"
    ;;
    v) VERSION="$OPTARG"
    ;;
    i) INSTALLATION_TYPE="$OPTARG"
    ;;
    \?) echo "${ROUGE}Option invalide -$OPTARG${NORMAL}" >&2
    ;;
  esac
done

echo "${JAUNE}Scripte d'installation ~GaminGo~${NORMAL}"
echo "${JAUNE}Version de l'installeur : ${VERSION}${NORMAL}"
echo "${JAUNE}Installation type : ${INSTALLATION_TYPE}${NORMAL}"

case ${STEP} in
  0)
  echo "${JAUNE}Commence toutes les étapes de l'installation${NORMAL}"
  step_1_upgrade
  step_2_mainpackage

  echo "Installation finie. Un redémarrage devrait être effectué"
  ;;
  1) step_1_upgrade
  ;;
  2) step_2_mainpackage
  *) echo "${ROUGE}Désolé, Je ne peux sélectionner une ${STEP} étape pour vous !${NORMAL}"
  ;;
esac
exit 0