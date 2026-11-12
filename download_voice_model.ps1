$ErrorActionPreference = 'Stop'
$ModelName = 'vosk-model-small-en-us-0.15'
$Base = Join-Path $env:LOCALAPPDATA 'AURIX'
$Target = Join-Path $Base $ModelName
$Zip = Join-Path $env:TEMP "$ModelName.zip"
$Extract = Join-Path $env:TEMP "aurix-vosk-extract"

if (Test-Path $Target) {
    Write-Host "Vosk model already exists at: $Target" -ForegroundColor Green
    exit 0
}
New-Item -ItemType Directory -Force -Path $Base | Out-Null
if (Test-Path $Extract) { Remove-Item -Recurse -Force $Extract }
New-Item -ItemType Directory -Force -Path $Extract | Out-Null
$Url = "https://alphacephei.com/vosk/models/$ModelName.zip"
Write-Host "Downloading the 40 MB English offline speech model from the Vosk project..."
Invoke-WebRequest -Uri $Url -OutFile $Zip
Expand-Archive -Path $Zip -DestinationPath $Extract -Force
$Candidate = Join-Path $Extract $ModelName
if (-not (Test-Path $Candidate)) {
    $Candidate = Get-ChildItem -Path $Extract -Directory | Select-Object -First 1 -ExpandProperty FullName
}
if (-not $Candidate -or -not (Test-Path $Candidate)) {
    throw 'The downloaded archive did not contain a model folder.'
}
Move-Item -Path $Candidate -Destination $Target
Remove-Item -Force $Zip -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force $Extract -ErrorAction SilentlyContinue
Write-Host "Offline voice model installed: $Target" -ForegroundColor Green
Write-Host 'Open AURIX Configuration and confirm that the Offline Vosk model folder points to this folder.'
