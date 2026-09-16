#!/usr/bin/env pwsh
Write-Host "Exportador HTML5 para Godot (Windows)"

# Caminhos baseados no local do script para serem robustos
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir '..')
$projectPath = Join-Path $repoRoot 'GODOT'

if (-not (Test-Path $projectPath)) {
    Write-Error "Não foi possível localizar a pasta do projeto Godot em $projectPath. Execute este script a partir da raiz do repositório."
    exit 1
}

# Usar o binário console para execução headless
$godotExe = Join-Path $projectPath 'Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64_console.exe'
if (-not (Test-Path $godotExe)) {
    Write-Error "Executável do Godot console não encontrado em: $godotExe. Coloque o executável nessa pasta ou edite o caminho no script."
    exit 1
}

$outputDir = Join-Path $repoRoot 'docs'
if (-not (Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir | Out-Null }

Write-Host "Exportando projeto Godot em: $projectPath"
Write-Host "Saída: $outputDir"

$presetName = 'HTML5'
$outputFile = Join-Path $outputDir 'index.html'

$godotArgs = @('--path', $projectPath, '--export-release', $presetName, $outputFile)
& $godotExe @godotArgs
$exit = $LASTEXITCODE
if ($exit -ne 0) {
    Write-Error "Exportação falhou com código $exit. Verifique se o preset de exportação '$presetName' existe (Project > Export no Godot) e se os templates de exportação HTML5 estão instalados."
    exit $exit
}

Write-Host "Exportação concluída: $outputFile"
Write-Host "Agora você pode commitar os arquivos em 'docs/' e o GitHub Pages os publicará." 
