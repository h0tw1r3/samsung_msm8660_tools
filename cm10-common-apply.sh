# Should only be called from the other apply scripts!

################ Apply Patches Below ####################

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
echo "### audio/msm8660: add compatibility for the older voice api"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_qcom_audio refs/changes/46/20046/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware_legacy
cdv hardware/libhardware_legacy
echo "### hardware/libhardware_legacy: Add interface function for LPA and FM"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware_legacy refs/changes/85/20185/5 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
echo "### hardware/audio: add JB API compatibility to LPA's open_output_session"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_hardware_libhardware refs/changes/84/20184/1 && git cherry-pick FETCH_HEAD
cdb

