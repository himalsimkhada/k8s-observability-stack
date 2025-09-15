helm repo add metallb https://metallb.github.io/metallb

helm repo update

helm upgrade --install metallb metallb/metallb \
    --create-namespace \
    --namespace=metallb-system \
    -f values.yml
  --set crds.validationFailurePolicy=Ignore