## ADB Backup Tool
This tool uses ADB Pull and Push to backup your files, with dates still intact. That means that you can switch roms or phones without your photos and files getting all messed up and apps no longer think that all your photos where taken 'Today'.
## Usage
This is basically just ADB, so you have to ensure that you can use ADB. Aka a PC, a USB Cable and the ability to enable USB Debugging on your device.

Once you have these, download the .zip file into somewhere with enough space, as the script will just back up your files into a folder inside of it. I may add the ability to choose another directory if there's enough requests for it.

Double-click the Backup.bat file (no need for admin) and just choose what you want to backup via entering numbers and pressing enter. 

Example:
 1. All
 2. Pictures
 3. DCIM
 4. Download
 5. Movies
 6. Documents
 7. Music

If you want to backup Pictures and  DCIM, enter '2 3' (no quotation marks) and press enter for the script to back up Pictures and DCIM. If you only want Music for example, enter 7 then press enter.

After it's done, your backups will be under 'Backups' and in the folder with the current date. If you want to restore your files, double-click on the Restore.bat file inside of the folder with the current date.
