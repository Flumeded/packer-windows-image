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

