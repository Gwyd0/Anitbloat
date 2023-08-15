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
V="Version. 1.0.0 -$YELLOW For Huawei only.$NORMAL"


removebloatware() {
  currentApps=($(adb shell cmd package list packages))
  name=$1[@]
  a=("${!name}")
  for bloatware in "${a[@]}"
  do
    for app in ${currentApps[@]}
    do
      if [ "$app" == "$bloatware" ]; then
        echo -e $NAME Would you like to remove $YELLOW$app$RED Y/n$NORMAL 
        read -p '>: ' input
        case $input in
        [Yy]* ) 
            echo -e $NAME Removing package $YELLOW$app$NORMAL
            if adb shell pm uninstall --user 0 $app | grep -q 'Success'; 
            then
              echo -e $SUCCESS Removed package $YELLOW$app$NORMAL
            else 
              echo -e $ERROR Could not remove package $YELLOW$app$NORMAL
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
echo -e  $NAME Connecting to device using ADB$YELLOW Make sure you have ADB installed $NORMAL
while adb get-state devices | grep -q 'device' 
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
