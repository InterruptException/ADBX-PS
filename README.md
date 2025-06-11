# ADBX-PS
A PowerShell module designed to simplify adb command operations across multiple connected devices.

# Setup
1. Place the Adbx.psm1 file in the following directory:
    C:\Users\<Your User Name>\Documents\PowerShell\Modules\Adbx\
2. Place the Microsoft.PowerShell_profile.ps1 file in the following directory:
    C:\Users\<Your User Name>\Documents\PowerShell\
   ​​If Microsoft.PowerShell_profile.ps1 already exists in this directory, manually append the contents.​​
3. Restart PowerShell.

# Usage
1. ```$ adbx -devices```
3. ```$ adbx -bind <SERIAL>```
4. ```$ adbx -unbind```
5. ```$ adbx <other adb command>```

If you run adbx -bind <SERIAL>, then you can run other adb subcommands by adbx, you don't need to use -s <SERIAL> parameters to specify the target device.

# Screenshot
