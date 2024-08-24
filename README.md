# Set-DNSUpdateCredential.ps1
Powershell script to set Microsoft DHCP Server's DNS Credential. It will create a new user, make it a member of DNSUpdateProxy, and set it as the DHCP server's account to access the DNS server for dynamic updates. This must be run on a server with AD installed. If the DHCP server is on another IP, you can specify with "-DHCPServer".

Syntax:

Will specify the password in cleartext.
<pre><code>Set-DNSUpdateCredential -CleartextPassword "Password"</code></pre>

Will specify the password as a secure string.
<pre><code>Set-DNSUpdateCredential -SecurePassword [SecureString]</code></pre>

Will generate a password.
<pre><code>Set-DNSUpdateCredential -GeneratePassword</code></pre>

Will not return anything, success or fail.
<pre><code>Set-DNSUpdateCredential -GeneratePassword -Silent</code></pre>

Returns cleartext password.
<pre><code>Set-DNSUpdateCredential -GeneratePassword -OutputCleartextPassword</code></pre>

Returns password as a secure string.
<pre><code>Set-DNSUpdateCredential -GeneratePassword -OutputSecurePassword</code></pre>

Will specify the DHCP server IP. This example generates a password, but it also works when providing one.
<pre><code>Set-DNSUpdateCredential -GeneratePassword -DHCPServer "IP/hostname" <string></code></pre>
