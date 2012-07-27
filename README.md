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
    <project name="h0tw1r3/samsung_msm8660_tools" path="autotool" remote="github" revision="jellybean" />
  </manifest>
```

```
repo sync
autotool/build.sh skyrocket
```


Auto Apply Patches
==================
This script will remove any topic branches named auto, then apply all patches under topic branch auto.
