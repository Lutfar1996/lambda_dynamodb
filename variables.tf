variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"  # Set the default region or leave it empty to require user input
}



variable "accountId" {
    type = number
    default = 390402542649
  
}