helm repo add longhorn https://charts.longhorn.io

helm repo update

helm install longhorn longhorn/longhorn \
  --namespace longhorn-system \
  --create-namespace \
  -f values.yml