helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade --install redis bitnami/redis \
    --namespace redis \
    --create-namespace \
    --set auth.enabled=true \
    --set auth.password=extenso_redis \
    --set metrics.enabled=true \
    --set metrics.serviceMonitor.enabled=true \
    --set metrics.serviceMonitor.namespace=monitoring \
    --set metrics.serviceMonitor.scrapeInterval="15s" \
    --set replica.replicaCount=0