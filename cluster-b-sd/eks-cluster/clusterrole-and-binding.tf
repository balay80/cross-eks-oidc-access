## this clusterrole and clusterrolebing will be used by cluster-a's service-account
module "cluster-a-clusterrole-binding" {
  source = "../../modules/cluster-role-and-binding"
}
