# aind-unity-poc

Steps to run a Unity Android Build in Android (Anbox) in Docker ([AinD](https://github.com/aind-containers/aind)) on a Mac.

## Prereqs

- [Unity](https://unity3d.com/get-unity/download) with Android Build Support - Tested with version 2018.4.30f1
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Tested with version 6.1.16
- [Vagrant](https://www.vagrantup.com/downloads.html) - Tested with version 2.2.14
- [Android Studio ](https://developer.android.com/studio/) - Tested with version 
- [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)

## Steps
1. Build Unity Project
2. Setup AinD
3. Run AinD
4. Use AinD
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
$ sudo docker run \
   --rm \
   -td \
   --name aind \
   --privileged \
   -p 5900:5900 \
   -v /vagrant/apk.d/:/apk.d/ \
   -v /lib/modules:/lib/modules:ro \
	aind/aind:0.0.3
```

Wait for `Ready` and check for errors with `$ sudo docker logs -f aind`

When ready, copy the VNC password
```
sudo docker exec aind cat /home/user/.vnc/passwdfile
```

### Use

1. Open VNC Viewer
2. Connect to address: `127.0.0.1:5900`
3. Enter the VNC password copied from above
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

### Check logs
In VM
```
$ sudo docker logs -f aind
```

### Start anbox-bridge, if it isn't running
In VM
```
$ sudo docker exec aind /usr/local/share/anbox/anbox-bridge.sh start
```

### Check status of Anbox Container Manager
In VM
```
$ sudo docker exec aind systemctl status --no-pager -l anbox-container-manager
```

### Restart Anbox Container Manager
In container
```
$ systemctl restart anbox-container-manager
$ /usr/local/bin/anbox-container-manager-pre.sh
```

### Open Bash in already started AinD container bash
In VM
```
$ sudo docker exec -it aind bash
```

### Install APK
In container
```
cd /`apk.d/
adb install rotatingcube.apk
```

### Find Anbox launch commands (and APP_ID and ACTIVITY_ID)
In container
```
sed -n 's!^Exec=/usr/bin/!!p' ~/.local/share/applications/anbox/*.desktop
```

### Launch APK in Anbox
In container
```
anbox launch --action=android.intent.action.MAIN --package=[APP_ID] --component=[ACTIVITY_ID]
```

## References

* [Unity - Scripting API: MonoBehaviour.StartCoroutine](https://docs.unity3d.com/ScriptReference/MonoBehaviour.StartCoroutine.html)
*  [Creating A Rotating Cube With Unity3D](https://masoudarvishian.wordpress.com/2017/04/29/creating-a-rotating-cube-with-unity3d/) 
* [Unity - Manual:  Building apps for Android](https://docs.unity3d.com/Manual/android-BuildProcess.html)
