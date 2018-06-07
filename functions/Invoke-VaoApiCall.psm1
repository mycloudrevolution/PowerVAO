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
        Helper function to call the Veeam Availability Orchestrator API.

    .NOTES
        File Name  : Invoke-VaoApiCall.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready
    .LINK
        https://mycloudrevolution.com/

    .LINK
        https://helpcenter.veeam.com/docs/vao/restapi/overview.html?ver=10

    .EXAMPLE
        Invoke-VaoApiCall -Uri "/v1/About" -Method Get

    .PARAMETER Server
        FQDN of the Veeam Availability Orchestrator Instance

    .PARAMETER Token
        Bearer Token for the Veeam Availability Orchestrator Instance

    .PARAMETER Uri
        API Uri for the Call

    .PARAMETER Accept
        Accept Header for the API Call

    .PARAMETER Methode
        Methode of the API Call

    .PARAMETER Body
        Body of the API Call

    #>
        Param (
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="FQDN of the Veeam Availability Orchestrator Instance")]
            [ValidateNotNullorEmpty()]
                [String]$Server = $Global:VaoApiConnection.Server,
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Bearer Token for the Veeam Availability Orchestrator Instance")]
            [ValidateNotNullorEmpty()]
                [String]$Token = $Global:VaoApiConnection.access_token,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="API Uri for the Call")]
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
            $FullToken = "Bearer " + $Token
            #region: RESTful API Call
            if ($Method -like "Get" ) {
                $FullUri = "https://" + $Server + ":9899" +  $Uri
                $Headers =  @{'accept' = $Accept;'Authorization' = $FullToken}
                $Return = Invoke-RestMethod -uri $FullUri -Method $Method -Headers $Headers
            }
            elseif ($Method -like "Post") {
                if ($Body) {
                    $FullUri = "https://" + $Server + ":9899" +  $Uri
                    $Headers =  @{'accept' = $Accept;'Authorization' = $FullToken}
                    $Return = Invoke-RestMethod -uri $FullUri -Method $Method -Headers $Headers -Body $Body
                }
                else {
                    $FullUri = "https://" + $Server + ":9899" +  $Uri
                    $Headers =  @{'accept' = $Accept;'Authorization' = $FullToken}
                    $Return = Invoke-RestMethod -uri $FullUri -Method $Method -Headers $Headers
                }

            }
            #edregion

            $Return
        }
    }