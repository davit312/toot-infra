resource "helm_release" "external-secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"

  namespace        = "external-secrets"
  create_namespace = true

  depends_on = [null_resource.config-kubectl]
}
