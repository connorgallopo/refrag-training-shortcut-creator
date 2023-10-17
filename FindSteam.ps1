# Define the target process name (steam.exe)
$processName = "Steam"

# Get a list of all running processes with the specified name
$processes = Get-Process | Where-Object { $_.ProcessName -eq $processName }

# Check if any instances of the process are running
if ($processes.Count -gt 0) {
    # Steam is running, so get the executable path of the first instance
    $steamPath = $processes[0].Path

    # Define the additional command-line arguments
    $additionalArgs = "-applaunch 730 -insecure -dev +sv_cheats 1"

    # Define the path to the user's desktop
    $desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

    # Define the shortcut file path
    $shortcutPath = Join-Path -Path $desktopPath -ChildPath "Refrag Training.lnk"

    # Define the path to the custom icon in the same folder as the script
    $scriptDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    $iconPath = Join-Path -Path $scriptDirectory -ChildPath "refrag_icon.ico"

    # Create a shortcut using the Windows Script Host COM object
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "$steamPath"
    $shortcut.Arguments = $additionalArgs
    $shortcut.IconLocation = "$iconPath,0"  # Set the icon location
    $shortcut.Save()

    Write-Host "Shortcut created on the desktop: Refrag Training"
} else {
    # Steam is not running, so no shortcut will be created
    Write-Host "Steam is not currently running. No shortcut created."
}