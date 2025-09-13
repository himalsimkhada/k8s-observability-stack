helm uninstall grafana -n monitoring
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=grafana