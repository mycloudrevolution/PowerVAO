Function Get-VaoFailoverPlan {
    <#
    .DESCRIPTION
        Get Veeam Availability Orchestrator Failover Plans

    .NOTES
        File Name  : Get-VaoFailoverPlan.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Test

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE
        Get-VaoFailoverPlan | Select-Object name, id, planState, planStateDetails, scheduleEnabled, siteId | ft -AutoSize

    .EXAMPLE
        Get-VaoFailoverPlan -SiteID 850316df-d73f-4e8b-b8bc-7b1815fb0a9e | Select-Object name, id, planState, planStateDetails, scheduleEnabled, siteId | ft -AutoSize

    .PARAMETER SiteID
        Optional Veeam Availability Orchestrator Site ID

    #>
        Param (
            [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Optional Veeam Availability Orchestrator Site ID")]
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