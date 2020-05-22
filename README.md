# aind-unity-poc

## Steps
1. Create Unity Project
2. Build Unity Project
3. Setup aind
4. Run aind
5. Use aind
6. Shutdown
7. Cleanup

## TODO
- Don't store local password and mount it. It is worthless to others, but it still feels dirty.

## Unity project

inspired by the example
https://masoudarvishian.wordpress.com/2017/04/29/creating-a-rotating-cube-with-unity3d/

Building apps for Android
https://docs.unity3d.com/Manual/android-BuildProcess.html

android sdkhttps://developer.android.com/studio/ (could probably just install the command line tools)

Android SDK root folder `/Users/username/Library/Android/sdk`

Save apk in `./apk.d/`

## aind

### Setup
```
$ vagrant up
```

### Run

On host
```
$ vagrant ssh
```

In vm
```
$ sudo docker run --rm -td --name aind --privileged -p 5900:5900 -v /vagrant/passwdfile:/home/user/.vnc/passwdfile:ro -v /vagrant/apk.d/:/apk.d/ -v /lib/modules:/lib/modules:ro aind/aind
```

wait... and check for errors `$ sudo docker logs -f aind`

### Use

install vnc viewer on host machine
https://www.realvnc.com/en/connect/download/viewer/

open vnc viewer
address: `127.0.0.1:5900`
password `4p5gvwu0jei02cilj7yyfnyuvfw312qc`

TODO - Anbox Application Manager
TODO - run app from terminal

Xterm
```
cd /`apk.d/
adb install rotatingcube.apk
```

### Shutdown

In vm
```
$ sudo docker stop aind
```

On host
```
$ vagrant halt
```

### Cleanup

```
$ vagrant destroy -f
```

## Troubleshooting

In vm
```
$ sudo docker logs -f aind
```

anbox-bridge isn't running
```
sudo docker exec aind /usr/local/share/anbox/anbox-bridge.sh start
```

check status of container manager
```
sudo docker exec aind systemctl status --no-pager -l anbox-container-manager
```

restart anbox container manager
```
systemctl restart anbox-container-manager
```

pre
```
$ /usr/local/bin/anbox-container-manager-pre.sh
+ /sbin/modprobe binder_linux
modprobe: FATAL: Module binder_linux not found in directory /lib/modules/5.3.0-53-generic
```

bash
```
$ sudo docker exec -it aind bash
```

open xterm

```
cd /apk.d/

```

```
anbox launch ...
```

```
adb install rotatingcube.apk
```
