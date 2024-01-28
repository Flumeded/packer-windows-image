## Homelab Windows Golden Image

This is a packer config which prepares a Windows image for further deployment in my Homelab.

It covers some basic things like:

* Installs VMware tools
* Enables RDP and WINRM
* Installs the latest Windows update
* Activates Windows
* Makes various QOL Windows changes

### Prerequisites

You need to supply two files for further configuration:

* [TMAS All-in-One activiation script](https://github.com/massgravel/Microsoft-Activation-Scripts/blob/master/MAS/All-In-One-Version/MAS_AIO.cmd)  
Place in the `setup` folder under `MAS_AIO.cmd` name.  
* VMware Tools ISO file  
Place it on the datastore.  
* Windows Server 2022 ISO  
Place it on the datastore as well.

### How to use

1) Fill and rename (remove ``.empty`` part) `variables.pkrvars.hcl.empty` variables file.  
You can reference [this article](https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso#hardware-configuration) for more information.
2) Find and replace `#REPLACE_ME#` tags in the `setup\autounattend.xml`
3) Run packer with:
```bash
packer build -var-file=variables.pkrvars.hcl WinGoldeImange.pkr.hcl
```

