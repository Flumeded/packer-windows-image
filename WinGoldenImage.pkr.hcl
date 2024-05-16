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

variable "winadmin_password" {
    type = string
    sensitive = true
}

variable "os_iso_path" {
    type = string
}

source "vsphere-iso" "Windows-server" {
  CPUs                 = "4"
  RAM                  = "4096"
  RAM_reserve_all      = true
  communicator         = "winrm"
  convert_to_template  = true
  datastore            = var.vsphere_datastore
  disk_controller_type = ["lsilogic-sas"]
  firmware             = "bios"
  floppy_files         = ["setup/autounattend.xml","setup/winrm_setup.ps1", "setup/vmwaretools_install.cmd", "setup/MAS_AIO.cmd"]
  guest_os_type        = "windows2019srvNext_64Guest"
  host                 = var.vsphere_host
  insecure_connection  = true
  iso_paths            = [var.os_iso_path, "[] /usr/lib/vmware/isoimages/windows.iso"]

  network_adapters {
    network      = var.vsphere_portgroup_name
    network_card = "vmxnet3"
  }
  password             = var.vsphere_password
  storage {
    disk_size             = "80000"
    disk_thin_provisioned = true
  }
  #type                 = "vsphere-iso"
  username             = var.vsphere_user
  vcenter_server       = var.vsphere_server
  vm_name              = "Win2022PackerImage80GB"
  winrm_password       = var.winadmin_password
  winrm_username       = "Administrator"
}

build {
  sources = ["source.vsphere-iso.Windows-server"]

  provisioner "windows-shell" {
    inline = ["A:\\MAS_AIO.cmd /KMS38"]
  }

provisioner "powershell" {
  elevated_user = "Administrator"
  elevated_password = var.winadmin_password
  script = "setup/win_configuration.ps1"
  execute_command = "powershell -ExecutionPolicy Bypass -File {{.Path}}"
}
}