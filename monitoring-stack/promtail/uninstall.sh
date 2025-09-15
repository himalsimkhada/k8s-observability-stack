helm uninstall promtail -n monitoring
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=promtail