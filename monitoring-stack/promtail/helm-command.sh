helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm upgrade --install promtail grafana/promtail \
  -n monitoring \
  -f values.yml
