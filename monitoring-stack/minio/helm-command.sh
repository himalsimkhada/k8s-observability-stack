helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install minio bitnami/minio \
  -n monitoring --create-namespace \
  -f values.yml