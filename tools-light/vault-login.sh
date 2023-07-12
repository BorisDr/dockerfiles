#!/bin/bash
echo "Specify Vault role"
read ROLE

echo "Specify Vault URL

vault-nonprd.devops.pluto.tv
vault-preprod.devops.pluto.tv
vault-prod.devops.pluto.tv"
vault-ent-preprod.devops.pluto.tv:8200
vault-ent-prod.devops.pluto.tv:8200

read DOMAIN

echo "Specify Vault auth backend"
read AUTH

KUBE_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

curl --silent --request POST --data '{"jwt": "'"${KUBE_TOKEN}"'", "role": "'"${ROLE}"'"}' https://${DOMAIN}/v1/auth/${AUTH}/login | jq
echo 'export VAULT_ADDR="https://'${DOMAIN}'"'
