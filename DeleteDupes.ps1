<#
.SYNOPSIS
This script removes duplicate files from a specified directory by keeping only the oldest file in each group of duplicates.

.DESCRIPTION
The script recursively scans a directory and its subdirectories to find all files. It then groups the files based on their hash value using the MD5 algorithm. If a group contains more than one file, it means that there are duplicates. The script sorts the files in each group by their creation time and keeps only the oldest file. The other duplicate files in each group are deleted.

.PARAMETER dir
The directory path where the script will search for duplicate files.

.EXAMPLE
Remove-DuplicateFiles -dir 'G:\Personal Media'
This example removes duplicate files from the 'G:\Personal Media' directory.

.NOTES
- This script requires PowerShell version 3.0 or later.
- The script uses the Get-FileHash cmdlet to calculate the hash value of each file.
- The script uses the Get-ChildItem cmdlet to retrieve all files in the specified directory.
- The script uses the Group-Object cmdlet to group the files based on their hash value.
- The script uses the Sort-Object cmdlet to sort the files in each group by their creation time.
- The script uses the Select-Object cmdlet to select the oldest file in each group.
- The script uses the Remove-Item cmdlet to delete the duplicate files.
#>

$dir = 'G:\Personal Media'

# Get all files in the directory recursively
$files = Get-ChildItem -Path $dir -Recurse -File

# Group the files by their hash
$groups = $files | Group-Object -Property { Get-FileHash $_.FullName -Algorithm MD5 }

# Iterate over the groups
foreach ($group in $groups) {
    # If the group contains more than one file, it means that there are duplicates
    if ($group.Count -gt 1) {
        # Sort the files in the group by their creation time and keep only the oldest file
        $oldestFile = $group.Group | Sort-Object -Property CreationTime | Select-Object -First 1

        # Delete the other files in the group
        $group.Group | Where-Object { $_.FullName -ne $oldestFile.FullName } | Remove-Item -Force
    }
}