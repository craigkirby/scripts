$account="domain\account"
net localgroup "Performance Monitor Users" /add $account
net localgroup "Distributed COM Users" /add $account
.\Set-WMINamespaceSecurity.ps1 root add $account Enable,RemoteAccess -allowinherit $true
