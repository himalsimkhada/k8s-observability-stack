helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
    --create-namespace \
    --namespace ingress-nginx \
    -f values.yml