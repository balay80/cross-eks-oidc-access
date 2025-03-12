module "eks-cluster" {
  source = "../../modules/eks-clustwer"
  /*
 arguments trimmed for brewity
 */
  oidc_config = var.oidc_config
}
