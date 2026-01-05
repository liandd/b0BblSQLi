#!/bin/bash
#Author: Juan Garcia aka liandd

#Colours
greenColour="\e[0;32m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m"
blueColour="\e[0;34m"
yellowColour="\e[0;33m"
purpleColour="\e[0;35m"
turquoiseColour="\e[0;36m"
grayColour="\e[0;37m"

#Ctrl_C
trap ctrl_c INT

function ctrl_c() {
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm && exit 1
}

function helpPanel() {
  echo -e "\n${yellowColour}[!]${endColour}${grayColour} Uso: ${endColour}${greenColour}$0${endColour} ${purpleColour}-u${endColour} ${blueColour}\"<url.../id=1\"${endColour}\n"
  echo -e "\t${purpleColour}u)${endColour} ${grayColour}Direccion url en donde se encuentra el parametro vulnerable a SQLi${endColour}"
  echo -e "\t${purpleColour}h)${endColour} ${grayColour}Panel de ayuda${endColour}"
}

while getopts "u:h" arg; do
  case $arg in
  u) url=$OPTARG ;;
  h) ;;
  esac
done
if [[ $url ]]; then
  booleanblindsqli "$url"
else
  helpPanel
fi
