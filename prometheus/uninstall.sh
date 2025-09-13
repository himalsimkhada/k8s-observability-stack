helm uninstall prometheus -n monitoring

kubectl delete mutatingwebhookconfiguration prometheus-kube-prometheus-admission
kubectl delete validatingwebhookconfiguration prometheus-kube-prometheus-admission

kubectl delete clusterrole prometheus -n monitoring
kubectl delete clusterrole alertmanager -n monitoring
kubectl delete clusterrole prometheus-operator -n monitoring

kubectl delete clusterrolebinding prometheus -n monitoring
kubectl delete clusterrolebinding alertmanager -n monitoring
kubectl delete clusterrolebinding prometheus-operator -n monitoring

kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd scrapeconfigs.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com

kubectl delete sa prometheus -n monitoring
kubectl delete sa alertmanager -n monitoring
kubectl delete sa prometheus-operator -n monitoring

kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=prometheus
