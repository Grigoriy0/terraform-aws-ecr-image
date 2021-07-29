variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account id (12-digit number)"
  type        = string
}

variable "region" {
  description = "AWS region name"
  type        = string
}

variable "dockerfile" {
  description = "The Dockerfile path"
  type        = string
  default     = "Dockerfile"
}

variable "context" {
  description = "Context directory"
  type        = string
  default     = "."
}

variable "docker_image_tag" {
  description = "This is the tag which will be used for the image that you created"
  type        = string
  default     = "latest"
}

variable "build_arg" {
  description = "Optional --build-arg option value for building image"
  type        = string
  default     = null
}