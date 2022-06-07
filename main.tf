locals {
  build_arg = var.build_arg != null ? "--build-arg=${var.build_arg}" : ""
  region = var.region == "" ? data.aws_region.current.name : var.region
  account_id = data.aws_caller_identity.current.account_id
}
# Checks if build folder has changed
data "external" "build_dir" {
  program = ["bash", "${path.module}/bin/dir_md5.sh", var.context]
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Builds test-service and pushes it into aws_ecr_repository
resource "null_resource" "ecr_image" {
  triggers = {
    build_folder_content_md5 = data.external.build_dir.result.md5
    name                     = var.ecr_name
    docker_image_tag         = var.docker_image_tag
    dockerfile               = var.dockerfile
    context                  = var.context
    build_arg                = local.build_arg
  }

  # Runs the build.sh script which builds the dockerfile and pushes to ecr
  provisioner "local-exec" {
    command = "bash ${path.module}/bin/build.sh ${var.ecr_name} ${var.docker_image_tag} ${var.dockerfile} ${var.context} ${local.region} ${local.account_id} \"${local.build_arg}\""
  }

}

output "id" {
  value = data.aws_caller_identity.current.account_id
}
