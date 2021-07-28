variable "dockerfile" {
  type        = string
  description = "The Dockerfile path"
  default     = "Dockerfile"
}

variable "ecr_repository_url" {
  type        = string
  description = "Full url for the ECR repository"
}

variable "context" {
  type        = string
  description = "Context directory"
  default     = "."
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}
