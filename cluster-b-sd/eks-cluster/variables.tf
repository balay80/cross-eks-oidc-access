variable "oidc_config" {
  type = object({
    client_id       = string
    config_name     = string
    issuer_url      = string
    username_claim  = string
    username_prefix = string
  })
}
