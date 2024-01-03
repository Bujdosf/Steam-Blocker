@echo off

if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)

set powershellScript="$SteamExePath=Get-ItemPropertyValue 'HKLM:HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Valve\Steam' -Name InstallPath; $SteamExePath=$SteamExePath + '\steam.exe'; $ruleName='Steam Family Share Net Blocker'; $existingRule=Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue; if ($null -eq $existingRule) { ; New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $SteamExePath -Action Block; } else {; $currentAction = $existingRule.Enabled; if ($currentAction -eq 'True') { ; Disable-NetFirewallRule -DisplayName $ruleName; } elseif ($currentAction -eq 'False') { ; Enable-NetFirewallRule -DisplayName %$ruleName; }; };"

powershell -command %powershellScript%

::pause
