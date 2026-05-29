# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region  = "eu-west-1"
environment = "dev"
application = "cdec-alpha-frontend"

# bucket_name = "cdec-alpha-dev-frontend"

# cloudfront_aliases  = ["www.your-domain.com"]
# acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/..."

# Use a domain you own — example.com is reserved by AWS and will fail
dns_zone_name   = "cloudnine.in"
dns_record_name = "www.cloudnine.in"
