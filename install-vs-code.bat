REM Download the VS Code installer
curl -L "https://update.code.visualstudio.com/latest/win32-x64-user/stable" --output C:\users\WDAGUtilityAccount\Desktop\vscode.exe
 
REM Install VS Code
REM https://github.com/Microsoft/vscode/blob/master/build/win32/code.iss#L71-L92
REM `!` negates a task
REM Use `/verysilent` to even disable the installer UI
C:\users\WDAGUtilityAccount\Desktop\vscode.exe /silent /suppressmsgboxes /mergetasks=!runcode

REM Delete the installer
del C:\users\WDAGUtilityAccount\Desktop\vscode.exe

exit

REM `pause`
REM `shutdown.exe /s /t 00`
