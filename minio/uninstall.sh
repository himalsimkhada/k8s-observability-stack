helm uninstall minio -n mino
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=minio
