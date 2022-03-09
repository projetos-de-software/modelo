#!/bin/sh

###########################################################
#
#   Script Inicial para novos repositórios
#   @author Marcos de Lima Carlos <mlimacarlos@gmail.com>
#   @version 1.0
#
###########################################################

checarComandos(){
    if ! command -v node &> /dev/null
     then 
        echo "O NodeJS não está instalado no sitema"
        exit
    fi

    if ! command -v yarn &> /dev/null
     then
        echo "O Yarn não está instalado no sistema"
        exit
    fi

}

checarVersoes(){
   node="$(node --version | cut -c2-)"
   version_greater "$node" 10 || die "Versão do NodeJS precisa ser maior que 10"
}

version_greater(){
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

die() { echo "$*" 1>&2 ; exit 1; }

addScript(){

}

#########

# Yarn para iniciar um repositório respondendo tudo como default
yarn init -y 

# Instalando e configurando o commitlint
yarn add @commitlint/config-conventional @commitlint/cli -D

# Configuração do arquivo do commitlint
echo "module.exports = { extends: ['@commitlint/config-conventional'] };" > commitlint.config.js

# instalando Husky v6
yarn add husky -D

# ativando os hooks
yarn husky install

## Função que adiciona a linha script no json


# Add hook que vai disparar o commitlint
yarn husky add .husky/commit-msg 'yarn commitlint --edit $1'

