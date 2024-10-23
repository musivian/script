#!/bin/bash

# Remove any existing local manifest directory (clean start)
rm -rf .repo/local_manifests/

# Initialize the ROM manifest using RisingTechOSS repository (branch 'fourteen')
repo init -u https://github.com/ProjectEverest/manifest.git -b fourteen --git-lfs

# Synchronize the repository using the custom 'resync.sh' script
/opt/crave/resync.sh

# Clean up unnecessary directories after repo sync
rm -rf hardware/qcom-caf/sm8150/media   # Remove outdated Qualcomm CAF media hardware
rm -rf vendor/lineage                   # Remove existing LineageOS vendor files
rm -rf hardware/xiaomi                  # Remove existing hardware/xiaomi files

# Clone the device tree repositories for Xiaomi Sunny and related kernel, common configurations
# Device-specific tree
git clone https://github.com/musivian/device_xiaomi_sunny.git --depth 1 -b fourteen device/xiaomi/sunny
git clone https://github.com/musivian/device_xiaomi_sunny-kernel.git--depth 1 -b fourteen device/xiaomi/sunny-kernel

# Clone Qualcomm common device tree (QSSI) and shared Qualcomm configurations
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b uvite device/qcom/qssi
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fourteen device/qcom/common

# (Optional) Clone the kernel tree for Xiaomi Sunny (commented out for now)
# git clone https://github.com/PixelOS-Devices/kernel_xiaomi_sunny.git --depth 1 -b fourteen kernel/xiaomi/sunny

# Clone the vendor repositories for Xiaomi Sunny and Qualcomm components
git clone https://github.com/PixelOS-Devices/vendor_xiaomi_sunny.git --depth 1 -b fourteen vendor/xiaomi/sunny
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fourteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fourteen vendor/qcom/opensource/core-utils

# Clone hardware-specific files for Xiaomi devices
git clone https://github.com/musivian/hardware_xiaomi.git --depth 1 -b fourteen hardware/xiaomi

# Clone prebuilt GCC compilers (used for building the kernel and other components)
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi

# Clone packages such as DisplayFeatures and KProfiles for extended functionality
git clone https://github.com/cyberknight777/android_packages_apps_DisplayFeatures.git --depth 1 -b master packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles

# Clone source modifications, including media hardware and vendor Lineage files
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fourteen hardware/qcom-caf/sm8150/media
git clone https://github.com/musivian/android_vendor_lineage.git --depth 1 -b fourteen vendor/lineage

# Set up the build environment (source environment setup script)
. build/envsetup.sh
lunch lineage_sunny-user
mka everest -j$(nproc --all)
