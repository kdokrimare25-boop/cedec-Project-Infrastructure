variable "aws_region" {
  description = "AWS region for S3 and regional resources. ACM for CloudFront must be in us-east-1."
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name used in tags and naming."
  type        = string
  default     = "dev"
}

variable "application" {
  description = "Application identifier for default tags."
  type        = string
  default     = "cdec-frontend"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name. Leave null to use {application}-{environment}-frontend."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow Terraform to delete the frontend bucket when it contains objects."
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable S3 versioning on the frontend bucket."
  type        = bool
  default     = false
}

variable "enable_spa_routing" {
  description = "Serve index.html for 403/404 responses (React client-side routing)."
  type        = bool
  default     = true
}

variable "cloudfront_aliases" {
  description = "Custom domain names for the distribution. Leave empty to use the default cloudfront.net hostname."
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1. Required if cloudfront_aliases is non-empty."
  type        = string
  default     = null
}

variable "create_dns_zone" {
  description = "If true, creates a Route 53 hosted zone. If false, set route53_zone_id."
  type        = bool
  default     = false
}

variable "dns_zone_name" {
  description = "Zone name when create_dns_zone is true, e.g. example.com."
  type        = string
  default     = null
}

variable "route53_zone_id" {
  description = "Existing hosted zone ID when create_dns_zone is false."
  type        = string
  default     = null
}

variable "dns_record_name" {
  description = "FQDN for alias records to CloudFront (e.g. www.example.com). Leave empty to skip DNS records."
  type        = string
  default     = ""
}
