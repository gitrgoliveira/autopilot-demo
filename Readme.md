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
2. Split you terminal into several windows windows
   1. Connect to your Consul cluster with `kubectl -n default port-forward svc/consul-consul-server 8500:8500` (this can be hidden away)
   2. `watch -n1 consul operator raft list-peers`
   3. `watch -n1 consul members`
   4. `watch -n1 kubectl get pods`
3. Use `kubectl delete pod` to do your demo and see the changes happening. Followers will become voters if a non-voter gets deleted and new leaders will be elected.


| In case of a connection error when deleting a leader, this is due to the way k8s services handle connections. In production, it's better to have a proxy. |
| ---  |
| If this happens, you'll have teo restart the `port-forward` command or wait a few seconds for the cluster to become stable again |


# Clean up
1. `kubectl delete -f extras/`
2. `kubectl delete -f manifests/consul/templates/`
3. `kubectl get pvc | grep consul | awk '{print $1}' | xargs kubectl delete pvc`