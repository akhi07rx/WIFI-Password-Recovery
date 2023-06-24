[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
![image](https://img.shields.io/github/v/tag/akhi07rx/WIFI-Password-Recovery)
![image](https://img.shields.io/github/languages/code-size/akhi07rx/WIFI-Password-Recovery)
![image](https://img.shields.io/badge/Google-Drive-brightgreen)

![maintenance-status](https://img.shields.io/badge/maintenance-actively--developed-brightgreen.svg)
![Safe](https://img.shields.io/badge/Stay-Safe-red?logo=data:image/svg%2bxml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTEwIDUxMCIgaGVpZ2h0PSI1MTIiIHZpZXdCb3g9IjAgMCA1MTAgNTEwIiB3aWR0aD0iNTEyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxnPjxnPjxwYXRoIGQ9Im0xNzQuNjEgMzAwYy0yMC41OCAwLTQwLjU2IDYuOTUtNTYuNjkgMTkuNzJsLTExMC4wOSA4NS43OTd2MTA0LjQ4M2g1My41MjlsNzYuNDcxLTY1aDEyNi44MnYtMTQ1eiIgZmlsbD0iI2ZmZGRjZSIvPjwvZz48cGF0aCBkPSJtNTAyLjE3IDI4NC43MmMwIDguOTUtMy42IDE3Ljg5LTEwLjc4IDI0LjQ2bC0xNDguNTYgMTM1LjgyaC03OC4xOHYtODVoNjguMThsMTE0LjM0LTEwMC4yMWMxMi44Mi0xMS4yMyAzMi4wNi0xMC45MiA0NC41LjczIDcgNi41NSAxMC41IDE1LjM4IDEwLjUgMjQuMnoiIGZpbGw9IiNmZmNjYmQiLz48cGF0aCBkPSJtMzMyLjgzIDM0OS42M3YxMC4zN2gtNjguMTh2LTYwaDE4LjU1YzI3LjQxIDAgNDkuNjMgMjIuMjIgNDkuNjMgNDkuNjN6IiBmaWxsPSIjZmZjY2JkIi8+PHBhdGggZD0ibTM5OS44IDc3LjN2OC4wMWMwIDIwLjY1LTguMDQgNDAuMDctMjIuNjQgNTQuNjdsLTExMi41MSAxMTIuNTF2LTIyNi42NmwzLjE4LTMuMTljMTQuNi0xNC42IDM0LjAyLTIyLjY0IDU0LjY3LTIyLjY0IDQyLjYyIDAgNzcuMyAzNC42OCA3Ny4zIDc3LjN6IiBmaWxsPSIjZDAwMDUwIi8+PHBhdGggZD0ibTI2NC42NSAyNS44M3YyMjYuNjZsLTExMi41MS0xMTIuNTFjLTE0LjYtMTQuNi0yMi42NC0zNC4wMi0yMi42NC01NC42N3YtOC4wMWMwLTQyLjYyIDM0LjY4LTc3LjMgNzcuMy03Ny4zIDIwLjY1IDAgNDAuMDYgOC4wNCA1NC42NiAyMi42NHoiIGZpbGw9IiNmZjRhNGEiLz48cGF0aCBkPSJtMjEyLjgzIDM2MC4xMnYzMGg1MS44MnYtMzB6IiBmaWxsPSIjZmZjY2JkIi8+PHBhdGggZD0ibTI2NC42NSAzNjAuMTJ2MzBoMzYuMTRsMzIuMDQtMzB6IiBmaWxsPSIjZmZiZGE5Ii8+PC9nPjwvc3ZnPg==)

# Recover Wi-Fi Password Using CMD

This guide will show you how to recover Wi-Fi passwords on a Windows PC using CMD.

## Reveal Target Wi-Fi Password

First, we must uncover the target Wi-Fi network to display the corresponding password. To accomplish this, launch Windows Command Prompt window and input the subsequent command to exhibit all Wi-Fi networks that your computer has previously connected to:

<br />

```
netsh wlan show profile
```

<br />
With the Wi-Fi network profiles visible, enter the following command, replacing `WIFI-NAME-PROFILE` (leave the quotes) with the profile for which you want to see the password:

<br />

```
netsh wlan show profile “WIFI-NAME-PROFILE” key=clear
```

<br />

To only show the Wi-Fi password for that target wireless network profile, enter the following command:

<br />

```
netsh wlan show profile “WIFI-NAME-PROFILE” key=clear | findstr “Key Content”
```

<br />

## Reveal All Wi-Fi Passwords

The subsequent command will display all saved Wi-Fi networks along with their corresponding Wi-Fi passwords:

<br />

```
for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @if "%j" NEQ "" (echo SSID: %j & netsh wlan show profiles %j key=clear | findstr "Key Content") & echo.
```

<br />

You can also save all of those Wi-Fi network details shown using the command above to a text document using the following command:

<br />

```
for /f “skip=9 tokens=1,2 delims=:” %i in (‘netsh wlan show profiles’) do @if “%j” NEQ “” (echo SSID: %j & netsh wlan show profiles %j key=clear | findstr “Key Content”) >> wifipass.txt
```

<br />

**Note:** Replace `wifipass.txt` at the end of the above command to customize the file name which will be generated in the Windows directory you currently reside.

<br />

## Create a Windows Batch File

You can create a Windows batch file to show all Wi-Fi network passwords or just download the one provided in this repository.

To create a batch file, open a text editor and paste in the following code:

```
@echo off
setlocal enabledelayedexpansion

for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile ^| findstr ":"') do (
    set "ssid=%%~a"
    call :getpwd "%%ssid:~1%%"
)

echo.
echo Press any key to exit...
pause > nul
exit

:getpwd
set "ssid=%*"

for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^| findstr /C:"Key Content"') do (
    echo SSID: %ssid% PASS: %%i
)

```

Save the file with a `.bat` extension, such as `show_wifi_pass.bat`. To run the batch file, simply double-click on it.

This batch file will run the command to show all stored Wi-Fi networks and their associated Wi-Fi passwords. It will also pause at the end so you can view the results.

<br />

## Troubleshooting

If you encounter any issues while following the steps in this guide, here are some troubleshooting tips that may help:

- Make sure you are running the commands in a Windows Command Prompt window with administrative privileges. To do this, right-click on the Command Prompt icon and select "Run as administrator".
- If copying and pasting the commands into the Command Prompt window does not work, try typing them in manually. The quotes (“) and (‘) may be picked up differently when copying and pasting.
- If you are having trouble creating or running a batch file, make sure the file has a `.bat` extension and that you have permission to run it.

If you continue to have issues, please feel free to open an issue in this repository or seek help from online forums or communities.

## Additional Resources

If you would like to learn more about managing wireless networks on Windows, here are some additional resources that may be helpful:

- [Microsoft's documentation on the `netsh` command](https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh)
- [Windows Command Line reference](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)
- [Wireless networking on Windows](https://support.microsoft.com/en-us/windows/connect-to-a-wi-fi-network-in-windows-10-1a3c1c0e-7b55-80a9-5a7f-f35d0d1f3d2c)

These resources provide more detailed information about the `netsh` command and other tools for managing wireless networks on Windows.

## Contributing

Contributions to this repository are welcome. If you find any issues or have suggestions for improvements, please submit a pull request or open an issue.

We appreciate any contributions, big or small. Thank you for helping to improve this guide!

## License

This project is licensed under the MIT License.
<br />
