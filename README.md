# Set-DNSUpdateCredentials.ps1
Powershell script to set MS DHCP Server's DNS Credentials. It will create a new user, make it a member of DNSUpdateProxy, and set it as the DHCP server's DNS credentials. This must be run on a server with DHCP, DNS and AD installed. If the DHCP server is on another IP, you can specify with "-DHCPServer".

Syntax:

Will specify the password in cleartext.
<pre><code>Get-DNSUpdateCredentials -CleartextPassword "string"</code></pre>

Will specify the password as a secure string.
<pre><code>Get-DNSUpdateCredentials -SecurePassword "string"</code></pre>

Returns the name of the user and will write an error if it fails to create one. 
<pre><code>Get-DNSUpdateCredentials -GeneratePassword</code></pre>

Will not return anything, success or fail.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -Silent</code></pre>

Returns cleartext password.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -OutputCleartextPassword</code></pre>

Returns password as a secure string.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -OutputSecurePassword</code></pre>

Will specify the DHCP server IP. This example generates a password, but it also works when providing one.
<pre><code>Get-DNSUpdateCredentials -GeneratePassword -DHCPServer  <string></code></pre>
