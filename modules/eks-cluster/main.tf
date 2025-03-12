/*
main eks-cluster resources are truncated for brewity
*/


resource "aws_eks_identity_provider_config" "associate_oidc_config" {
  count        = var.oidc_config == null ? 0 : 1
  cluster_name = aws_eks_cluster.cluster.name
  oidc {
    client_id                     = var.oidc_config["client_id"]
    identity_provider_config_name = var.oidc_config["config_name"]
    issuer_url                    = var.oidc_config["issuer_url"]
    username_claim                = var.oidc_config["username_claim"]
    username_prefix               = var.oidc_config["username_prefix"]
  }
}

variable "oidc_config" {
  type = object({
    client_id       = string
    config_name     = string
    issuer_url      = string
    username_claim  = string
    username_prefix = string
  })
}
