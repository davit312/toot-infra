resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "7.8.14"
  set = [
    {
      name  = "server.extraArgs[0]"
      value = "--insecure"
    },
    {
      name  = "global.image.tag"
      value = "v2.14.8"
    },
    {
      name  = "dex.enabled"
      value = "false"
    }
  ]
}
