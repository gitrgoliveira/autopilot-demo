# Auto pilot demo
The idea of this repo is to demo auto pilot using k8s helm chart for Consul.

It has been optimised to run on Minikube

# Requirements
1. Helm cli (no tiller needed)
2. kubectl configured and pointing to a valid k8s cluster
3. Consul helm chart.
   1. `git clone https://github.com/hashicorp/consul-helm.git`

# Demo steps
1. `bash deploy.sh`
   * This will deploy consul enterprise in your cluster and forward 2 ports on your machine `8500` and `8600`
   * *It's a good idea to keep this tab in the background.*

## Autopilot demo
1. Split you terminal into several windows windows
   1. `watch -n1 consul operator raft list-peers -stale`
   2. `watch -n1 consul members`
   3. `watch -n1 kubectl get pods`
2. Use `kubectl delete pod` to do your demo and see the changes happening. Followers will become voters if a non-voter gets deleted and new leaders will be elected.

## Snapshot agent

1. Install your own Consul trial license. The embedded trial does not allow you to use the snapshot agent!
   1. `cat licenses.hcli | consul license put -`
2. Run `configure.sh`, which will delete the existing snapshot pods to initialise them
   1. `kubectl get pods | grep snapshot | awk '{print $1}' | xargs kubectl delete pod`
3. Check for the existence of a lock on Consul UI.
   1. http://127.0.0.1:8500/ui/dc1/kv/consul-snapshot/lock/edit
4. Check the snapshot agents are saving the snapshot, by exposing their logs.
   1. `kubectl get pods | grep snapshot | awk '{print "kubectl logs " $1}' | bash`

*Note: Consul Snapshot Agent does not work with Consul Enterprise embedded license.*
*Any issues, just invalidate the lock session and check the logs again*

## Consul Namespaces

1. Run `configure.sh`, which will delete the existing snapshot pods and setup 2 namespaces with 2 services in each.
2. You can run queries on those services using:
   1. `dig @127.0.0.1 -p 8600 +tcp prometheus.service.ops-team.consul`
   2. `dig @127.0.0.1 -p 8600 +tcp fabulous_frontend.service.app-team.consul`
   3. `dig @127.0.0.1 -p 8600 +tcp consul.service.consul`

# Clean up

You can use the bash script `cleanup.sh`
