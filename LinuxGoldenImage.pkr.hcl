variable "vsphere_server" {
    type = string
}

variable "vsphere_user" {
    type = string
}

variable "vsphere_password" {
    type = string
    sensitive = true
}

variable "vsphere_host" {
    type = string
}

variable "vsphere_portgroup_name" {
    type = string
}

variable "vsphere_datastore" {
    type = string
}

variable "os_iso_path" {
    type = string
}

variable "http_directory" {
  type    = string
  description = "Directory of config files(user-data, meta-data)."
  default = "http"
}

variable "ssh_password" {
    type = string
    sensitive = true
}

variable "ssh_username" {
    type = string
}

source "vsphere-iso" "linux-ubuntu-server" {
  CPUs                 = "1"
  RAM                  = "2000"
  convert_to_template  = true
  datastore            = "Datastore 1"
  disk_controller_type = ["pvscsi"]
  firmware             = "bios"
  guest_os_type        = "ubuntu64Guest"
  host                 = var.vsphere_host
  insecure_connection  = true
  tools_upgrade_policy = true
  remove_cdrom         = true
  cdrom_type           = "sata"
  iso_url              = "https://releases.ubuntu.com/jammy/ubuntu-22.04.4-live-server-amd64.iso"
  iso_checksum         = "45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2" 
  http_directory       = var.http_directory
  boot_wait            = "5s"
  cd_label = "cidata"
  cd_files = [
      "./${var.http_directory}/meta-data",
      "./${var.http_directory}/user-data"]

  network_adapters {
    network      = var.vsphere_portgroup_name
    network_card = "vmxnet3"
  }
  password             = var.vsphere_password
  storage {
    disk_size             = "10000"
    disk_thin_provisioned = true
  }
  username             = var.vsphere_user
  vcenter_server       = var.vsphere_server
  vm_name              = "Ubuntu 22.04 Golden"

  boot_command = [
    "e<down><down><down><end>",
    " autoinstall ds=nocloud;",
    "<F10>"
  ]

  ip_wait_timeout = "20m"
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ssh_port = 22
  ssh_timeout = "30m"
  ssh_handshake_attempts = "100"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = "15m"


}

build {
  sources = ["source.vsphere-iso.linux-ubuntu-server"]
}
