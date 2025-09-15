kubectl create secret generic grafana-admin-secret \
  -n monitoring \
  --from-literal=admin-user=admin \
  --from-literal=admin-password='Devops@123'

kubectl create secret generic grafana-smtp-secret \
  -n monitoring \
  --from-literal=user=admin \
  --from-literal=password='Devops@123'

kubectl create configmap grafana-datasources \
  --from-file=datasources.yml \
  -n monitoring
