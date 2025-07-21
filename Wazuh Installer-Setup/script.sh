#!/bin/bash
set -euo pipefail

read -rp "Enter Indexer node IP: " INDEXER_IP
read -rp "Enter Manager node IP: " MANAGER_IP
read -rp "Enter Dashboard node IP: " DASHBOARD_IP

WAZUH_VERSION="4.12"


curl -sO "https://packages.wazuh.com/${WAZUH_VERSION}/wazuh-install.sh"
curl -sO "https://packages.wazuh.com/${WAZUH_VERSION}/config.yml"


sed -i \
  -e "s/<indexer-node-ip>/${INDEXER_IP}/g" \
  -e "s/<wazuh-manager-ip>/${MANAGER_IP}/g" \
  -e "s/<dashboard-node-ip>/${DASHBOARD_IP}/g" \
  config.yml


bash wazuh-install.sh --generate-config-files -i


bash wazuh-install.sh --wazuh-indexer node-1 -i
bash wazuh-install.sh --start-cluster -i

ADMIN_PASS=$(tar -O -xf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt \
  | grep -P "'admin'" -A1 | tail -n1 | awk '{print $2}')
echo "🟢 Admin password: $ADMIN_PASS"


echo "Testing indexer cluster..."
curl -sk -u admin:"$ADMIN_PASS" "https://${INDEXER_IP}:9200" || echo "Indexer unreachable!"
curl -sk -u admin:"$ADMIN_PASS" "https://${INDEXER_IP}:9200/_cat/nodes?v" || true

bash wazuh-install.sh --wazuh-server wazuh-1 -i
bash wazuh-install.sh --wazuh-dashboard dashboard -i

echo -e "\n✅ All set! Dashboard URL: https://${DASHBOARD_IP}"
echo "   Username: admin"
echo "   Password: ${ADMIN_PASS}"
echo "   (Expect self-signed certificate warnings.)"