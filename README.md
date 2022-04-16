# Set-DNSUpdateCredentials.ps1
Powershell script to set MS DHCP Server's DNS Credentials.

This must be run on a server with DHCP, DNS and AD installed. It will create a new user, make it a member of DNSUpdateProxy, and set it as the DHCP server's DNS credentials.

Syntax:

Returns the name of the user and will write an error if it fails to create one. 
<pre><code>Get-DNSUpdateCredentials -GeneratePassword</code></pre>

This will not return anything, success or fail.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -Silent</code></pre>

This will return the cleartext password.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -OutputCleartextPassword</code></pre>

This will return the password as a secure string.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -OutputSecurePassword</code></pre>
