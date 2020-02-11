# cat ./license.hclic | consul license put -

kubectl get pods | grep snapshot | awk '{print $1}' | xargs kubectl delete pod

consul namespace write namespace_ops-team.hcl
consul namespace write namespace_app-team.hcl
consul services register svc*

# kubectl exec -it consul-consul-server-0 -- apk add bind-tools
# kubectl exec -it consul-consul-server-0 -- dig @127.0.0.1 -p 8600 prometheus.service.ops-team.consul
# kubectl exec -it consul-consul-server-0 -- dig fabulous_frontend.service.app-team.consul

dig @127.0.0.1 -p 8600 +tcp prometheus.service.ops-team.consul
dig @127.0.0.1 -p 8600 +tcp fabulous_frontend.service.app-team.consul
