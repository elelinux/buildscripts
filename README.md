XYE Experimental
===============

Getting started
---------------
First you must initialize a repository with XYAOSP sources:

    repo init -u git://github.com/XYAOSP/platform_manifest.git -b jb4.2

then

    repo sync

*This might take a few hours depending on your internet connection.


Building the ROM
------------------------

To build XYAOSP you must cd to the working directory.

Now you can run the build script:

    ./build-xy.sh -device- -sync- -thread-


* device: Choose between the following supported devices: 
   - Nexus S (crespo)
   - AT&T Galaxy S3 (d2att)
   - Wifi Nexus 7 (grouper)
   - Galaxy S2 Alt (i9100g)
   - Int. Galaxy S3 (i9300)
   - Galaxy Nexus (maguro)
   - Nexus 4 (mako)
   - GSM Nexus 7 (tilapia)
   - Verizon Galaxy Nexus (toro)
   - Sprint Galaxy Nexus (toroplus)
* sync: Will sync latest RootBox sources before building
* threads: Allows to choose a number of threads for syncing and building operation.


ex: ./build-xy.sh maguro sync 12 (This will sync latest sources, build RootBox for GT-I9100 with -j12 threads)



You might want to consider using CCACHE to speed up build time after the first build.

This will make a signed flashable zip file located in out/target/product/-device-/xylon_DEVICE_VERSION.NO_DATE.zip

Example: /out/target/product/maguro/xylon_maguro_001_20130101.zip
