#!/bin/bash
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
NORMAL="\033[0;39m"

NAME="$CYAN[ANTIBLOAT]$NORMAL"
ERROR="$RED[ERROR]$NORMAL"
SUCCESS="$GREEN[SUCCESS]$NORMAL"
V="Version. 1.0.3 -$YELLOW Shell$NORMAL"

EDR="1"

removebloatware() {
  bloatware=$(jq -r '.bloatware.'$1'[] | .package' bloatware.json)
  apps=$(adb shell pm list packages)
  
  if [ $EDR == "0" ]; then
    STRING="Enabl"
    COMMAND=$(eval "adb shell pm enable --user 0 $app | grep -q 'Success'")
  elif [ $EDR == "1" ]; then
    STRING="Disabl"
    COMMAND=$(eval "adb shell pm disable-user --user 0 $app | grep -q 'Success'")
  else
    STRING="Remov"
    COMMAND=$(eval "adb shell pm uninstall --user 0 $app | grep -q 'Success'")
  fi
  
  printf "\n$CYAN-------------$NORMAL\n"
  
  for bloat in $bloatware:
  do
    for app in ${apps[@]//package:}
    do
      if [ "$app" == "${bloat//:}" ]; then
        echo -e $NAME Would you like to $STRING\e $YELLOW$app$RED Y/n$NORMAL 
	  read -p '>: ' input
	  case $input in
	  [Yy]* ) 
	      echo -e $NAME $STRING\ing package $YELLOW$app$NORMAL
	      if $COMMAND; 
	      then
	        echo -e $SUCCESS $STRING\ed package $YELLOW$app$NORMAL
	      else 
	        echo -e $ERROR Could not $STRING\e package $YELLOW$app$NORMAL
	      fi 
	      printf "\n$CYAN-------------$NORMAL\n"
	  ;;
	  [Nn]* ) 
	      echo -e $NAME You answered No, Skipping
	      printf "\n$CYAN-------------$NORMAL\n"
	  ;;
	  * ) echo -e $ERROR Invalid, use y/n Skipping;;
         esac
      fi
    done
  done
}

echo -e $NAME $V
echo -e $NAME By$CYAN Gwyd$GREEN Github:$CYAN https://github.com/Gwyd0/Anitbloat$NORMAL
echo -e  $NAME Connecting to device using ADB$GREEN Make sure you have ADB installed and a device connected via USB with USB debugging enabled.$NORMAL
printf "\n$CYAN-------------$NORMAL\n"
echo -e $NAME Are you Enabling/Disabling/Removing apps?$RED 0/1/2$NORMAL 
	  read -p '>: ' input
	  if [ $input == "0" ] || [ $input == "1" ] || [ $input == "2" ]; then
	    echo -e $NAME You picked$GREEN $input
	    EDR="$input"
	  else
	    echo -e $ERROR Please pick 0/1/2 Going with default,$CYAN Disabling $NORMAL
	  
	  fi
printf "\n$CYAN-------------$NORMAL\n"
removebloatware "huawei"
removebloatware "google"
removebloatware "amazon"
echo -e $NAME Done! Removed/Disabled/Enabled all bloatware.
echo -e $NAME Exiting
exit
