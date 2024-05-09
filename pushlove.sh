rm -rf /tmp/mpandroid
mkdir /tmp/mpandroid
cp -r /home/trabitboy/Dropbox/jams/moonpatoon/* /tmp/mpandroid/
cd /tmp/mpandroid
zip -r /tmp/latesttestmoonpatoon.love .
adb push /tmp/latesttestmoonpatoon.love /storage/self/primary/lovebuilds/latesttestmoonpatoon.love
