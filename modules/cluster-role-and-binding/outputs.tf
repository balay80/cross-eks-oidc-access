output "cluster_role_name" {
  description = "The cluster role name."
  value = (
    var.cluster_role_name != null ?
    (var.create_cluster_role == true ? kubernetes_cluster_role_v1.cr[0].metadata[0].name : local.cluster_role_name) :
    null
  )
}

output "cluster_role_binding_name" {
  description = "The cluster role binding name."
  value = (
    var.cluster_role_binding_subjects != null ?
    kubernetes_cluster_role_binding_v1.crb[0].metadata[0].name :
    null
  )
}
