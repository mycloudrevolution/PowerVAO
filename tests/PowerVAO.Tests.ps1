$moduleRoot = Resolve-Path "$PSScriptRoot\.."
$moduleName = "PowerVAO"

$EncryptedCred = "$env:LOCALAPPDATA\vscode-powershell\EncryptedVaoCred.clixml"
if (Test-Path -LiteralPath $EncryptedCred -ErrorAction SilentlyContinue) {
    $Credentials = Import-CliXml $EncryptedCred
}
else {
    $Credentials = Get-Credential
    $Credentials | Export-CliXml "$env:LOCALAPPDATA\vscode-powershell\EncryptedVaoCred.clixml"
}

$NsxFqdn = "$env:LOCALAPPDATA\vscode-powershell\VaoFqdn.txt"
if (Test-Path -LiteralPath $NsxFqdn) {
    [String]$FQDN = Get-Content "$env:LOCALAPPDATA\vscode-powershell\VaoFqdn.txt"
}
else {
    [String]$FQDN = Read-Host -Prompt 'FQDN'
    $FQDN | Out-File -FilePath "$env:LOCALAPPDATA\vscode-powershell\VaoFqdn.txt"
}

Describe "General Code validation: $moduleName" {

    $scripts = Get-ChildItem $moduleRoot -Include *.psm1, *.ps1, *.psm1 -Recurse
    $testCase = $scripts | Foreach-Object {@{file = $_}}
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }

    $modules = Get-ChildItem $moduleRoot -Include *.psd1 -Recurse
    $testCase = $modules | Foreach-Object {@{file = $_}}
    It "Module <file> can import cleanly" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist
        $error.clear()
        {Import-Module  $file.fullname } | Should Not Throw
        $error.Count | Should Be 0
    }
}

Describe "Module Function validation: $moduleName" {

    $modules = Get-ChildItem $moduleRoot -Include *.psd1 -Recurse
    Import-Module $modules -Global -Force
    if ($Global:VaoApiConnection) {
        Remove-Variable VaoApiConnection
    }

    It "Connect VAO API" {
        New-VaoApiConnection -Server $FQDN -Credential $Credentials
        ($Global:VaoApiConnection).token_type | Should -Be "bearer"
    }

    It "Get VAO Sites" {
        [Array]$Sites = Get-VaoSite
        $Sites.Count | Should -BeGreaterThan 0
    }

    It "Get VAO FailoverPlan" {
        [Array]$FailoverPlan = Get-VaoFailoverPlan
        $FailoverPlan.Count | Should -BeGreaterThan 0
    }
}
