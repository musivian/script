#!/bin/bash

# Initialize ROM manifest
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# Cleanup
rm -rf device/xiaomi/sunny
rm -rf device/qcom/common
rm -rf device/qcom/qssi
rm -rf vendor/xiaomi/sunny
rm -rf kernel/xiaomi/sunny
rm -rf vendor/qcom/common
rm -rf vendor/qcom/opensource/core-utils
rm -rf packages/apps/DisplayFeatures
rm -rf packages/apps/KProfiles
rm -rf hardware/xiaomi
rm -rf hardware/qcom-caf/sm8150/media
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-elf
rm -rf prebuilts/gcc/linux-x86/arm/arm-eabi
rm -rf vendor/lineage

# Clone the necessary device repositories
git clone https://github.com/musivian/device_xiaomi_sunny.git --depth 1 -b fifteen device/xiaomi/sunny
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fifteen device/qcom/common
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b vauxite device/qcom/qssi

# Clone inline kernel (NetErnels)
git clone https://github.com/musivian/kernel_xiaomi_sunny.git --depth 1 -b staging kernel/xiaomi/sunny
# Clone inline kernel (Strix)
#git clone https://github.com/musivian/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/sunny
# Clone inline kernel (WestCoast)
#git clone https://github.com/backslashxx/mojito_krenol.git --depth 1 -b staging kernel/xiaomi/sunny

# Clone vendor repositories for Xiaomi and Qualcomm dependencies
git clone https://github.com/musivian/vendor_xiaomi_sunny.git --depth 1 -b fifteen vendor/xiaomi/sunny
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fifteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fifteen vendor/qcom/opensource/core-utils

# Clone package repositories for additional features
git clone https://github.com/cyberknight777/android_packages_apps_DisplayFeatures packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles

# Clone hardware repositories for Xiaomi and Qualcomm's SM8150 platform
git clone https://github.com/musivian/hardware_xiaomi.git --depth 1 -b fifteen hardware/xiaomi
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fifteen hardware/qcom-caf/sm8150/media

# Clone prebuilt GCC toolchains for cross-compiling
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi

# Source mods
git clone https://github.com/musivian/android_vendor_lineage.git --depth 1 -b fifteen vendor/lineage

# Set up the build environment
. build/envsetup.sh

# Build the ROM
brunch sunny
