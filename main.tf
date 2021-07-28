locals {
  registry_url = split("/", var.ecr_repository_url)[0]
  name         = split("/", var.ecr_repository_url)[1]
}

# Checks if build folder has changed
data "external" "build_dir" {
  program = ["bash", "${path.module}/bin/dir_md5.sh", var.context]
}

# Builds test-service and pushes it into aws_ecr_repository
resource "null_resource" "ecr_image" {
  triggers = {
    build_folder_content_md5 = data.external.build_dir.result.md5
  }

  # Runs the build.sh script which builds the dockerfile and pushes to ecr
  provisioner "local-exec" {
    command = "bash ${path.module}/bin/build.sh ${local.registry_url} ${local.name}:${var.docker_image_tag} ${var.dockerfile} ${var.context}"
  }
}