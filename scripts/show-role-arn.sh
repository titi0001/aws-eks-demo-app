#!/bin/bash

# Listar funções IAM com "eks" no nome e mostrar o ARN
roles=$(aws iam list-roles --query 'Roles[?contains(RoleName, `EKS`)].RoleName' --output json)

if [ -z "$roles" ]; then
  echo "Nenhuma função IAM com 'eks' no nome encontrada."
else
  for role in $(echo "$roles" | jq -r '.[]'); do
    arn=$(aws iam get-role --role-name "$role" --query 'Role.Arn' --output text)
    echo "Nome da função: $role"
    echo "ARN da função: $arn"
    echo "-----"
  done
fi
