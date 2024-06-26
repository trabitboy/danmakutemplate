import subprocess
import os


# python solution was devised because some characters in note4 path made sh fail sometimes


remoteSource='sdcard/Android/data/trabitboy.zzn/files/save/lovegame/project/2405bhj'

localTarget='sourcepics'
#localTarget='/cygdrive/c/tmp/zazexport'


def pullframes(files):
    os.chdir(localTarget)
    #result=subprocess.run(['adb','pull','-p',remoteSource+'/'+frames[0]])
    #print(result)

    for frame in files :
        print("file to pull :"+frame)
        result=subprocess.run(['adb','pull',remoteSource+'/'+frame])
        print(result)



result=subprocess.run(['adb','shell','ls',remoteSource],stdout=subprocess.PIPE)

print(result.stdout)

frames=result.stdout.decode('utf-8').splitlines()

print(frames)

filteredFrames=[]
#filtering empty lines created by parsing return of adb ls
for frame in frames:
    if frame:#not empty
        filteredFrames.append(frame)

print('filtered frames:')
print(filteredFrames)

pullframes(filteredFrames)
#subprocess.run(['cd',localTarget],stdout=subprocess.PIPE)

#specifying target files fails (maybe because I pass cygwin path )
#result=subprocess.run(['adb','pull','-p',remoteSource+'/'+frames[0],localTarget+'/'+frames[0]])
