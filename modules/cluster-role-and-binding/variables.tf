variable "annotations" {
  description = "An unstructured key value map stored with the role that may be used to store arbitrary metadata."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Map of string keys and values that can be used to organize and categorize (scope and select) the role."
  type        = map(string)
  default     = {}
}


variable "create_cluster_role" {
  description = "Whether to create a cluster role with `name`."
  type        = bool
  default     = true
}

variable "cluster_role_name" {
  description = "The name of a cluster role."
  type        = string
  default     = null
}

variable "cluster_role_rules" {
  description = "List of rules that define the set of permissions for a cluster role."
  type = list(any
    # object({
    #     api_groups     = optional(list(string))
    #     resources      = list(string)
    #     resource_names = optional(list(string))
    #     verbs          = list(string)
    # }),
  )
  default = null
}

variable "cluster_role_aggregation_rules" {
  description = <<-EOT
  Describes how to build the rules for a cluster role.
  The rules are controller managed and direct changes to rules will be overwritten by the controller.
  EOT
  type = list(any
    # object({
    #     cluster_role_selectors = list(
    #         object({
    #             match_labels = map(string)
    #             match_expressions = list(
    #                 object({
    #                     key = string
    #                     operator = string
    #                     values = list(string)
    #                 })
    #             )
    #         })
    #     )
    # })
  )
  default = []
}

variable "cluster_role_binding_name" {
  description = <<-EOT
  The name of the cluster role binding.
  EOT
  type        = string
  default     = null
}

variable "cluster_role_binding_subjects" {
  description = "The Users, Groups, or ServiceAccounts to grant permissions to."
  type = list(any
    # object({
    #     kind      = string
    #     name      = string
    #     namespace = optional(string)
    #     api_group = optional(string)
    # }),
  )
  default = null
}
