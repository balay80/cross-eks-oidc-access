# cross-eks-oidc-access

- cross K8s access without assuming any AWS role with minimal changes in our existing terraform modules .
- I tried solving it with taking advantage of existing identity provider we setup while we create our eks clusters.
- So let's say `Cluster A(MD)` wants to access `Cluster B(SD)`, steps i took:

1. in `CLUSTER B(SD)` Associate identity provider of `Cluster A(MD)` with `Cluster B(SD)` (there is an option to have at max 2 identity provider associated with an eks cluster.)
    - `client_id=audience` of your JWT token given by your serviceaccount in Cluster A
    - mention `userclaim=sub` (it says default is sub, but it's not)
    - mention `userprefix=<any identifier>`
    - The username that you will be authenticating with cluster B will be `<userprefix><sub value in your jwt>`

2. `CLUSTER B(SD)` : Now create the rolebinding or cluster role binding, which ever needed and mention `subjects: as User` and its username, ie `name:` is of format `"cluster-a-name:system:serviceaccount:<namespace-in-cluster-a>:<service-account-in-cluster-a>"`

3. from now on you can access `CLUSTER-B(SD)` from `CLUSTER-A(MD)` using your `CLUSTER-A`'s `kubeconfig` and using serviceaccount token of `Cluster-B`'s service-account in a namespace that wants to access `CLUSTER-B`'s resources .  Just Use service-account-token in users field in your kubeconfig. eg.

    ```sh
    apiVersion: v1
    clusters:

    - cluster:
        certificate-authority-data: <Cluster B cert>
        server: <Cluster B Api Server>
    name: <cluster arn>
    contexts:
    - context:
        cluster: <cluster arn>
        user: <any username i use same as cluster arn>
    name: <any name i use same as cluster arn>
    current-context: <context name as above>
    kind: Config
    preferences: {}
    users:
    - name: <user name as above>
    user:
        token: <serviceaccount token with same audience as configured in step 1>
    ```

Note: From pod you might have to disable incluster authentication or use a sdk to test.
