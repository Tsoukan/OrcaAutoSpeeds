# OrcaAutoSpeeds
Creates a Orca slicer process json file with print speeds scaled a base speed and values in a CSV file.
## How to use it
You can run the script anytime, if OrcaSlicer is running you will need to restart it to see your new profile.  The script appends "@{speed}mm to the end of the selected profile name.
1. Copy the csv file to a location, the script defaults to the storage location for OrcaSlicer storage profiles of `%userprofile%\AppData\Roaming\OrcaSlicer\user\default\process`.
2. Copy the script to any location you want.
3. Make sure you have saved a least one user preset process configuration.
4. Right click on the script and select run with powershell.
5. Enter the desired base speed
6. Select a save process preset to use as a template
7. Confirm your selection
8. Restart OrcaSlicer if it was running.
9. Select your new process preset and confirm the speed settings.
