#PowerShell script to map a network drive with credentials
#This block will be uncommented and pupulatedby ansible, 
#it is not really designed to be used as is

#Store the credentials securely
# Invoke-Expression "cmdkey /add:{{ share_path | regex_replace('\\\\\\\\(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\\\\.*', '\\1') }} /user:{{ share_user }} /pass:{{ share_password }}"

#Map the network drive
# Invoke-Expression "net use Z: {{ share_path }} /persistent:yes"
#Install Cholote
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))