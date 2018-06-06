#region: Workaround for SelfSigned Cert and force TLS 1.2
add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#endregion
Function New-VaoApiConnection {
    <#
    .DESCRIPTION
        HConnecto to Veeam Availability Orchestrator API.

    .NOTES
        File Name  : New-VaoApiConnectionl.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Test

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE

    .PARAMETER Server
        FQDN of the VAO Instance

    #>
        Param (
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="FQDN")]
            [ValidateNotNullorEmpty()]
                [String]$Server,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="API Token String")]
            [ValidateNotNullorEmpty()]
                [String]$Token = $Global:VaoApiConnection.Token,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="Credential")]
            [ValidateNotNullorEmpty()]
                [Management.Automation.PSCredential]$Credential
        )
        Process {
            $username = $Credential.UserName
            $password = $Credential.GetNetworkCredential().Password

            $FullUri = "https://" + $Server + ":9899" +  "/v1/Accounts/Token"
            $Headers =  @{'Content-Type' = 'application/x-www-form-urlencoded'}
            $Body = @{      grant_type = 'password';
                            username = $username;
                            password = $password;
                            refresh_token = $Token
                    } 
            $Return = Invoke-RestMethod -uri $FullUri -Method POST -Headers $Headers -Body $Body       

            #region: Cleanup Confidential Data
            Clear-Variable -Name username, password
            #endregion

            #region: Build Connection Variable
            $Global:VaoApiConnection = [pscustomobject]@{
                Server = $Server
                access_token = [String]$Return.access_token
                refresh_token = [String]$Return.refresh_token
                token_type = [String]$Return.token_type
            }
            #endregion

            $Global:VaoApiConnection
        }
    }