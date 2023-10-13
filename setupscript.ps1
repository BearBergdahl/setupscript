<#PSScriptInfo
 
.VERSION 1.0

.COMPANYNAME M�lk Utbildning

.AUTHOR Bj�rn Bergdahl
 
.COPYRIGHT MIT License
  
.LICENSEURI https://opensource.org/license/mit/

 
#>

<#
 
.DESCRIPTION
 Setup a development environment with Git, Node, Python, VS Code and VS
#>
Param()

# This script is intentionally kept simple to demonstrate basic automation techniques.

Write-Output "You must run this script in an elevated command shell, using 'Run as Administator'"

$title = "Setup Development Environment"
$message = "Select the appropriate option to continue."

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Install Software using winget", `
  "Setup development environment."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&Exit", `
  "Do not execute script."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 1)

switch ($result) {
  0 {
    Write-Output "Installing winget"
    winget install --id Git.Git -e --source winget
    Write-Output "Refreshing environment variables. If rest of the scritp fails, restart elevated shell and rerun script."

    Write-Output "Assuming winget is already installed"
    Write-Output "Installing Git & GitHub Desktop"
    winget install Git.Git
    winget install Github.GithubDesktop

    Write-Output "Installing NodeJS"
    winget install OpenJS.NodeJS.LTS

    Write-Output "Installing VS Code"
    winget install -e --id Microsoft.VisualStudioCode

    Write-Output "Installing VS Community"
    winget install -e --id Microsoft.VisualStudio.2022.Community
    Write-Output "Installing Python"
    winget

    RefreshEnv.cmd
    Write-Output "Results:"
    Write-Output "Verify installation of Git and Github Desktop, Node/NPM."
    $gitVersion = git.exe --version
    Write-Output "git: $gitVersion"
    $nodeVersion = node.exe -v
    Write-Output "Node: $nodeVersion"
    $npmVersion = npm.cmd -v
    Write-Output "npm: $npmVersion"
    $vscodeversion = code -v
    Write-Output "VSCode: $vscodeversion"
    $dotnetversion = dotnet
    Write-Output "$dotnetversion"
    $pythonversion = python -V
    Write-Output "Python: $pythonversion"
    }
  1 { "Aborted." }
  }