helm repo add prometheus-msteams https://prometheus-msteams.github.io/prometheus-msteams/
helm repo update

helm upgrade --install prometheus-msteams \
  --namespace monitoring -f values.yml \
  prometheus-msteams/prometheus-msteams