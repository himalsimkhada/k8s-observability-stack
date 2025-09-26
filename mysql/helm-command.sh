helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade --install mysql bitnami/mysql \
    --namespace mysql \
    --create-namespace \
    -f values.yml