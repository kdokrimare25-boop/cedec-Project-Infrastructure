# Remote state: S3 + DynamoDB locking
#
# Initialize with:
#   cp backend.hcl.example backend.hcl   # edit bucket/region if needed
#   terraform init -backend-config=backend.hcl

terraform {
  backend "s3" {
<<<<<<< HEAD
    bucket  = "cdec-alpha-terraform-state-kaminid"
=======
    bucket  = "cdec-alpha-terraform-state-kamini"
>>>>>>> 5c6e21a1ed1760f6d27f354a8ddcf660221ee0d5
    key     = "frontend/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
    # profile = "terraform-sessions"

  }
}
