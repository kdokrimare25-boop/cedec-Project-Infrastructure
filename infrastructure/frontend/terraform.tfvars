# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region  = "eu-west-1"
environment = "dev"
application = "cdec-alpha"

acm_certificate_arn = "arn:aws:acm:eu-west-1:933516006319:certificate/dab4d476-ddf2-40ef-ae09-0d3ced0e76e1"

# Use a domain you own — example.com is reserved by AWS and will fail
dns_zone_name   = "thecloudnine.in"
dns_record_name = "www.thecloudnine.in"
