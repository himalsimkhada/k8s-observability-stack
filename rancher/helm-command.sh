helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

helm repo update

helm upgrade --install rancher rancher-stable/rancher \
  --create-namespace \
  --namespace cattle-system \
  -f values.yml
