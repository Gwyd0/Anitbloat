# Anitbloat
Much of the software on new phones is useless and closed source. Many simple apps such as **clock** are re-skinned and made closed source. Some apps are pre-installed on phones and are usually very annoying. To change this, I made this small shell/python script I could run when I get a new phone that would remove the bloatware or disable any unnecessary apps.

It's very simple, the shell script reads from [bloatware.json](bloatware.json) and if the user agrees either disables or removes the bloatware. In the future, I want this script to also install software (with the user's permission) from F-droid.

# Installation
Clone the repo and run the shell script using
```
bash start.sh
```
or for the python script use
```
python3 start.py
```
## Requirements
You need two requirements for these scripts:
* [jq](https://jqlang.github.io/jq/download/) - for .json files
* [adb](https://developer.android.com/tools/adb) - for removing apps
  
To install these requirements, run this command on your device:

### Ubuntu
```
sudo apt-get install jq adb
```
### Arch
```
sudo pacman -S jq adb
```
### Windows
I'm not sure how you install packages on Windows, as I don't use it any more, so I will link the two requirements webpages
* [jq](https://jqlang.github.io/jq/download/)
* [adb](https://developer.android.com/tools/adb)



# Bloatware lists
The bloatware lists are from pre-existing online lists. Not every app has a description, usually because I don't know what it is.

Every app in these lists are either bloatware or just really peculiar (i.e. weird permissions).

# An app stopped working?
If disabling a package broke some part of your device, you can simply re-enable the app using this command:
```
adb shell pm enable $(PACKAGE_NAME)
```
Note: You need [adb](https://www.xda-developers.com/install-adb-windows-macos-linux/) and have *USB debugging enabled*

# Future Features
* More bloatware added to lists
* option for enabling disabled apps (already done on python)
* installing open source equivalent to bloatware using fdroid (maybe possible)
* add arguments for the command line
