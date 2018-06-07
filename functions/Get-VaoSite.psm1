Function Get-VaoSite {
    <#
    .DESCRIPTION
        Get All VAO Sites

    .NOTES
        File Name  : Get-VaoSite.psm1
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
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites/$SiteID" -Method Get 
            }
            else {
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites" -Method Get 
            }

            $Return
        }
    }