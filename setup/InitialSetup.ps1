$ErrorActionPreference = "Stop"

#Switch network connection to private mode
#Required for WinRM firewall rules
$profile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

#Install PS Windows Update Module

Get-PackageProvider -name nuget -force
Install-Module PSWindowsUpdate -confirm:$false -force
Get-WindowsUpdate -MicrosoftUpdate -install -IgnoreUserInput -acceptall -AutoReboot | Out-File -filepath 'c:\windowsupdate.log' -append

#WinRM Configure
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'


#PowerShell script to map a network drive with credentials
#This block will be uncommented and pupulatedby ansible, 
#it is not really designed to be used as is

# $NetworkPath = "{{ share_path }}"  # Specify the network path
# $DriveLetter = "Z:"             # Specify the drive letter to assign to the network share
# $Username = "{{ share_user }}"   # Specify the username
# $Password = "{{ share_password }}"          # Specify the password
# $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, ($Password | ConvertTo-SecureString -AsPlainText -Force)

#Map the network drive
# New-PSDrive -Name ($DriveLetter -replace ':', '') -PSProvider FileSystem -Root $NetworkPath -Credential $Credential -Persist