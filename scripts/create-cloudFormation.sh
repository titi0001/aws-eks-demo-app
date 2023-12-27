#!/bin/bash

# Solicita ao usuário que insira o nome da pilha
read -p "Digite o nome da pilha: " stack_name

# Pasta contendo os arquivos YAML no diretório pai
folder_path="../cloud-Formation"

# Verifica se a pasta existe
if [ ! -d "$folder_path" ]; then
  echo "Erro: A pasta '$folder_path' não foi encontrada."
  exit 1
fi

# Lista os arquivos YAML na pasta
files=("$folder_path"/*.yaml)

# Verifica se há arquivos YAML na pasta
if [ ${#files[@]} -eq 0 ]; then
  echo "Erro: Nenhum arquivo YAML encontrado na pasta '$folder_path'."
  exit 1
fi

# Constrói um menu interativo
PS3="Escolha um arquivo YAML digitando o número correspondente: "
select selected_file in "${files[@]}"; do
  if [ -n "$selected_file" ]; then
    # Extrai apenas o nome do arquivo do caminho completo
    template_file=$(basename "$selected_file")
    break
  else
    echo "Opção inválida. Tente novamente."
  fi
done

# Comando para criar a pilha usando AWS CLI e CloudFormation
aws cloudformation create-stack --stack-name "$stack_name" --template-body file://"$template_file"
