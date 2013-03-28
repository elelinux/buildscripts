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


# Initial Startup
res1=$(date +%s.%N)

echo -e "${cya}This machine is gonna build - ${bldcya}XYE AOSP${txtrst}";

# Unset CDPATH variable if set
if [ "$CDPATH" != "" ]
then
  unset CDPATH
fi

# Sync the latest Xylon Sources
echo -e ""
if [ "$SYNC" == "sync" ]
then
   if [ "$(which repo)" == "" ]
   then
      if [ -f ~/bin/repo ]
        then
        echo "Y U NO install repo?!"
        mkdir ~/bin
        export PATH=~/bin:$PATH
        curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > ~/bin/repo
        chmod a+x ~/bin/repo
      fi
   fi
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

if [ "$DEVICE" == "all" ]
then
   echo -e ""
   echo -e "${bldblu}Starting to build the epic ROM ${txtrst}"
   echo -e "${bldblu}crespo ${txtrst}"
   lunch "xylon_crespo-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}d2att ${txtrst}"
   lunch "xylon_d2att-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}grouper ${txtrst}"
   lunch "xylon_grouper-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}i9100g ${txtrst}"
   lunch "xylon_i9100g-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}i9300 ${txtrst}"
   lunch "xylon_i9300-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}maguro ${txtrst}"
   lunch "xylon_maguro-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}mako ${txtrst}"
   lunch "xylon_mako-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}tilapia ${txtrst}"
   lunch "xylon_tilapia-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}toro ${txtrst}"
   lunch "xylon_toro-userdebug"
   make -j"$THREADS" otapackage
   echo -e "${bldblu}toroplus ${txtrst}"
   lunch "xylon_toroplus-userdebug"
   make -j"$THREADS" otapackage
else
   # Lunch Device
   echo -e ""
   echo -e "${bldblu}Lunching your device ${txtrst}"
   lunch "xylon_$DEVICE-userdebug";

   echo -e ""
   echo -e "${bldblu}Starting to build the epic ROM ${txtrst}"

   # Start Building like a bau5
   brunch "xylon_$DEVICE-userdebug" -j"$THREADS";
   echo -e ""
fi

# Once building completed, bring in the Elapsed Time
res2=$(date +%s.%N)
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
