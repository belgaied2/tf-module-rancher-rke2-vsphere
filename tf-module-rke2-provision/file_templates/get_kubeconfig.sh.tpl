#!/bin/bash
DOCUMENT=$(ssh ${ssh_user}@${vm_ip} -o StrictHostKeyChecking=no -- cat /etc/rancher/rke2/rke2.yaml)
jq -n --arg doc "$DOCUMENT" '{"document":$doc}' | sed -e s/127\.0\.0\.1/${vm_ip}/g