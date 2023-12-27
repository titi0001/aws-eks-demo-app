#!/bin/bash

# Solicitar valores ao usuário
read -p "Digite o nome do cluster: " CLUSTER_NAME
read -p "Digite o ARN do papel IAM: " ROLE_ARN
read -p "Digite as IDs das sub-redes (separadas por vírgula): " SUBNET_IDS

# Converter a string de sub-redes para um array
IFS=',' read -ra SUBNET_ARRAY <<< "$SUBNET_IDS"
SUBNET_IDS_ARG="[\"$(IFS=\",\"; echo "${SUBNET_ARRAY[*]}")\"]"

# Comando para criar o cluster
aws eks create-cluster \
    --name $CLUSTER_NAME \
    --role-arn $ROLE_ARN \
    --resources-vpc-config subnetIds=$SUBNET_IDS_ARG