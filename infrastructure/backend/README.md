# Backend stack

Terraform root for backend infrastructure: **VPC** then **EKS**. Shared modules live in [`../modules/`](../modules/).

## Layout

```text
backend/
├── Jenkinsfile
├── backend.tf              # S3 remote state (partial config)
├── backend.hcl.example       # Copy to backend.hcl (gitignored)
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── terraform.tfvars.example
```

## Remote state

State is stored in **S3** with **DynamoDB** locking. See [`../REMOTE_STATE.md`](../REMOTE_STATE.md).

| Setting | Value |
|---------|--------|
| State key | `backend/terraform.tfstate` |
| Example bucket | `cdec-alpha-terraform-state` |

```bash
cd infrastructure/backend
cp backend.hcl.example backend.hcl
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=backend.hcl
terraform plan
```

## Module wiring

```text
module "vpc"  →  ../modules/vpc
module "eks"  →  ../modules/eks   (uses vpc outputs)
```

## Jenkins

**Script path:** `infrastructure/backend/Jenkinsfile`

1. AWS credential: `aws-backend-terraform`
2. On the agent, add `terraform.tfvars` and `backend.hcl` (from the `.example` files)

## kubectl access

EKS uses **IAM access entries** (configured in the EKS module). Without an access entry for your IAM user or role, `kubectl` fails with *the server has asked for the client to provide credentials* even after `aws eks update-kubeconfig`.

1. On the machine where you run kubectl (Jenkins agent, EC2, laptop):

   ```bash
   aws sts get-caller-identity --query Arn --output text
   ```

2. Add that ARN to `cluster_admin_principal_arns` in `terraform.tfvars` (see `terraform.tfvars.example`).

3. Apply the backend stack (Jenkins backend pipeline or `terraform apply`).

4. Re-run kubeconfig and test (same AWS credentials as step 1):

   ```bash
   aws eks update-kubeconfig --region eu-west-1 --name cdec-eks-dev
   kubectl get svc
   ```

The IAM principal also needs `eks:DescribeCluster` (for `update-kubeconfig`). Cluster admin is granted via `AmazonEKSClusterAdminPolicy` on the access entry.

## Application pairing

API / services source: [`application/backend/`](../../application/backend/README.md).
