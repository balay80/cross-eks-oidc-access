locals {
  labels = {
    "app.kubernetes.io/managed-by" = "Terraform"
    "terraform.io/module"          = "clusterrole-and-binding"
  }
  cluster_role_binding_subjects = [
    {
      kind     = "User"
      name     = "<cluster-a-name>:system:serviceaccount:<cluster-a-app-namespace>:<cluster-a-app-service-account>"
      apiGroup = "rbac.authorization.k8s.io"
    }
  ]
  cluster_role_rules = [
    {
      api_groups = [""]
      resources  = ["events", "replicationcontrollers", "pods/log"]
      verbs      = ["get", "list"]
    },
    {
      api_groups = [""]
      resources  = ["pods", "services", "namespaces", "secrets"]
      verbs = [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ]
    },
    {
      api_groups = ["apps"]
      resources  = ["controllerrevisions"]
      verbs      = ["list"]
    },
    {
      api_groups = [
        "",
        "apiextensions.k8s.io",
        "apps",
        "autoscaling",
        "batch",
        "coordination.k8s.io",
        "extensions",
        "metrics",
        "networking.k8s.io",
        "policy",
        "rbac.authorization.k8s.io"
      ]
      resources = [
        "authorizationpolicy",
        "clusterroles",
        "clusterrolebindings",
        "configmaps",
        "cronjobs",
        "customresourcedefinitions",
        "daemonsets",
        "deployments",
        "deployments/scale",
        "horizontalpodautoscalers",
        "ingresses",
        "ingressclasses",
        "jobs",
        "leases",
        "persistentvolumes",
        "persistentvolumeclaims",
        "poddisruptionbudgets",
        "replicasets",
        "roles",
        "rolebindings",
        "serviceaccounts",
        "statefulsets",
      ]
      verbs = [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ]
    },
    {
      api_groups = [
        "networking.istio.io"
      ]
      resources = [
        "gateways",
        "virtualservices",
        "authorizationpolicy",
      ]
      verbs = [
        "create",
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "update",
        "watch"
      ]
    }
  ]
}

module "cluster-b-clusterole-binding" {
  source                        = "./clusterrole-and-binding"
  labels                        = local.labels
  create_cluster_role           = true
  cluster_role_name             = "cluster-a" # just for identifying that this will be used by cluster-a's service-account
  cluster_role_binding_name     = "cluster-a" # just for identifying that this will be used by cluster-a's service-account
  cluster_role_rules            = local.cluster_role_rules
  cluster_role_binding_subjects = local.cluster_role_binding_subjects
}
