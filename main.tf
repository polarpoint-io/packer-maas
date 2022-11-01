terraform {
  required_providers {
    packer = {
      source = "toowoxx/packer"
    }
  }
}

provider "packer" {}

data "packer_version" "version" {}

data "packer_files" "files2" {
  directory = "ubuntu"
}



resource "random_string" "random" {
  length  = 16
  special = false
  lower   = true
  upper   = true
  number  = true
}

resource "packer_image" "image2" {
  directory = data.packer_files.files2.directory
  force     = true
  variables = {
    test_var3 = "test 3"
  }
  ignore_environment = false
  name               = random_string.random.result

  triggers = {
    packer_version = data.packer_version.version.version
    files_hash     = data.packer_files.files2.files_hash
  }
}

output "packer_version" {
  value = data.packer_version.version.version
}

output "build_uuid_2" {
  value = resource.packer_image.image2.build_uuid
}
