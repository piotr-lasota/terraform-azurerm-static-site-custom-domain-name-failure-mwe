variable "minimum_working_example_name" {
  description = "Resources name to be used with appropriate resource type prefixes"
  type        = string
  default     = "terraform-mwe"
}

variable "domain_name" {
  description = "The domain you will map to (like mywebsite.com)"
  type        = string
  default     = "mywebsite.com"
}