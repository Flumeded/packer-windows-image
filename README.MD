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
* Windows Server 2022 ISO  
Place it on the datastore as well.

### How to use

1) Fill and rename (remove ``.empty`` part) `variables.pkrvars.hcl.empty` variables file.  
You can reference [this article](https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso#hardware-configuration) for more information.
2) Find and replace `#Replace_` tags in the `setup\autounattend.xml`  
3) Make sure vsphere plugin is installed:
```bash
packer plugins install github.com/hashicorp/vsphere
```
4) Run packer with:
```bash
packer build -var-file=variables.pkrvars.hcl WinGoldeImange.pkr.hcl
```
### Extra
There is a small Ansible Playbook available for quick repository preparation for use in production.  
It is mostly designed for my personal use, but it is relatively use to adjust it.  
Run with:  
```bash
 ansible-playbook playbook.yml --vault-password ~/vault-pass 
```
