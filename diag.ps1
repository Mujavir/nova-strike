$c = [System.IO.File]::ReadAllText('index.html', [System.Text.Encoding]::UTF8)
$lines = $c -split "`n"
$line = $lines[159]  # 0-indexed, so line 160
$idx = $line.IndexOf("name+' ")
if ($idx -ge 0) {
    # Print the chars around the dash
    $start = $idx + 7
    for ($i = $start; $i -lt [Math]::Min($start+5, $line.Length); $i++) {
        Write-Host "char[$i]: U+$([int][char]$line[$i]) '$($line[$i])'"
    }
} else {
    Write-Host "Pattern not found in line 160"
    Write-Host $line.Substring(0, [Math]::Min(80,$line.Length))
}
