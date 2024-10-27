#!/bin/bash

# Solicitar valores ao usuário
read -p "Digite o nome do cluster: " CLUSTER_NAME
read -p "Digite o código da região (por exemplo, us-west-2): " REGION

# Verificar se eksctl está instalado
if ! command -v eksctl &> /dev/null; then
    echo "eksctl não está instalado. Instalando eksctl..."
    
    # Instalar eksctl usando o script de instalação do site oficial
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
fi

# Comando para criar o cluster usando eksctl
eksctl create cluster --name $CLUSTER_NAME --region $REGION --fargate

echo "Cluster $CLUSTER_NAME criado com sucesso usando eksctl."
