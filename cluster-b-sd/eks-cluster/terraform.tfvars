oidc_config = {
  client_id       = "sts.amazonaws.com" #audience for below oidc issuer url, it's sts.amazonaws.com for cluster-a oidc
  config_name     = "cluster-a-oidc"
  issuer_url      = "https://oidc.eks.us-west-2.amazonaws.com/id/E2112345678912345678912345678912" # cluster-a oidc issuer url
  username_claim  = "sub"
  username_prefix = "cluster-a:"
}
