variable "ubuntu_series" {
  type        = string
  default     = "focal"
  description = "The codename of the Ubuntu series to build."
}

variable "filename" {
  type        = string
  default     = "custom-cloudimg.tar.gz"
  description = "The filename of the tarball to produce"
}

variable "kernel" {
  type        = string
  default     = ""
  description = "The package name of the kernel to install. May include version string, e.g linux-image-generic-hwe-22.04=5.15.0.41.43"
}

variable "customize_script" {
  type        = string
  description = "The filename of the script that will run in the VM to customize the image."
}

variable "architecture" {
  type        = string
  default     = "amd64"
  description = "The architecture to build the image for (amd64 or arm64)"
}

variable "headless" {
  type        = bool
  default     = true
  description = "Whether VNC viewer should not be launched."
}

variable "http_directory" {
  type        = string
  default     = "http"
  description = "Directory for files to be accessed over http in the VM."
}

variable "http_proxy" {
  type        = string
  default     = "${env("http_proxy")}"
  description = "HTTP proxy to use when customizing the image inside the VM. The http_proxy enviroment is set, and apt is configured to use the http proxy"
}

variable "https_proxy" {
  type        = string
  default     = "${env("https_proxy")}"
  description = "HTTPS proxy to use when customizing the image inside the VM. The https_proxy enviroment is set, and apt is configured to use the https proxy"
}

variable "no_proxy" {
  type        = string
  default     = "${env("no_proxy")}"
  description = "NO_PROXY environment to use when customizing the image inside the VM."
}

variable "ssh_password" {
  type        = string
  default     = "ubuntu"
  description = "SSH password to use to connect to the VM to customize the image. Needs to match the hashed password in user-data-cloudimg."
}

variable "ssh_username" {
  type        = string
  default     = "root"
  description = "SSH user to use to connect to the VM to customize the image. Needs to match the user in user-data-cloudimg."
}

locals {
  qemu_arch = {
    "amd64" = "x86_64"
    "arm64" = "aarch64"
  }
  uefi_imp = {
    "amd64" = "OVMF"
    "arm64" = "AAVMF"
  }
  qemu_machine = {
    "amd64" = "ubuntu,accel=kvm"
    "arm64" = "virt"
  }
  qemu_cpu = {
    "amd64" = "host"
    "arm64" = "cortex-a57"
  }

  proxy_env = [
    "http_proxy=${var.http_proxy}",
    "https_proxy=${var.https_proxy}",
    "no_proxy=${var.https_proxy}",
  ]
}
