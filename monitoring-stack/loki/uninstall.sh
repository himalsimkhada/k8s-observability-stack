helm uninstall loki -n monitoring
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=loki