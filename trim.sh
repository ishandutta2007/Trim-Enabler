#
# Original version by Grant Parnell is offline (http://digitaldj.net/2011/07/21/trim-enabler-for-lion/)
# Update July 2014: no longer offline, see https://digitaldj.net/blog/2011/11/17/trim-enabler-for-os-x-lion-mountain-lion-mavericks/
#
# Looks for "Apple" string in HD kext, changes it to a wildcard match for anything
#
# Alternative to http://www.groths.org/trim-enabler-3-0-released/
# Method behind this madness described: http://forums.macrumors.com/showthread.php?t=1409151&page=4
# See discussion in comments here: https://www.macupdate.com/app/mac/39654/lion-tweaks
# And here: http://forums.macrumors.com/showthread.php?t=1410459
# And here: http://forums.macrumors.com/showthread.php?t=1480302
#
# Yosemite: for recovering from stop sign on boot screen, please see http://www.cindori.org/update-on-trim-in-yosemite/

# backup patched file
sudo cp /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage.original

# Important: Add "kext-dev-mode=1" as Kernel Arguments or the computer won't boot.
sudo nvram boot-args="kext-dev-mode=1"
sudo shutdown -r now

# looks for "Apple" string in HD kext, changes it to a wildcard match for anything
sudo perl -pi -e 's|\x00\x41\x50\x50\x4c\x45\x20\x53\x53\x44\x00|\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00|' /System/Library/Extensions/IOAHCIFamily.kext/Contents/PlugIns/IOAHCIBlockStorage.kext/Contents/MacOS/IOAHCIBlockStorage

# rebuild kext cache manually (could take a while)
sudo touch /System/Library/Extensions
sudo kextcache -m /System/Library/Caches/com.apple.kext.caches/Startup/Extensions.mkext /System/Library/Extensions

# now reboot!
sudo shutdown -r now
