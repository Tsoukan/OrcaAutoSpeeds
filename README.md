This is a work in progress.  It should not do anything catostrophic but ***Use at your own risk***.

![OrcaSpoon (Custom)](https://github.com/Tsoukan/Speed-Output-for-OrcaSlicer-for-Noobs/assets/55215587/c62d8c85-24c4-4bac-b78e-ccefc819b4dc)

# Speed Output for OrcaSlicer for Noobs
Being a Noob to 3d printing and I found it frustrating to have to edit all the speed setting in Orcaslicer if I wanted to speed up or slow down a profile either for quality reasons, or because the filament I was printing needed it.  Also not truely understanding the relationships between each of these settings I was an exercise in frustration to figure out reasonable starting values.  
To solve my frustrations and **spoon** feed some starting speeds into a profile I wrote this script.  
It simply takes a previously saved process profile, updates or adds the speeds and saves a process profile with the same name and the base speed appended.  

## How to use it
You can run the script anytime, if OrcaSlicer is running you will need to restart it to see your new profile.  The script appends "@{speed}mm to the end of the selected profile name.
1. Copy the csv file to a location, the script defaults to the storage location for OrcaSlicer storage profiles of `%userprofile%\AppData\Roaming\OrcaSlicer\user\default\process`.
2. Copy the script to any location you want.
3. Make sure you have saved a least one user preset process configuration from OrcaSlicer.
4. Run the powershell script.  Right clicking on the script and selecting "run with powershell" seems to work for me.
5. Enter the desired base speed when prompted.
6. Select a saved process preset to use as a template by entering the corresponding number.
7. Confirm your selection.
8. Restart OrcaSlicer if it was running.
9. Select your new process preset and confirm the speed settings.

Know issues:
1. It does not check to see if it will overwrite an existing profile!!!

## The multipliers
The multipliers for the speed parameters are in the CSV file and are percentages of the base speed entered when you run the script.  They currently mimic more or less the way the speeds are scaled in Cura.  
The parameter names match those used in Orca slicer - hover over a value and it will show at show the name in the tooltip.
