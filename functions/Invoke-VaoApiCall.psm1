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
Function Invoke-VaoApiCall {
    <#
    .DESCRIPTION
        Helper Function to call the Veeam Availability Orchestrator API.

    .NOTES
        File Name  : Invoke-VaoApiCall.psm1
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
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="FQDN")]
            [ValidateNotNullorEmpty()]
                [String]$Server = $Global:VaoApiConnection.Server,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="API Token String")]
            [ValidateNotNullorEmpty()]
                [String]$Token = $Global:VaoApiConnection.access_token,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="API Uri")]
            [ValidateNotNullorEmpty()]
                [String]$Uri,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Accept Header for the API Call")]
            [ValidateNotNullorEmpty()]
                [String]$Accept = "application/json, text/json, text/html, application/xml, text/xml",
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="Method of the API Call")]
            [ValidateNotNullorEmpty()]
            [ValidateSet("Get","Post")]
                [String]$Method,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Body of the API Call")]
            [ValidateNotNullorEmpty()]
                $Body
        )
        Process {
            $FullToken= "Bearer " + $Token
            #region: RESTful API Call
            if ($Method -like "Get" ) {
                $FullUri = "https://" + $Server + ":9899" +  $Uri
                $Headers =  @{'accept' = $Accept;'Authorization' = $FullToken}
                $Return = Invoke-RestMethod -uri $FullUri -Method $Method -Headers $Headers    
            }
            elseif ($Method -like "Post") {
                $FullUri = "https://" + $Server + ":9899" +  $Uri
                $Headers =  @{'accept' = $Accept;'Authorization' = $Token}
                $Return = Invoke-RestMethod -uri $FullUri -Method $Method -Headers $Headers -Body $Body       
            }
            #edregion

            $Return
        }
    }