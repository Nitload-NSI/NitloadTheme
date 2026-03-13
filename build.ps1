param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release'
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$solutionPath = Join-Path $repoRoot 'NitloadTheme.sln'
$vswherePath = 'C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe'

if (-not (Test-Path $vswherePath)) {
    throw 'vswhere.exe was not found. Install Visual Studio 2026 or Visual Studio Installer first.'
}

$msbuildPath = & $vswherePath -latest -version '[18.0,19.0)' -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe | Select-Object -First 1

if (-not $msbuildPath) {
    throw 'Visual Studio 2026 MSBuild was not found. This repository is configured to build only with the VS2026 toolchain.'
}

Write-Host "Using MSBuild: $msbuildPath"

& $msbuildPath $solutionPath /restore /t:Build /p:Configuration=$Configuration /p:Platform='Any CPU' /p:VisualStudioVersion=18.0

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

 $vsixPath = Join-Path $repoRoot "NitloadTheme\bin\$Configuration\NitloadTheme.vsix"

Write-Host 'Build completed successfully.'
Write-Host "VSIX: $vsixPath"