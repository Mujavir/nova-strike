const fs = require('fs');
let c = fs.readFileSync('index.html', 'utf8');

// Each garbled sequence mapped to clean replacement
const fixes = [
  // Hearts (❤️)
  ['\u00e2\u009d\u00a4\u00ef\u00b8\u008f', '\u2665'],
  // Pause symbol (⏸)
  ['\u00e2\u00b8', '\u007c\u007c'],
  // Play/right triangle (▶)
  ['\u00e2\u0096\u00b6', '\u25ba'],
  // Up triangle (▲)
  ['\u00e2\u0096\u00b2', '\u25b2'],
  // Down triangle (▼)
  ['\u00e2\u0096\u00bc', '\u25bc'],
  // Left triangle (◀)
  ['\u00e2\u0097\u0080', '\u25c4'],
  // Fire emoji 🔥
  ['\u00f0\u009f\u0094\u00a5', 'FIRE'],
  // Warning ⚠
  ['\u00e2\u009a\u00a0', '!'],
  // House 🏠
  ['\u00f0\u009f\u008f\u00a0', 'HOME'],
  // Coin 🪙
  ['\u00f0\u009f\u00aa\u0099', 'COIN'],
  // Middle dot (Â·)
  ['\u00c2\u00b7', '\u00b7'],
  // Degree sign (Â°)
  ['\u00c2\u00b0', '\u00b0'],
  // VS/explosion 👥
  ['\u00f0\u009f\u0091\u00a5', 'VS'],
  // Shield 🛡
  ['\u00f0\u009f\u009b\u00a1', '[S]'],
  // Lightning ⚡
  ['\u00e2\u009a\u00a1', 'ZAP'],
  // Bomb 💣
  ['\u00f0\u009f\u0092\u00a3', '[T]'],
  // Pill 💊
  ['\u00f0\u009f\u0092\u008a', '[+]'],
  // Art palette 🎨
  ['\u00f0\u009f\u008e\u00a8', ''],
  // Bank 🏦
  ['\u00f0\u009f\u008f\u00a6', 'Bank'],
  // Trophy 🏆
  ['\u00f0\u009f\u008f\u0086', 'TROPHY'],
  // Em dash (â€")
  ['\u00e2\u0080\u0093', '-'],
  // Checkmark (âœ")
  ['\u00e2\u009c\u0093', 'OK'],
  // En dash
  ['\u00e2\u0080\u0094', '-'],
];

let count = 0;
for (const [bad, good] of fixes) {
  const before = c.length;
  c = c.split(bad).join(good);
  if (c.length !== before) {
    count++;
    console.log('Fixed:', JSON.stringify(bad), '->', JSON.stringify(good));
  }
}

fs.writeFileSync('index.html', c, 'utf8');
console.log('Done! Fixed', count, 'patterns. File size:', c.length, 'bytes');
