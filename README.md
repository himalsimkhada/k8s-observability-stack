# k8s-observability-stack

A production-ready, scalable Kubernetes observability stack including:

* **Grafana** – dashboards and visualization
* **Prometheus** – metrics collection
* **Alertmanager** – alerts
* **Loki** – log aggregation
* **Promtail** – log shipping
* **MinIO** – S3-compatible object storage for Loki

Namespace used: `monitoring`
StorageClass: `longhorn`

---

## Prerequisites

* Kubernetes cluster (≥ 6 nodes recommended)
* Helm v3 installed
* kubectl configured
* Longhorn installed (or another dynamic storage class)
* Git installed (optional, for storing configs)

---

## Step 1: Setup MinIO (Object Storage)

1. Add Bitnami Helm repo:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

2. Create namespace:

```bash
kubectl create ns monitoring
```

3. Deploy MinIO:

```bash
helm install minio bitnami/minio \
  -n monitoring \
  -f minio-values.yml
```

> `minio-values.yml` should include credentials and persistence.

4. Verify MinIO:

```bash
kubectl get pods -n monitoring
kubectl port-forward svc/minio 9000:9000 -n monitoring
```

---

## Step 2: Deploy Prometheus + Alertmanager

1. Add Grafana Helm repo:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

2. Install kube-prometheus-stack:

```bash
helm install prometheus grafana/kube-prometheus-stack \
  -n monitoring \
  -f prometheus-values.yml
```

> `prometheus-values.yml` should include:
>
> * Prometheus + Alertmanager replicas
> * Retention (`7d` for Prometheus, `120h` for Alertmanager)
> * Persistence using Longhorn
> * Thanos disabled (optional to enable later)

3. Verify deployment:

```bash
kubectl get pods -n monitoring
```

---

## Step 3: Deploy Grafana

1. Install Grafana:

```bash
helm install grafana grafana/grafana \
  -n monitoring \
  -f grafana-values.yml
```

> `grafana-values.yml` should include:
>
> * Persistence enabled (Longhorn)
> * ConfigMaps for `grafana.ini` and `datasources.yml`
> * ExtraConfigMapMounts for datasource
> * Ingress disabled or configured as needed

2. Verify Grafana:

```bash
kubectl get pods -n monitoring
kubectl port-forward svc/grafana 3000:80 -n monitoring
```

* Access: `http://localhost:3000`
* Default credentials: `admin` / password from Helm secret

---

## Step 4: Deploy Loki

1. Install Loki (simple scalable mode):

```bash
helm install loki grafana/loki \
  -n monitoring \
  -f loki-values.yml
```

> `loki-values.yml` should include:
>
> * `boltdb-shipper` storage
> * S3/MinIO configuration
> * Read/Write/Backend replicas = 1–2
> * Persistence enabled for Write and Backend
> * Ruler disabled (optional)
> * `limits_config.allow_structured_metadata=false`

2. Verify Loki:

```bash
kubectl get pods -n monitoring
```

---

## Step 5: Deploy Promtail

1. Install Promtail:

```bash
helm install promtail grafana/promtail \
  -n monitoring \
  -f promtail-values.yml
```

> `promtail-values.yml` should include:
>
> * Clients pointing to your Loki service
> * Kubernetes scraping config
> * Positions persistence (optional)
> * `tenant` if `auth_enabled=true` in Loki

2. Verify Promtail:

```bash
kubectl get pods -n monitoring
kubectl logs -f <promtail-pod> -n monitoring
```

---

## Step 6: Configure Grafana Dashboards

1. Add Loki datasource (Grafana → Configuration → Datasources)

   * URL: `http://loki.monitoring.svc.cluster.local:3100`
   * HTTP Header: `X-Scope-OrgID` if Loki `auth_enabled=true`

2. Import official dashboards:

* Kubernetes Logs Overview (ID: `14357`)
* Cluster Logging Overview (ID: `15399`)
* Loki Explore Logs (ID: `000000123`)

---

## Step 7: Optional - Clean Uninstall

To remove **all components and resources**:

```bash
helm uninstall grafana loki promtail prometheus -n monitoring

kubectl delete pvc,configmap,secret -n monitoring -l app.kubernetes.io/name=grafana
kubectl delete pvc,configmap,secret -n monitoring -l app.kubernetes.io/name=loki
kubectl delete pvc,configmap,secret -n monitoring -l app.kubernetes.io/name=promtail
kubectl delete pvc,configmap,secret -n monitoring -l app.kubernetes.io/name=prometheus

kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=grafana
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=loki
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=promtail
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=prometheus
```

---

## Notes

* All deployments are in the `monitoring` namespace.
* StorageClass is Longhorn; adjust if using a different class.
* Thanos can be enabled later for long-term metrics storage.
* Keep `auth_enabled=false` in Loki for simpler single-tenant setup.

This stack is **production-ready but scalable**: you can increase replicas for Prometheus, Loki, and Grafana as the cluster grows.
