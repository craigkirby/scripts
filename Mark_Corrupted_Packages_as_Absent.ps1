# Get-ItemProperty "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\*" | ?{$_.Currentstate -eq "64"} | select PSchildName

# Resolution for WU error 0x80073701 / 0x800f0831:

# Run this Mark_Corrupted_Packages_as_Absent.ps1 file in an admin PowerShell, reboot the device and reapply the Patch Tuesday KB.
# The script will mark the corrupted packages as absent.

$name = 'CurrentState'

$check=(get-childitem -Path 'HKLM:\software\microsoft\windows\currentversion\component based servicing\packages' -Recurse).Name

foreach($check1 in $check) {
	$check2=$check1.replace("HKEY_LOCAL_MACHINE","HKLM:")
	
	if ( (Get-ItemProperty -Path $check2).$name -eq 0x50 -or (Get-ItemProperty -Path $check2).$name -eq 0x40 ) {
		write-host (Get-ItemProperty -Path $check2).PSChildName
		Set-ItemProperty -Path $check2 -Name $name -Value 0
	}
	
}