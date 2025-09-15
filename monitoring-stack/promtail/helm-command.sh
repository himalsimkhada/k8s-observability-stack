helm upgrade --install promtail grafana/promtail \
  -n monitoring \
  -f values.yml
