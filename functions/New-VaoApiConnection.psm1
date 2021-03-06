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
        Connecto to Veeam Availability Orchestrator API.

    .NOTES
        File Name  : New-VaoApiConnectionl.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready

    .LINK
        https://mycloudrevolution.com/

    .LINK
        https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10

    .EXAMPLE
        $YourCredentials = Get-Credential
        New-VaoApiConnection -Server "vao01.lab.local" -Credential $YourCredentials

    .PARAMETER Server
        FQDN of the Veeam Availability Orchestrator Instance

    .PARAMETER Token
        Existing Token for renewal (not yet implemented)

    .PARAMETER Credential
        Credential for the Veeam Availability Orchestrator Instance

    #>
        Param (
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="FQDN of the Veeam Availability Orchestrator Instance")]
            [ValidateNotNullorEmpty()]
                [String]$Server,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Existing Token for renewal (not yet implemented)")]
            [ValidateNotNullorEmpty()]
                [String]$Token = $Global:VaoApiConnection.Token,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="Credential for the Veeam Availability Orchestrator Instance")]
            [ValidateNotNullorEmpty()]
                [Management.Automation.PSCredential]$Credential
        )
        Process {
            try {
                $FullUri = "https://" + $Server + ":9899" +  "/v1/About"
                $Headers =  @{'Accept' = 'application/json, text/json, text/html, application/xml, text/xml'}
                $Return = Invoke-RestMethod -uri $FullUri -Method Get -Headers $Headers
            }
            catch {
                Throw "Failed to contact Veeam Availability Orchestrator API. Login aborted!"
            }

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