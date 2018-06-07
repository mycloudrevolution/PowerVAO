Function Get-VaoFailoverPlan {
    <#
    .DESCRIPTION
        Get All VAO FailoverPlans

    .NOTES
        File Name  : Get-VaoFailoverPlan.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Test

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE

    .PARAMETER SiteID
        Optional VAO Site ID

    #>
        Param (
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Optional VAO Site ID")]
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