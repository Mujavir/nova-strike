$c = [System.IO.File]::ReadAllText('index.html', [System.Text.Encoding]::UTF8)
$bad = [string][char]0x00E2+[char]0x20AC+[char]0x201C
$c = $c.Replace($bad, '-')
[System.IO.File]::WriteAllText('index.html', $c, [System.Text.Encoding]::UTF8)
Write-Host "Done. Replacements made."
