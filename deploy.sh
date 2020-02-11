#! /usr/bin/env bash
# The tool used to generate manifests is helm.
set -e
set -o pipefail

# minikube start

rm -rf manifests
mkdir manifests

helm template -n consul ./consul-helm/ -f values.yaml --output-dir ./manifests

if kubectl get secret snapshot-agent-config ; then
    kubectl delete secret snapshot-agent-config
fi
kubectl create secret generic snapshot-agent-config  --from-file=./snaphshot_agent.hcl

kubectl apply -f manifests/consul/templates/
kubectl apply -f extras/


sleep 30
kubectl -n default port-forward svc/consul-consul-server 8600:8600 &
kubectl -n default port-forward svc/consul-consul-server 8500:8500 &
open http://127.0.0.1:8500

