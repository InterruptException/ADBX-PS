# Adbx.psm1
New-Variable -Name boundDevice -Value $null -Scope Global -Force

function adbx {
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'ListDevices', Mandatory)]
        [switch]$devices,

        [Parameter(ParameterSetName = 'BindDevice', Mandatory)]
        [string]$bind,

        [Parameter(ParameterSetName = 'UnbindDevice', Mandatory)]
        [switch]$unbind,

        [Parameter(ValueFromRemainingArguments = $true, ParameterSetName = 'None')]
        [object[]]$Args
    )

    switch ($PSCmdlet.ParameterSetName) {
        'ListDevices' {
            Get-AdbDevicesList
        }
        'BindDevice' {
            Set-AdbDevice -DeviceId $bind
        }
        'UnbindDevice' {
            Remove-AdbDevice -DeviceId $null
        }
        'None' {
            if ($boundDevice -ne $null) {
                Write-Output "Using bound device: $boundDevice"
                & adb -s $boundDevice @Args
            } else {
                & adb @Args
            }
            
        }
    }
}

function Remove-AdbDevice {
    $dev = $global:boundDevice
    $global:boundDevice = $null
    Write-Output "Unbound device : $dev"
}


function Set-AdbDevice {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DeviceId
    )

    $global:boundDevice = $DeviceId
    Write-Output "Bind device : $DeviceId"
}

function Get-AdbDevice() {
    return $global:boundDevice
}

function Get-AdbDeviceStatus {
    if ($null -eq $global:boundDevice) {
        return "No Device (offline)"
    } else {
        $devices = Get-AdbDevicesList
        $deviceStatus = $devices | Where-Object { $_ -match "^$($global:boundDevice)\s+(\S+)" }
        if ($deviceStatus) {
            $status = $deviceStatus -replace "^$($global:boundDevice)\s+", ""
            return "$($global:boundDevice) ($status)"
        } else {
            return "$($global:boundDevice) (offline)"
        }
    }    
}

function Get-AdbDevicesList {
    $devices = & adb devices | Where-Object { $_ -ne $null -and $_ -ne '' -and $_ -ne 'List of devices attached' }
    return $devices
}

Export-ModuleMember -Function adbx, Set-AdbDevice, Get-AdbDevice, Get-AdbDevicesList, Get-AdbDeviceStatus