#!/bin/sh
# Génère index.html (app installable) à partir de gabriel.html (source unique).
cd "$(dirname "$0")" || exit 1
{
  cat <<'HEAD'
<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0E0E0D">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Gabriel">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" type="image/png" sizes="192x192" href="icons/icon-192.png">
<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">
HEAD
  sed -n '1,/<\/style>/p' gabriel.html
  printf '<style>body{overscroll-behavior:none}@media (max-width:859px){body{background:#0E0E0D}}</style>\n</head>\n<body>\n'
  sed -n '/<\/style>/,$p' gabriel.html | tail -n +2
  cat <<'FOOT'
<script>
if ('serviceWorker' in navigator && location.protocol !== 'file:') {
  window.addEventListener('load', function () { navigator.serviceWorker.register('sw.js').catch(function () {}); });
}
</script>
</body>
</html>
FOOT
} > index.html
echo "index.html généré"
