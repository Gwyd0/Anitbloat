#!/bin/bash
BLACK="\033[30m"
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
V="Version. 1.0.1 -$YELLOW For Huawei only.$NORMAL"
DEVICE=""

removebloatware() {
  echo -e $NAME IF anything breaks or stop working you can re-enable the packages.\ Connecting to device...
  currentApps=($(adb -d shell cmd package list packages))
  name=$1[@]
  a=("${!name}")
  for bloatware in "${a[@]}"
  do
    for app in ${currentApps[@]//package:}
    do
      if [ "$app" == "$bloatware" ]; then
        echo -e $NAME Would you like to Disable $YELLOW$app$RED Y/n$NORMAL 
        read -p '>: ' input
        case $input in
        [Yy]* ) 
            echo -e $NAME Disabling package $YELLOW$app$NORMAL
            if adb -d shell pm disable-user --user 0 $app | grep -q 'Success'; 
            then
              echo -e $SUCCESS Disabled package $YELLOW$app$NORMAL
            else 
              echo -e $ERROR Could not Disable package $YELLOW$app$NORMAL
            fi 
            printf "\n$CYAN-------------$NORMAL\n"
        ;;
        [Nn]* ) 
            echo -e $NAME You answered no, Skipping
            printf "\n$CYAN-------------$NORMAL\n"
            break
        ;;
        * ) echo -e $ERROR Invalid, use y/n Skipping;;
    esac
      fi
    done
  done
}



echo -e $NAME $V
echo -e $NAME By$CYAN Gwyd$GREEN Github:$PINK https://github.com/Gwyd0/Anitbloat$NORMAL
echo -e  $NAME Connecting to device using ADB$YELLOW Make sure you have ADB installed and a device connected via USB with USB debugging enabled.$NORMAL

while adb -d get-state devices | grep -q 'device' 
do

  echo -e $NAME Locating$YELLOW Huawei$NORMAL bloatware 
  printf "\n$CYAN-------------$NORMAL\n"
  mapfile -t huewaiBloatware < huewaiB.txt
  removebloatware huewaiBloatware
  
  echo -e $NAME Locating$YELLOW Google$NORMAL bloatware 
  printf "\n$CYAN-------------$NORMAL\n"
  mapfile -t googleBloatware < googleB.txt
  removebloatware googleBloatware
  exit

done
