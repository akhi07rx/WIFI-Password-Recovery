(netsh wlan show profiles) | Select-String "All User Profile" | ForEach-Object {
    $ssid = $_.Line.Split(':')[1].Trim()
    $profile = (netsh wlan show profile name=$ssid key=clear)
    $passwordLine = $profile | Select-String "Key Content"
    if ($passwordLine -ne $null) {
        $password = $passwordLine.Line.Split(':')[1].Trim()
        "SSID: $ssid`nPassword: $password`n"
    }
} | Out-File -FilePath "$env:USERPROFILE\Desktop\wifipass.txt"
