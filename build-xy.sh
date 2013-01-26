#!/bin/bash

# Based on Bajee's buildscripts (It made life easier. :) )

# get current path
reldir=`dirname $0`
cd $reldir
DIR=`pwd`

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

DEVICE="$1"
SYNC="$2"
THREADS="$3"
CLEAN="$4"


# Inital Startup
res1=$(date +%s.%N)

echo -e "${cya}Building ${bldcya}XYE AOSP - v018 ${txtrst}";

# Sync the latest Xylon Sources
echo -e ""
if [ "$SYNC" == "sync" ]
then
   echo -e "${bldblu}Syncing latest Xylon sources ${txtrst}"
   repo sync -j"$THREADS"
   echo -e ""
fi

# Setup Environment (Cleaning)
if [ "$CLEAN" == "clean" ]
then
   echo -e "${bldblu}Cleaning up out folder ${txtrst}"
   make clobber;
else
  echo -e "${bldblu}Skipping out folder cleanup ${txtrst}"
fi


# Setup Environment
echo -e "${bldblu}Setting up build environment ${txtrst}"
. build/envsetup.sh

# Lunch Device
echo -e ""
echo -e "${bldblu}Lunching your device ${txtrst}"
lunch "xylon_$DEVICE-userdebug";

echo -e ""
echo -e "${bldblu}Starting to build the epic ROM ${txtrst}"

# Start Building like a bau5
brunch "xylon_$DEVICE-userdebug" -j"$THREADS";
echo -e ""

# Once building completed, bring in the Elapsed Time
res2=$(date +%s.%N)
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
