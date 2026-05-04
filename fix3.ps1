$lines = Get-Content 'index.html' -Encoding UTF8
$lines[159] = "      d.title=locked?name+' - '+COLOR_PRICES[name]+' coins':name[0].toUpperCase()+name.slice(1)+' (owned)';"
Set-Content 'index.html' -Value $lines -Encoding UTF8
Write-Host "Replaced line 160"

# Also fix "COIN COINS" in line 486
$lines = Get-Content 'index.html' -Encoding UTF8
$lines[486] = "    ctx.fillText('+'+levelUpMsg.coins+' COINS',W/2,H/2+18);"
Set-Content 'index.html' -Value $lines -Encoding UTF8
Write-Host "Replaced line 487"

