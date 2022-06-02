# Terraform AWS ECR Image
Terraform module to build and upload a docker image to an ECR Repository.

This module will:
1. log into ECR
2. run `docker build` with your arguments
3. push the built docker image to the ECR repository

## Minimal Usage
```hcl
module "ecr_image" {
  source         = "github.com/Grigoriy0/terraform-aws-ecr-image?ref=v1.3.0"
  ecr_name       = "application"
}
```
## Example with more configs
```hcl
module "ecr_image" {
  source           = "github.com/Grigoriy0/terraform-aws-ecr-image?ref=v1.3.0"
  ecr_name         = "application"
  region           = "us-east-1"
  context          = "context-directory"
  dockerfile       = "app.Dockerfile"
  docker_image_tag = "v1.2.0"
  build_arg        = "ARG=value"
}
```

## Requirements
Terraform version `1.2.0` or greater.

This module requires the following programs in the PATH:
* `bash`
* `aws` CLI v2
* `docker` (with the daemon running)
* `md5` or `md5sum`

## Inputs
| Name             | Description                                                                                       | Default    |
|------------------|---------------------------------------------------------------------------------------------------|------------|
| **ecr_name**     | Name of the ECR repository                                                                        |            |
| region           | AWS region of the ECR registry                                                                    |            |
| dockerfile       | Name of the Dockerfile with local path                                                            | Dockerfile |
| context          | Docker context folder. This module will run a `docker build` with this directory as last argument | .          |
| docker_image_tag | This is the tag which will be used for the image that you created.                                | latest     |
| build_arg        | It's optional `--build-arg` argument value for `docker build` command                             | null       |

## Outputs
| Name          | Description                        |
|---------------|------------------------------------|
| ecr_image_url | Full URL to image in ECR with tag. |
