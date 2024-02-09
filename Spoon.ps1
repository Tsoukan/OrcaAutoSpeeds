<#
    Script Name: SPOON: Speed Output for OrcaSlicer Noob
    Author: Tsoukan
    Date: 2024-02-08
    Description: This script creates an new process profile for OrcaSlicer based on a previously
                 saved user preset, a base speed provide by the user and a CSV file of speed multipliers.
     
    License:This program is free software: you can redistribute it and/or modify
            it under the terms of the GNU General Public License as published by
            the Free Software Foundation, either version 3 of the License, or
            (at your option) any later version.

            This program is distributed in the hope that it will be useful,
            but WITHOUT ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
            GNU General Public License for more details.

            You should have received a copy of the GNU General Public License
            along with this program.  If not, see <https://www.gnu.org/licenses/>.
#>

# Get the base print speed
$number = Read-Host "Enter the desired base print speed"

# Validate input (ensure it's a valid integer)
if ($number -match '^\d+$') {
    $number = [int]$number
    Write-Host "You entered: $number"
    # Now you can use the $number for further processing
}
else {
    Write-Host "Invalid input. Please enter a valid number."
}

#Get the speed multipliers from the csv file
$csvFilePath = "$env:USERPROFILE\AppData\Roaming\OrcaSlicer\user\default\process\auto_speed_multipliers.csv"  # Replace with the actual path to your CSV file

# Specify the directory containing the JSON files
$directoryPath = "$env:USERPROFILE\AppData\Roaming\OrcaSlicer\user\default\process"

# Get a list of all JSON file names in the directory
$jsonFiles = Get-ChildItem -Path $directoryPath -Filter "*.json"

# Check if the directory contains any JSON files
if ($jsonFiles.Count -eq 0) {
    Write-Host "Warning: The directory does not contain any configuration files.`n"
    Write-Host "Please save a least one process as a user preset."
    return
}

# Display the list of available JSON files
Write-Host "Available JSON files:"
for ($i = 0; $i -lt $jsonFiles.Count; $i++) {
    Write-Host "$($i + 1). $($jsonFiles[$i].Name)"
}

# Ask the user to choose a file
$selectedIndex = Read-Host "Enter the number corresponding to the desired JSON file"

# Validate input (ensure it's a valid integer)
if ($selectedIndex -match '^\d+$' -and $selectedIndex -ge 1 -and $selectedIndex -le $jsonFiles.Count) {
    # Get the selected JSON file name
    $selectedJsonFile = $jsonFiles[$selectedIndex - 1].FullName
    Write-Host "You selected: $($jsonFiles[$selectedIndex - 1].Name)"

    # Ask the user if they want to continue with the selected file
    $continueWithFile = Read-Host "Do you want to continue with this file? (yes/no)"
    if ($continueWithFile.ToLower() -eq "y" -or $continueWithFile.ToLower() -eq "yes") {
        # Now you can use the $selectedJsonFile for further processing
        Write-Host "Continuing with: $($jsonFiles[$selectedIndex - 1].Name)"
    }
    else {
        Write-Host "Operation cancelled by the user."
    }
}

# Read the CSV file
$csvData = Import-Csv -Path $csvFilePath

# Read the JSON file
$jsonData = Get-Content -Raw -Path $selectedJsonFile | ConvertFrom-Json

# Iterate through each row in the CSV
foreach ($row in $csvData) {
    # Match parameters from CSV to JSON
    $parameterName = $row.parameter  # Replace with the actual column name in your CSV
    $multiplier = $row.multiplier  # Replace with the actual column name in your CSV

    # Skip parameters that start with a #
    if (-not $parameterName.StartsWith("#")) {
        # Update the corresponding value in the JSON file
        if ($jsonData.$parameterName) {
            $jsonData.$parameterName = "$($number * $multiplier / 100)"
        }
        else {
            # If parameter is missing in JSON and parameterName is not empty, add it with default value (e.g., 0)
            if (-not [string]::IsNullOrWhiteSpace($parameterName)) {
                $jsonData | Add-Member -MemberType NoteProperty -Name $parameterName -Value "$($number * $multiplier / 100)"
            }
        }
    }
}

# Create a new filename with "speed" and the number appended
$originalFileName = $jsonFiles[$selectedIndex - 1].BaseName
$newFileName = "${originalFileName} @${number}mm.json"
$newJsonFilePath = [System.IO.Path]::Combine($directoryPath, $newFileName)

# Update the name parameter in the JSON data
$jsonData.name = [System.IO.Path]::GetFileNameWithoutExtension($newFileName)
$jsonData.print_settings_id = [System.IO.Path]::GetFileNameWithoutExtension($newFileName)

# Save the updated JSON data to the new file
$jsonData | ConvertTo-Json | Set-Content -Path $newJsonFilePath

Write-Host "Updated JSON data saved to $newJsonFilePath!"
