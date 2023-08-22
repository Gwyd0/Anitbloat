# Anitbloat
Much of the software on new phones is useless and closed source. Many simple apps such as clock are re-skinned and made closed source. Some apps are pre-installed on phones and are usually very annoying. To change this, I made this short shell script I could run when I get a new phone that would remove the bloatware and disable any unnecessary apps.

# Installation
working on this...

# Bloatware lists
The bloatware lists are from pre-existing online lists. Not every app has a description, either because I don't know what it is

Every app in these lists are either bloatware or just really peculiar (i.e. weird permissions).

# Something stopped working?
If disabling a package broke some part of your device, you can simply re-enable the app using this command:
```
adb shell pm enable $(PACKAGE_NAME)
```
Note: You need [adb](https://www.xda-developers.com/install-adb-windows-macos-linux/) and have *USB debugging enabled*

# Future Features
* More bloatware added to lists
* option for enabling disabled apps
* installing open source equivalent to bloatware using fdroid (maybe possible)
