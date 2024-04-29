#PowerShell script to map a network drive with credentials
#This block will be uncommented and pupulatedby ansible, 
#it is not really designed to be used as is

$NetworkPath = "\\192.168.31.188\Homelab_Share"  # Specify the network path
$DriveLetter = "Z:"             # Specify the drive letter to assign to the network share
$Username = "share-user"   # Specify the username
$Password = "mrx_NWX4wcu5tzp7hzd"          # Specify the password
$Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, ($Password | ConvertTo-SecureString -AsPlainText -Force)

#Map the network drive
New-PSDrive -Name ($DriveLetter -replace ':', '') -PSProvider FileSystem -Root $NetworkPath -Credential $Credential -Persist

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))