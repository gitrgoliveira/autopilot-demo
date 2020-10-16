#! /usr/bin/env bash
# The tool used to generate manifests is helm.
set -e
set -o pipefail

# if using minikube
minikube start --vm=true --driver=hyperkit --cpus=4

CONSUL_HELM_VERSION=0.20.1
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install consul hashicorp/consul --version $CONSUL_HELM_VERSION  -f values.yaml || true

#------------------------------
# to check what consul-helm applies to the cluster.
# rm -rf manifests
# mkdir manifests
# helm template consul hashicorp/consul --version $CONSUL_HELM_VERSION -f values.yaml  --output-dir ./manifests

if kubectl get secret snapshot-agent-config ; then
    kubectl delete secret snapshot-agent-config
fi
kubectl create secret generic snapshot-agent-config  --from-file=./snaphshot_agent.hcl

kubectl apply -f extras/

sleep 5 # giving it a few seconds for k8s to start building the pods

kubectl wait --for=condition=ready --timeout=1m pod/consul-consul-server-a-0
kubectl wait --for=condition=ready --timeout=1m pod/consul-consul-server-a-1
kubectl wait --for=condition=ready --timeout=1m pod/consul-consul-server-b-0
kubectl wait --for=condition=ready --timeout=1m pod/consul-consul-server-b-1

kubectl port-forward svc/consul-consul-server 8600:8600 &
kubectl port-forward svc/consul-consul-server 8500:8500 &
open http://127.0.0.1:8500

