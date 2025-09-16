helm repo add minio https://charts.min.io/
helm repo update

helm upgrade --install minio minio/minio \
  -n minio --create-namespace \
  -f values.yml