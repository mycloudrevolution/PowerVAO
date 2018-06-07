Function Get-VaoSite {
    <#
    .DESCRIPTION
        Get Veeam Availability Orchestrator Sites

    .NOTES
        File Name  : Get-VaoSite.psm1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE
        Get-VaoSite | Select-Object name, id, serverName, type | ft -AutoSize

    .EXAMPLE
        Get-VaoSite -SiteID 850316df-d73f-4e8b-b8bc-7b1815fb0a9e | Select-Object name, id, serverName, type | ft -AutoSize

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
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites/$SiteID" -Method Get
            }
            else {
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites" -Method Get
            }

            $Return
        }
    }