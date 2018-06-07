Function Set-VaoFailoverPlan {
    <#
    .DESCRIPTION
        Modify Veeam Availability Orchestrator FailoverPlan

    .NOTES
        File Name  : Set-VaoFailoverPlan.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE
        Set-VaoFailoverPlan -PlanID ed799d88-30f0-4494-b183-124e171afa91 -Enable

    .EXAMPLE
        Set-VaoFailoverPlan -PlanID ed799d88-30f0-4494-b183-124e171afa91 -Disable

    .PARAMETER PlanID
        Failover Plan ID

    .PARAMETER Enable
        Enable Failover Plan

    .PARAMETER Disable
        Disable Failover Plan
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