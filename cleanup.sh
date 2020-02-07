#! /usr/bin/env bash

kubectl delete -f extras/
kubectl delete -f manifests/consul/templates/
kubectl delete secret generic snapshot-agent-config

kubectl get pvc | grep consul | awk '{print $1}' | xargs kubectl delete pvc
kubectl get pv | grep consul | awk '{print $1}' | xargs kubectl delete pv
