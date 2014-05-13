Chromium For BrowserStack WebRTC
================================

 - Get the chromium.tgz from your nearest Live Team Member or from the official BS-HDD
 - Untar in a directory of your choice
    tar xvzf chromium.tgz
 - Clone depot\_tools anywhere you like, preferably outside the chromium directory
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
 - Add the path to the depot\_tools directory to your ~/\.[ba|z]shrc file
 - Get into the chromium source directory
    cd <path\_to\_chromium>/src
 - Run the following:
```
GYP_DEFINES=fastbuild=1 build/gyp_chromium
 - Followed by:
    ninja -C out/Release chrome

 - Chromium is now built!
