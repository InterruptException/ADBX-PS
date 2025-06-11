Import-Module Adbx


function Prompt {
    $adbdev = Get-AdbDeviceStatus
    if ($adbdev -eq $null) {
        $adbInfo = "PS "
    } else {
        $adbInfo = "[$($adbdev)] "
    }
    $loc = "$(Get-Location) > "
    $prompt = "$($adbInfo)" + (Get-Location) + "> "
    # 如果$adbdev 包含字符串 "(offline)"，则以黄色显示，否则以绿色显示
    if ($adbdev -like "*offline*") {
        Write-Host -NoNewline $adbInfo -ForegroundColor DarkYellow
    } else {
        Write-Host -NoNewline $adbInfo -ForegroundColor Green
    }
    Write-Host -NoNewline $loc -ForegroundColor Cyan
    return " "
}


