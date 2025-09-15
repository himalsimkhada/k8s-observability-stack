helm repo add flannel https://flannel-io.github.io/flannel/

helm repo update

helm upgrade --install flannel flannel/flannel \
    --create-namespace \
    --namespace kube-flannel \
    -f values.yml