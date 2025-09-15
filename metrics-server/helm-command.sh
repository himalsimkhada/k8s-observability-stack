helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm repo update

helm upgrade --install metrics-server metrics-server/metrics-server -f values.yml