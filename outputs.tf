output "ecr_image_url" {
  value       = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.ecr_name}:${var.docker_image_tag}"
  description = "Full URL to image in ECR with tag"
}