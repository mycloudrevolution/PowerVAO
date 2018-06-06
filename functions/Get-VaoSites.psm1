Function Get-VaoSites {
    <#
    .DESCRIPTION
        Get All VAO Sites

    .NOTES
        File Name  : Get-VaoSites.psm1
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
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites/$SiteID" -Method Get 
            }
            else {
                $Return = Invoke-VaoApiCall -Uri "/v1/Sites" -Method Get 
            }

            $Return
        }
    }