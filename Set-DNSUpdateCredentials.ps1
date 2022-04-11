[cmdletbinding(DefaultParameterSetName = "GeneratePassword")]
param(
    [Parameter(Mandatory = $true, ParameterSetName = 'ProvideSecurePassword')]
    [SecureString]$SecurePassword = $null,

    [Parameter(Mandatory = $true, ParameterSetName = 'ProvideCleartextPassword')]
    [string]$CleartextPassword = $null,

    [Parameter(Mandatory = $true, ParameterSetName = 'GeneratePassword')]
    [switch]$GeneratePassword,
	
    [switch]$Silent,
    [switch]$OutputCleartextPassword,
    [switch]$OutputSecurePassword,
    [string]$DHCPServer
)

# Generates password if specified. Otherwise uses password provided.
if ($GeneratePassword) {
    Add-Type -AssemblyName 'System.Web'
    $length = Get-Random -Minimum 25 -Maximum 28
    $nonAlphaChars = Get-Random -Minimum 8 -Maximum 12
    $password = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlphaChars)
    $secret = ConvertTo-SecureString -String $password -AsPlainText -Force
}
elseif ($SecurePassword.IsPresent) {
    $secret = $SecurePassword
}
elseif ($CleartextPassword.IsPresent) {
    $secret = ConvertTo-SecureString -String $CleartextPassword -AsPlainText -Force
}

# Create user w/ permissions and set credential.
if ( -not($DHCPServer.IsPresent) ) {
    $DHCPServerAddress = "127.0.0.1"
}
else {
    $DHCPServerAddress = $DHCPServer
}

$userParams = @{
		"Name" = "DNSUpdate";
		"DisplayName" = "DNSUpdate";
		"AccountPassword" = $secret;
		"PasswordNeverExpires" = $true;
		"Enabled" = $true;
		"Description" = "Service account for DHCP server to update DNS records on client's behalf." 
}

try { 
	New-ADUser @userParams
}
catch { 
	if ($silent) {
		continue
	}
	else {
		Write-Host -Object "Error occurred, DNSUpdate user is likely already created. Remove user then run script again."
		exit
	}
}

Add-ADGroupMember -Identity "DNSUpdateProxy" -Members "DNSUpdate"

$credential = New-Object System.Management.Automation.PSCredential ("DNSUpdate", $secret)
Set-DhcpServerDnsCredential -Credential $credential -ComputerName $DHCPServerAddress

# Outputs credentials if specified.
if ($silent) {
    exit
}
else {
	$returnObj = "" | Select-Object SamAccountName, ClearText, SecurePass
	$userProperties = @{SamAccountName = "DNSUpdate"; CleartextPassword = "$password"; SecurePassword = "$secret" }

	$returnObj.SamAccountName = $userProperties['SamAccountName']	

	if ($OutputCleartextPassword) {
		$returnObj.ClearText = $userProperties['CleartextPassword']
	}

	if ($OutputSecurePassword) {
	$returnObj.SecurePass = $userProperties.SecurePassword
	} 
	else {
		$returnObj.SecurePass = $null
	}
}

return $returnObj

