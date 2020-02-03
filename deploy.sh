#! /usr/bin/env bash
# The tool used to generate manifests is helm.
set -e
set -o pipefail

# minikube start

rm -rf manifests
mkdir manifests

helm template -n consul ./consul-helm/ -f values.yaml --output-dir ./manifests


kubectl apply -f manifests/consul/templates/
kubectl apply -f extras/

# kubectl -n default port-forward svc/consul-consul-server  8500:8500 &
# open http://127.0.0.1:8500
