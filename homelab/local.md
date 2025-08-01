# Local Homelab

## Home Lab Learning Environment Options

### $100 Budget - "Single Machine Powerhouse"

**Hardware Requirements:**

- **Existing laptop/desktop** with 16GB+ RAM, 4+ cores
- **Additional storage:** $50 for 1TB NVMe SSD or external drive
- **Networking:** $30 for managed switch (TP-Link TL-SG105 or similar)
- **Power:** $20 for UPS (optional but recommended)

**Software Stack (All Free):**

- **Hypervisor:** Proxmox VE or VMware ESXi (free)
- **Kubernetes:** k3s cluster (3-5 VMs)
- **Storage:** Longhorn for persistent volumes
- **Networking:** MetalLB for load balancing
- **Monitoring:** Prometheus, Grafana, AlertManager
- **CI/CD:** GitLab CE or Jenkins
- **Container Registry:** Harbor or local Docker registry

**VM Configuration:**

```bash
# 3 VMs on 16GB machine:
# Master: 6GB RAM, 2 cores, 40GB disk
# Worker1: 4GB RAM, 2 cores, 30GB disk  
# Worker2: 4GB RAM, 2 cores, 30GB disk
# Remaining: 2GB for hypervisor

# k3s installation
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - server --cluster-init
```

**What You Can Run:**

- Multi-node Kubernetes cluster
- Complete observability stack
- GitOps with ArgoCD
- Vector database (Qdrant)
- All microservices from the learning plan
- Local container registry
- Basic service mesh (Linkerd - lighter than Istio)

**Limitations:**

- Limited compute for heavy workloads
- No cloud-native services (managed databases, etc.)
- Single point of failure
- Limited internet bandwidth for container pulls

---

### $500 Budget - "Serious Home Lab"

**Hardware Setup:**

- **Mini PC cluster:** 3x Intel NUC or similar ($150 each = $450)
  - Each: 8GB RAM, 4 cores, 256GB NVMe
- **Networking:** $30 for 8-port managed switch
- **Storage:** $20 for USB drives for OS installation

**Alternative Configuration:**

- **Single powerful machine:** $450 for 32GB RAM upgrade + additional storage
- **Network storage:** $50 for external NAS or large external drive

**Enhanced Software Stack:**

- **Kubernetes:** Full k8s with kubeadm or k3s HA
- **Storage:** Rook-Ceph for distributed storage
- **Service Mesh:** Full Istio deployment
- **Databases:** PostgreSQL, Redis, MongoDB operators
- **AI/ML:** Kubeflow or MLflow
- **Security:** Falco, OPA Gatekeeper
- **Backup:** Velero with local storage

**Network Configuration:**

```bash
# VLAN setup for isolation
# Management VLAN: 192.168.10.0/24
# Kubernetes VLAN: 192.168.20.0/24
# Storage VLAN: 192.168.30.0/24

# MetalLB IP pool
apiVersion: metallb.io/v1
kind: IPAddressPool
metadata:
  name: production
spec:
  addresses:
  - 192.168.20.100-192.168.20.200
```

**What You Can Run:**

- High-availability Kubernetes cluster
- Distributed storage with replication
- Complete service mesh with mTLS
- Multiple environments (dev/staging/prod)
- Performance testing at moderate scale
- Complete AI/ML pipeline
- Advanced networking scenarios
- Disaster recovery testing

**Performance Capabilities:**

- Handle 100+ pods simultaneously
- Run realistic load testing
- Support multiple concurrent developers
- Database workloads with persistence

---

### $1000 Budget - "Enterprise Home Lab"

**Hardware Configuration Option 1 - Distributed:**

- **4x Mini PCs:** Intel NUC 11 or similar ($200 each = $800)
  - Each: 16GB RAM, 6 cores, 512GB NVMe
- **Managed switch:** $100 for 16-port with VLAN support
- **UPS:** $100 for battery backup

**Hardware Configuration Option 2 - Consolidated:**

- **Single server:** $800 for 64GB RAM, 12+ cores, multiple drives
- **Network gear:** $150 for advanced switch + wireless AP
- **Storage:** $50 for additional drives

**Professional Software Stack:**

- **Hypervisor:** VMware vSphere (VMUG license ~$200/year)
- **Kubernetes:** Multiple distributions for comparison
- **Service Mesh:** Istio + Linkerd for comparison
- **Databases:** Full enterprise stack with operators
- **AI/ML:** Complete MLOps pipeline with GPU passthrough
- **Security:** Complete security stack with scanning
- **Monitoring:** Enterprise-grade observability

**Advanced Features:**

```bash
# GPU passthrough for ML workloads (if using dedicated machine)
# NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Multi-cluster setup for federation testing
k3sup install --ip 192.168.20.10 --user k3s --cluster
k3sup install --ip 192.168.20.11 --user k3s --cluster
```

**What You Can Run:**

- Multi-cluster Kubernetes federation
- GPU workloads for AI/ML training
- Network policy testing and microsegmentation
- Performance testing at enterprise scale
- Chaos engineering with Chaos Monkey
- Complete backup and disaster recovery
- Multi-tenant environments
- Advanced security scenarios

---

## Detailed Component Breakdown

### Kubernetes Distributions Comparison

**k3s (Recommended for home lab):**

- Minimal resource usage
- Built-in storage and networking
- Easy HA setup
- Perfect for learning

**kubeadm (Traditional):**

- More configuration required
- Closer to production environments
- Better for learning cluster internals

**k0s (Emerging):**

- Single binary like k3s
- More modular architecture
- Good for advanced users

### Storage Solutions

**$100 Budget:**

```bash
# Longhorn - simple distributed storage
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml
```

**$500 Budget:**

```bash
# Rook-Ceph for enterprise-grade storage
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/deploy/examples/operator.yaml
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/deploy/examples/cluster.yaml
```

**$1000 Budget:**

- Multiple storage classes
- Backup and disaster recovery
- Performance testing and tuning

### Networking Setup

**Basic (All budgets):**

- MetalLB for load balancer services
- Ingress controller (Nginx or Traefik)
- Basic network policies

**Advanced ($500+):**

- VLAN segmentation
- Service mesh (Istio/Linkerd)
- Network policy enforcement
- Observability with Hubble

### Monitoring Stack

**Standard Stack:**

```yaml
# Prometheus operator
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/setup/
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/manifests/
```

**Enhanced Monitoring ($500+):**

- Custom dashboards for each service
- AlertManager with notification channels
- Distributed tracing with Jaeger
- Log aggregation with ELK stack

---

## Power and Cooling Considerations

### Power Consumption

- **$100 setup:** ~150W (single machine)
- **$500 setup:** ~300W (3 mini PCs)
- **$1000 setup:** ~500W (4 machines + networking)

### Annual Power Costs (at $0.12/kWh)

- **$100 setup:** ~$160/year
- **$500 setup:** ~$315/year
- **$1000 setup:** ~$525/year

### Cooling Solutions

- **$100:** Desktop fans, good ventilation
- **$500:** Rack cooling or dedicated AC
- **$1000:** Proper server rack with cooling

---

## Learning Advantages of Home Lab

### Pros vs Cloud

✅ **Complete control** over infrastructure
✅ **No surprise bills** or resource limits
✅ **Learn hardware/networking** fundamentals
✅ **Persistent environments** for long-term projects
✅ **Offline capability** for learning
✅ **Real performance testing** without quotas

### Cons vs Cloud

❌ **No managed services** (RDS, SageMaker, etc.)
❌ **Limited internet bandwidth** for CI/CD
❌ **Hardware maintenance** responsibility
❌ **Power/cooling costs** ongoing
❌ **Single location** (no multi-region testing)

---

## ROI Analysis for Home Lab

### $100 Investment

- **One-time cost** + ~$160/year power
- **Skills gained:** 75% of learning objectives
- **Time to recoup:** 1-2 weeks of salary increase
- **Long-term value:** 3-5 years of learning platform

### $500 Investment

- **One-time cost** + ~$315/year power
- **Skills gained:** 90% of learning objectives
- **Time to recoup:** 2-3 weeks of salary increase
- **Long-term value:** 5+ years of professional development

### $1000 Investment

- **One-time cost** + ~$525/year power
- **Skills gained:** 95% + enterprise networking/hardware
- **Time to recoup:** 1 month of salary increase
- **Long-term value:** Enterprise-grade lab for career growth

**Bottom Line:** Home labs offer better long-term ROI than cloud for dedicated learners. The initial investment pays dividends over years of learning and experimentation. Perfect for those who want to truly understand infrastructure from the ground up.
