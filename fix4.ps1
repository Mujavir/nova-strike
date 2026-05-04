$content = Get-Content 'index.html' -Encoding UTF8
$content[486] = "    ctx.fillText('+'+levelUpMsg.coins+' COINS',W/2,H/2+18);"
[System.IO.File]::WriteAllLines((Resolve-Path 'index.html').Path, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done"
