# Perf Testing

Deploy resources to k8s and vk8s.

```shell
KUBECONFIG=~/Repos/volterra-mcn-internal/volterra-docs/kubeconfigs/kubeconfig-aws-sa.yaml \
kubectl apply -f deploy-k8s.yaml

KUBECONFIG=~/Repos/volterra-mcn-internal/volterra-docs/kubeconfigs/kubeconfig-azure.yaml \
kubectl apply -f deploy-k8s.yaml

KUBECONFIG=~/Repos/volterra-mcn-internal/volterra-docs/kubeconfigs/kubeconfig-gcp.yaml \
kubectl apply -f deploy-vk8s.yaml
```

Create TCP Loadbalancers and Origin pools. Origin pools target the iperf service at each site. 
Loadbalancers are advertised to the _other_ sites.

|   Site   |    iperf svc DNS    |  Port |
|----------|:-------------------:|------:|
| AWS      |  aws-iperf.internal | 5301  |
| Azure    | azure-iperf.internal| 5302  |
| GCP/vk8s |  gcp-iperf.internal | 5303  |

Run iperf tests from the clients deployed by the daemonset.

```shell
root@iperf-clients-77q5t:/# iperf3 -c gcp-iperf.internal -p 5303
Connecting to host gcp-iperf.internal, port 5303
[  5] local 192.168.43.109 port 33454 connected to 172.30.19.149 port 5303
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  39.7 MBytes   333 Mbits/sec   97    150 KBytes       
[  5]   1.00-2.00   sec  35.3 MBytes   296 Mbits/sec   15    214 KBytes       
[  5]   2.00-3.00   sec  37.9 MBytes   318 Mbits/sec    0    299 KBytes       
[  5]   3.00-4.00   sec  37.6 MBytes   315 Mbits/sec   77    275 KBytes       
[  5]   4.00-5.00   sec  39.5 MBytes   332 Mbits/sec   76    264 KBytes       
[  5]   5.00-6.00   sec  39.3 MBytes   330 Mbits/sec    0    347 KBytes       
[  5]   6.00-7.00   sec  31.2 MBytes   262 Mbits/sec   77    303 KBytes       
[  5]   7.00-8.00   sec  35.8 MBytes   300 Mbits/sec    0    374 KBytes       
[  5]   8.00-9.00   sec  35.9 MBytes   301 Mbits/sec    0    431 KBytes       
[  5]   9.00-10.00  sec  37.8 MBytes   317 Mbits/sec    0    485 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   370 MBytes   310 Mbits/sec  342             sender
[  5]   0.00-10.03  sec   362 MBytes   302 Mbits/sec                  receiver
```

## Container Build 

```shell
docker build -t f5demos.azurecr.io/iperf .
docker push f5demos.azurecr.io/iperf:latest
```

## Site Changes

Note the updated CoreDNS configmaps in this directory. These allow conditional forwarding so MCN DNS entries will resolve in the cluster.