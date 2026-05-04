$c = [System.IO.File]::ReadAllText('index.html', [System.Text.Encoding]::UTF8)

# Build bad strings from Unicode code points
$heart  = [string][char]0x00E2+[char]0x009D+[char]0x00A4+[char]0x00EF+[char]0x00B8+[char]0x008F
$pause  = [string][char]0x00E2+[char]0x008F+[char]0x00B8
$play   = [string][char]0x00E2+[char]0x2013+[char]0x00B6
$up     = [string][char]0x00E2+[char]0x2013+[char]0x00B2
$down   = [string][char]0x00E2+[char]0x2013+[char]0x00BC
$left   = [string][char]0x00E2+[char]0x2014+[char]0x20AC
$endash = [string][char]0x00E2+[char]0x20AC+[char]0x201C
$check  = [string][char]0x00E2+[char]0x0153+[char]0x201C

# Build good strings using [char] only (no literal non-ASCII in script)
$goodHeart = [string][char]0x2665
$goodPlay  = [string][char]0x25BA
$goodUp    = [string][char]0x25B2
$goodDown  = [string][char]0x25BC
$goodLeft  = [string][char]0x25C4
$goodMid   = [string][char]0x00B7

# Replace bad arrow/symbol sequences
$c = $c.Replace($heart,  $goodHeart)
$c = $c.Replace($pause,  '||')
$c = $c.Replace($play,   $goodPlay)
$c = $c.Replace($up,     $goodUp)
$c = $c.Replace($down,   $goodDown)
$c = $c.Replace($left,   $goodLeft)
$c = $c.Replace($endash, '-')
$c = $c.Replace($check,  'OK')

# Fix remaining garbled arrow from previous partial run (garbled version of goodPlay)
# Previous run wrote garbled goodPlay back in (win1252 of U+25BA)
$badPlay2 = [string][char]0x00E2+[char]0x2013+[char]0x00BA
$c = $c.Replace($badPlay2, $goodPlay)
$badUp2   = [string][char]0x00E2+[char]0x2013+[char]0x00B2  # same as $up, already handled
$badDown2 = [string][char]0x00E2+[char]0x2013+[char]0x00BC  # same as $down
$badLeft2 = [string][char]0x00E2+[char]0x2014+[char]0x20AC  # same as $left

# Fix duplicate words caused by previous run replacing emoji prefix only
$c = $c.Replace('COIN COIN COLOR SHOP', 'COIN COLOR SHOP')
$c = $c.Replace('COIN COIN COLOR', 'COIN COLOR')
$c = $c.Replace('VS VS FRIEND', 'VS FRIEND')
$c = $c.Replace('Bank Bank:', 'Bank:')
$c = $c.Replace('TROPHY VICTORY!', 'VICTORY!')
$c = $c.Replace('HOME MAIN MENU', 'MAIN MENU')
$c = $c.Replace('HOME MENU', 'MAIN MENU')
$c = $c.Replace('COIN Earned:', 'Earned:')

# Fix middle dot - Â· (C2=Â, B7=middot)
$badMid = [string][char]0x00C2+[char]0x00B7
$c = $c.Replace($badMid, $goodMid)

# Also fix garbled goodHeart from prev run if it wrote win1252 garble
# Previous [char]0x2665 written via win1252 = E2 99 A5 misread bytes...
# If ♥ was already written correctly, this won't match anything

[System.IO.File]::WriteAllText('index.html', $c, [System.Text.Encoding]::UTF8)
Write-Host "Done. Size: $($c.Length)"
