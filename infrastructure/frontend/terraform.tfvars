# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region  = "eu-north-1"
environment = "dev"
application = "cdec-alpha"

acm_certificate_arn = "arn:aws:acm:eu-north-1:072929087802:certificate/3ed414fa-025b-4aaf-969c-9d146316d70b"

# Use a domain you own — example.com is reserved by AWS and will fail
dns_zone_name   = "ashaorganicsprocessunit.shop"
dns_record_name = "www.ashaorganicsprocessunit.shop"
