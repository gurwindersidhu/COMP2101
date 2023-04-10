"############## System Hardware Description ###############"
gwmi win32_computersystem 

"########### Operating system name and version number ###########"
""
gwmi win32_operatingsystem |    
    select-object @{n='Opearting System Name'; e={$_.caption}}, Version

"########### Processor description with speed, number of core, and sizes of L1, L2 and L3 cache ##########"
""
gwmi win32_processor |    
    select-object @{n='Processor Type'; e={$_.caption}}, Name,     
        @{n="MaxClockSpeed in GHz"; e={$_.MaxClockSpeed/1000}}, NumberOfCores,       
        @{n="L1 Cache Size"; e={switch($_.L1CacheSize){$null{$stat="NA"} 0{$stat="0"}}; $stat}},      
        @{n="L2 Cache Size"; e={switch($_.L2CacheSize){$null{$stat="NA"} 0{$stat="0"}}; $stat}},
        @{n="L3 Cache Size"; e={switch($_.L3CacheSize){$null{$stat="NA"} 0{$stat="0"}}; $stat}}

"########### Summary of RAM installed with the vendor, description, size, bank and slot for each DIMM ###########"
$storagecapacity = 0
gwmi -class win32_physicalmemory | 
    foreach {
        new-object -TypeName psobject -Property @{  
        Vendor =$_.manufacture
        Description = $_.description       
        #"Speed in MHz" =$_.speed                                                          
        "Size in GB" = $_.capacity/1gb
        Bank = $_.banklabel                              
        Slot = $_.devicelocator                  
    }                 
$storagecapacity += $_.capacity/1gb} |
    format-table -auto @{n='Vendor';e={ if ($_.manufacturer) {$_.manufacturer} else {"VMWare"} } }, description, "Size in GB", Bank, Slot
"Total RAM is ${storagecapacity} GB"

"########## Physical Disk Drives with vendor, model, size and space usage ##########"
$disks = Get-WmiObject -class win32_logicaldisk | where-object size -gt 0 
$diskConfig = foreach ($disk in $disks) {
    $part = $disk.GetRelated('win32_diskpartition')
    $drive = $part.GetRelated('win32_diskdrive')
    if ($drive.size -ne 0) {  # Add a check for non-zero size
        new-object -TypeName psobject -Property @{
            Disk = $drive.DeviceID
            Vendor = $drive.manufacturer
            Model = $drive.model
            "Filesystem Drive" = $part.name
            "Size(GB)" = $drive.size/1gb -as [int]
            "Free space(GB)" = $disk.freespace/1gb -as [int]
            "% Free" = 100*$disk.freespace/$drive.size -as [int]
        }
    } else {
        Write-Output "Error: Drive size is zero"
    }
}

$diskConfig | Format-Table -AutoSize Disk, Vendor, Model,"Size(GB)","Free space(GB)","% Free"

"########### Video card vendor, description, and current screen resolution ###########"
gwmi win32_videocontroller | 
    format-list @{n="Video Card Vendor"; e={$_.AdapterCompatibility}}, Description,
    @{n="Current Screen Resolution"; e={$_.VideoModeDescription}}