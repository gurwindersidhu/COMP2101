function welcome {
# Lab 2 COMP2101 welcome script for profile
#
write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now." 
}

function get-cpuinfo {
get-ciminstance cim_processor | format-list "Manufacturer","Name","MaxClockSpeed","NumberOfCores","CurrentClockSpeed","Model"
}

function get-mydisks {
get-PhysicalDisk | Select-Object "Manufacturer","Model","SerialNumber","FirmwareRevision","Size" | format-table
}

