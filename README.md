CM10 Build Instructions
=======================
```
mkdir cm10
cd cm10
repo init -u git://github.com/CyanogenMod/android.git -b jellybean
```

Modify your `.repo/local_manifest.xml` as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
    <project name="CyanogenMod/android_device_samsung_msm8660-common" path="device/samsung/msm8660-common" />
    <project name="h0tw1r3/android_device_samsung_quincyatt" path="device/samsung/quincyatt" />
    <project name="h0tw1r3/android_device_samsung_quincy-common" path="device/samsung/quincy-common" />
    <project name="h0tw1r3/android_kernel_samsung_msm8660-common" path="kernel/samsung/msm8660-common" revision="jb-test" />
    <project name="h0tw1r3/android_vendor_samsung_quincyatt" path="vendor/samsung/quincyatt" />
    <project name="h0tw1r3/samsung_msm8660_tools" path="autotool" />
  </manifest>
```

```
repo sync
autotool/build.sh quincyatt
```


Auto Apply Patches
==================
This script will remove any topic branches named auto, then apply all patches under topic branch auto.
