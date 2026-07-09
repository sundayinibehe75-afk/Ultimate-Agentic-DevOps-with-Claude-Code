# ---------------------------------------------------------------------------
# Remote state backend
#
# Setup steps:
#   1. Run `terraform init` with this block commented out (as it is now) and
#      `terraform apply` to create your infrastructure, including a dedicated
#      S3 bucket you'll designate for storing Terraform state.
#   2. Uncomment the `backend "s3"` block below and fill in the bucket name,
#      key, and region for that state bucket.
#   3. Run `terraform init -migrate-state` to migrate your local state file
#      into the S3 backend.
# ---------------------------------------------------------------------------

# terraform {
#   backend "s3" {
#     bucket       = "your-terraform-state-bucket"
#     key          = "portfolio-site/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
