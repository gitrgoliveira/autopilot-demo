# Auto pilot demo
The idea of this repo is to demo auto pilot using k8s helm chart for Consul.

# Requirements
1. Helm cli (no tiller needed)
2. kubectl configured and pointing to a valid k8s cluster
3. Consul helm chart.
   1. `git clone https://github.com/hashicorp/consul-helm.git`

# Demo steps
1. `bash deploy.sh`
   * This will deploy consul enterprise in your cluster

## Autopilot demo
1. Split you terminal into several windows windows
   1. Connect to your Consul cluster with `kubectl -n default port-forward svc/consul-consul-server 8500:8500` (this can be hidden away)
   2. `watch -n1 consul operator raft list-peers -stale`
   3. `watch -n1 consul members`
   4. `watch -n1 kubectl get pods`
2. Use `kubectl delete pod` to do your demo and see the changes happening. Followers will become voters if a non-voter gets deleted and new leaders will be elected.

## Snapshot agent

1. Instal your own Consul trial license.
   1. `cat licenses.hcli | consul license put -`
2. Delete the existing snapshot pods to initialise them
   1. `kubectl get pods | grep snapshot | awk '{print $1}' | xargs kubectl delete pod`
3. Check for the existence of a lock on Consul UI and .
   1. http://127.0.0.1:8500/ui/dc1/kv/consul-snapshot/lock/edit
4. Check the snapshot agents are saving the snapshot, by exposing their logs.
   1. `kubectl get pods | grep snapshot | awk '{print "kubectl logs " $1}' | bash`

*Note: Consul Snaphost Agent does not work with Consul Enterprise embedded license.*
*Any issues, just invalidate the lock session and check the logs again*

# Clean up

You can use the bash script `cleanup.sh`
