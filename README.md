# aind-unity-poc

Steps to run a Unity Android Build in Android (Anbox) in Docker ([AinD](https://github.com/aind-containers/aind)) on a Mac.

## Prereqs

- [Unity](https://unity3d.com/get-unity/download) with Android Build Support - Tested with version 2017.4.40f1
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Tested with version 6.0.22
- [Vagrant](https://www.vagrantup.com/downloads.html) - Tested with version 2.2.9
- [Android Studio ](https://developer.android.com/studio/) - would probably just install the command line tools
- [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)

## Steps
1. Build Unity Project
2. Setup aind
3. Run aind
4. Use aind
5. Shutdown
6. Cleanup

## Unity Project

1. Open Unity Project `./RotatingCube`
2. File > Build Settings
3. Android
4. Use all defaults
5. Build
6. Save apk to `./apk.d/rotatingcube.apk`

## AinD

In a terminal, at the project root.

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

Wait for `Ready` and check for errors with `$ sudo docker logs -f aind`

### Use

#### Terminal

*TODO*

#### VNC

1. Open VNC Viewer
2. Connect to address: `127.0.0.1:5900`
3. Password is `4p5gvwu0jei02cilj7yyfnyuvfw312qc`
4. Connect
4. When you connect to the server, Anbox Application Manager window should be open
5. Double-click on RotatingCube
6. RotatingCube should appear for approx. 2 seconds and then close

There you go. You ran an Unity Android build in a container.

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

### check logs
```
$ sudo docker logs -f aind
```

### anbox-bridge isn't running
```
sudo docker exec aind /usr/local/share/anbox/anbox-bridge.sh start
```

### check status of container manager
```
sudo docker exec aind systemctl status --no-pager -l anbox-container-manager
```

### restart anbox container manager
```
systemctl restart anbox-container-manager
```

run pre script
```
$ /usr/local/bin/anbox-container-manager-pre.sh
+ /sbin/modprobe binder_linux
modprobe: FATAL: Module binder_linux not found in directory /lib/modules/5.3.0-53-generic
```

### open bash in already started aind container bash
```
$ sudo docker exec -it aind bash
```

### install apk
open xterm
```
cd /`apk.d/
adb install rotatingcube.apk
```

### find anbox launch commands
```
sed -n 's!^Exec=/usr/bin/!!p' ~/.local/share/applications/anbox/*.desktop
```

### launch apk in anbox
```
anbox launch --action=android.intent.action.MAIN --package=APP_ID --component=ACTIVITY_ID
```

## TODO
- Don't store local password and mount it. It is worthless to others, but it still feels dirty.

## References

https://docs.unity3d.com/ScriptReference/MonoBehaviour.StartCoroutine.html

https://masoudarvishian.wordpress.com/2017/04/29/creating-a-rotating-cube-with-unity3d/

Building apps for Android
https://docs.unity3d.com/Manual/android-BuildProcess.html

android sdk https://developer.android.com/studio/ (could probably just install the command line tools)

Android SDK root folder `/Users/username/Library/Android/sdk`
