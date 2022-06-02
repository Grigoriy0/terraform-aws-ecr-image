output "ecr_image_url" {
  value       = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/${var.ecr_name}:${var.docker_image_tag}"
  description = "Full URL to image in ECR with tag"
}
