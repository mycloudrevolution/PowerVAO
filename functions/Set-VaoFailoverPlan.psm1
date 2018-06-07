Function Set-VaoFailoverPlan {
    <#
    .DESCRIPTION
        Modify VAO FailoverPlan

    .NOTES
        File Name  : Set-VaoFailoverPlan.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Test

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE

    .PARAMETER PlanID
        Failover Plan ID

    #>
        Param (
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="Failover Plan ID")]
            [ValidateNotNullorEmpty()]
                [String]$PlanID,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, ParameterSetName="Enable", HelpMessage="Enable Failover Plan")]
            [ValidateNotNullorEmpty()]
                [Switch]$Enable,
            [Parameter(Mandatory=$True, ValueFromPipeline=$False, ParameterSetName="Disable", HelpMessage="Disable Failover Plan")]
            [ValidateNotNullorEmpty()]
                [Switch]$Disable
        )
        Process {
            if ($Enable) {
                $Return = Invoke-VaoApiCall -Uri "/v1/FailoverPlans/$PlanID/Enable" -Method Post 
            }
            elseif ($Disable) {
                $Return = Invoke-VaoApiCall -Uri "/v1/FailoverPlans/$PlanID/Disable" -Method Post 
            }

            $Return
        }
    }