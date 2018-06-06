Function Get-VaoFailoverPlans {
    <#
    .DESCRIPTION
        Get All VAO FailoverPlans

    .NOTES
        File Name  : Get-VaoFailoverPlans.psm1
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
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Optional Site ID")]
            [ValidateNotNullorEmpty()]
                [String]$SiteID
        )
        Process {
            if ($SiteID) {
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites/$SiteID/FailoverPlans" -Method Get 
            }
            else {
                $Return = Invoke-VaoApiCall -Uri "/v1/FailoverPlans" -Method Get 
            }

            $Return
        }
    }