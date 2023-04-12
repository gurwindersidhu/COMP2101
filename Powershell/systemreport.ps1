# Function to generate CPU report
function Get-CpuReport {
    $cpu = (Get-WmiObject -Class Win32_Processor).Name
    Write-Output "CPU: $cpu"
}

# Function to generate OS report
function Get-OsReport {
    $os = (Get-WmiObject -Class Win32_OperatingSystem).Caption
    $release = (Get-WmiObject -Class Win32_OperatingSystem).Version
    Write-Output "OS: $os $release"
}

# Function to generate RAM report
function Get-RamReport {
    $ram = (Get-WmiObject -Class Win32_OperatingSystem).TotalVisibleMemorySize
    $ram = $ram * 1MB
    $available = (Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory
    $available = $available * 1MB
    Write-Output "RAM: Total: $ram, Available: $available"
}

# Function to generate Video report
function Get-VideoReport {
    $video = "N/A"  # Replace with code to fetch video information
    Write-Output "Video: $video"
}

# Function to generate Disk report
function Get-DiskReport {
    $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    $diskReport = "Disk:"
    foreach ($disk in $disks) {
        $diskName = $disk.DeviceID
        $diskType = $disk.FileSystem
        $diskTotalSize = $disk.Size
        $diskFreeSpace = $disk.FreeSpace
        $diskReport += " `nName: $diskName, Type: $diskType, Total Size: $diskTotalSize, Free Space: $diskFreeSpace"
    }
    Write-Output $diskReport
}

# Function to generate Network report
function Get-NetworkReport {
    $network = "N/A"  # Replace with code to fetch network information
    Write-Output "Network: $network"
}

# Main function
function Generate-SystemReport {
    param (
        [Parameter(Mandatory=$false)]
        [string[]]
        $Sections = @()
    )

    $report = ""

    if (!$Sections) {
        $report += Get-CpuReport
        $report += Get-OsReport
        $report += Get-RamReport
        $report += Get-VideoReport
        $report += Get-DiskReport
        $report += Get-NetworkReport
    }
    else {
        foreach ($section in $Sections) {
            switch ($section) {
                "-System" {
                    $report += Get-CpuReport
                    $report += Get-OsReport
                    $report += Get-RamReport
                    $report += Get-VideoReport
                }
                "-Disks" {
                    $report += Get-DiskReport
                }
                "-Network" {
                    $report += Get-NetworkReport
                }
                default {
                    Write-Output "Invalid argument: $section"
                }
            }
        }
    }

    return $report
}

# Parse command line arguments
$sections = @($args)
$report = Generate-SystemReport -Sections $sections
Write-Output $report




