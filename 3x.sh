#!/bin/bash

green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

echo -e "${green}Скачиваю оригинальный скрипт установки x-ui...${plain}"
curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh -o install-x-ui-original.sh

echo -e "${green}Модифицирую скрипт для автоматической установки без запроса порта...${plain}"

cp install-x-ui-original.sh install-x-ui-auto.sh

# Полная замена интерактивного блока на автоматический
sed -i '/read -rp "Would you like to customize the Panel Port settings?/,/\/usr\/local\/x-ui\/x-ui setting -username/c\
            local config_port=$(shuf -i 1024-62000 -n 1)\n\
            echo -e "${yellow}Automatically selected random port: ${config_port}${plain}"\n\
            /usr/local/x-ui/x-ui setting -username \"${config_username}\" -password \"${config_password}\" -port \"${config_port}\" -webBasePath \"${config_webBasePath}\"' install-x-ui-auto.sh

# Удалим возможные символы \r, если они были (на случай повторного запуска из Windows-среды)
sed -i 's/\r$//' install-x-ui-auto.sh

# Запуск модифицированного скрипта
chmod +x install-x-ui-auto.sh
echo -e "${green}Запускаю установку x-ui...${plain}"
bash install-x-ui-auto.sh
