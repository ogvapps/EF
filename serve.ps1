$root = "D:\Aplicaciones\EF\build\web"
$port = 8080
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Server running at http://localhost:$port/"
while ($true) {
    $ctx = $listener.GetContext()
    $path = $ctx.Request.Url.LocalPath.TrimStart('/')
    if ($path -eq '') { $path = 'index.html' }
    $full = Join-Path $root $path
    $mime = @{
        '.html' = 'text/html'
        '.js' = 'application/javascript'
        '.wasm' = 'application/wasm'
        '.json' = 'application/json'
        '.png' = 'image/png'
        '.svg' = 'image/svg+xml'
        '.css' = 'text/css'
    }
    $ext = [System.IO.Path]::GetExtension($full).ToLower()
    if (Test-Path $full) {
        $bytes = [System.IO.File]::ReadAllBytes($full)
        $ctx.Response.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { 'application/octet-stream' }
        $ctx.Response.ContentLength64 = $bytes.Length
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $ctx.Response.StatusCode = 404
    }
    $ctx.Response.Close()
}
