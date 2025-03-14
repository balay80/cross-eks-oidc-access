# ClusterRole-and-Binding Module

## Usage

Recreate the Kubernetes RBAC examples from the [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) documentation.

```hcl
locals {
  labels = {
    "app.kubernetes.io/managed-by" = "Terraform"
    "terraform.io/module"          = "clusterrole-and-binding"
  }
}
# https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrole-example
# https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrolebinding-example
module "secret_reader_global" {
  source = "<path/to/clusterrole-and-binding module>"
  labels = local.labels
  cluster_role_name = "secret-reader-global"
  # "namespace" omitted since ClusterRoles are not namespaced
  cluster_role_rules = [
    {
      api_groups = [""]
      resources  = ["secrets"]
      verbs      = ["get", "watch", "list"]
    },
  ]
  # This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
  cluster_role_binding_name = "read-secrets-global"
  cluster_role_binding_subjects = [
    {
      kind     = "Group"
      name     = "manager" # Name is case sensitive
      apiGroup = "rbac.authorization.k8s.io"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.5 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.crb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.cr](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_resource.cluster_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/resource) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | An unstructured key value map stored with the role that may be used to store arbitrary metadata. | `map(string)` | `{}` | no |
| <a name="input_cluster_role_aggregation_rules"></a> [cluster\_role\_aggregation\_rules](#input\_cluster\_role\_aggregation\_rules) | Describes how to build the rules for a cluster role.<br>The rules are controller managed and direct changes to rules will be overwritten by the controller. | <pre>list(any<br>    # object({<br>    #     cluster_role_selectors = list(<br>    #         object({<br>    #             match_labels = map(string)<br>    #             match_expressions = list(<br>    #                 object({<br>    #                     key = string<br>    #                     operator = string<br>    #                     values = list(string)<br>    #                 })<br>    #             )<br>    #         })<br>    #     )<br>    # })<br>  )</pre> | `[]` | no |
| <a name="input_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#input\_cluster\_role\_binding\_name) | The name of the cluster role binding. | `string` | `null` | no |
| <a name="input_cluster_role_binding_subjects"></a> [cluster\_role\_binding\_subjects](#input\_cluster\_role\_binding\_subjects) | The Users, Groups, or ServiceAccounts to grant permissions to. | <pre>list(any<br>    # object({<br>    #     kind      = string<br>    #     name      = string<br>    #     namespace = optional(string)<br>    #     api_group = optional(string)<br>    # }),<br>  )</pre> | `null` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | The name of a cluster role. | `string` | `null` | no |
| <a name="input_cluster_role_rules"></a> [cluster\_role\_rules](#input\_cluster\_role\_rules) | List of rules that define the set of permissions for a cluster role. | <pre>list(any<br>    # object({<br>    #     api_groups     = optional(list(string))<br>    #     resources      = list(string)<br>    #     resource_names = optional(list(string))<br>    #     verbs          = list(string)<br>    # }),<br>  )</pre> | `null` | no |
| <a name="input_create_cluster_role"></a> [create\_cluster\_role](#input\_create\_cluster\_role) | Whether to create a cluster role with `name`. | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of string keys and values that can be used to organize and categorize (scope and select) the role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#output\_cluster\_role\_binding\_name) | The cluster role binding name. |
| <a name="output_cluster_role_name"></a> [cluster\_role\_name](#output\_cluster\_role\_name) | The cluster role name. |
