# Windows Sandbox Script

I'm planning on putting together a script to configure Windows Sandbox to my
needs in this repository.

## Attempt 1

`script.ps1` & `run.bat`

For starters, some reading:

- https://www.thomasmaurer.ch/2019/05/how-to-configure-windows-sandbox/
- https://winaero.com/blog/enable-windows-10-sandbox-powershell-dism/
- https://winaero.com/blog/enable-windows-sandbox-in-windows-10-home/

Unfortunately I ran into the
> Version v4.0.30319 of the .NET Framework is not installed and it is required to run version 3 of Windows PowerShell.
error when trying to run PowerShell in Windows Sandbox.

Someone in the comments of the first link above suggests uninstalling KB4495620
on the host to make PowerShell work in the Sandbox.

I do see it in `get-hotfix`.

It is a fix for the DOS issues in .NET framework uncovered recently:
https://support.microsoft.com/en-us/help/4495620/may-14-2019-kb4495620-cumulative-update-for-net-framework

I am not going to uninstall it from the host so I need to find another way to
make PowerShell work or to use a C# script (using `dotnet-script`) instead.

## Attempt 2

`net.bat`

https://dotnet.microsoft.com/download/thank-you/dotnet-sdk-2.2.300-windows-x64-installer

https://download.visualstudio.microsoft.com/download/pr/0d4f13a2-dd2f-4259-852e-58763d9ef303/cacb9821c492242072b0927dcb5808f5/dotnet-sdk-2.2.300-win-x64.exe

`bitsadmin.exe /transfer "Download .NET Core" http://….exe C:\….exe`

Looks like the installer cannot be run from the command prompt, it is not an MSI
so `msiexec /i` won't work and I have not found a way to install the .NET Core
SDK without PowerShell or Chocolatey (which requires PowerShell).

https://gunnarpeipman.com/net/dotnet-core-windows-sandbox/

## Exploring WSB Starter File

https://techcommunity.microsoft.com/t5/Windows-Kernel-Internals/Windows-Sandbox-Config-Files/ba-p/354902

The user account in the Sandbox is `WDAGUtilityAccount`.

- `VGpu`
  - `Disable` means to use WARP - DirectX software renderer
  - `Default` means to use vGPU - virtualized hardware renderer
- `Networking`: `Disable` & `Default` (virtual switch on the host connected to using virtual NIC on the guest)
- `MappedFolders`: mapped to `C:\Users\WDAGUtilityAccount\Desktop`
  - `MappedFolder`
    - `HostFolder`: host path
    - `ReadOnly`: `true` or `false`
- `LogonCommand`:
  - `Command`: a simple script inline or a path to a script file or an executable

Examples:

- `open-host-downloads-in-guest.wsb`
- `install-vs-code.wsb`
  - Close Explorer opened after VS Code installer - installer switch or automation command
  - Pin VS Code to taskbar
  - Close the command prompt after the installer has completed

## To-Do

### Figure out how to auto-hide taskbar

### Figure out how to pin to the taskbar

https://stackoverflow.com/a/46593836/2715716 & https://stackoverflow.com/a/9074483/2715716

### Figure out how to show file name extensions

### Figure out how to install SQLite
