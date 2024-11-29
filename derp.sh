rm -rf .repo/local_manifests/
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 15 --git-lfs
/opt/crave/resync.sh

git clone https://github.com/musivian/device_xiaomi_mojito.git --depth 1 -b derp device/xiaomi/mojito
git clone https://github.com/musivian/device_xiaomi_sm6150-common.git --depth 1 -b derp device/xiaomi/sm6150-common

git clone https://github.com/musivian/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

git clone https://gitlab.com/musivian/vendor-xiaomi-mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/musivian/vendor-xiaomi-sm-6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

git clone https://github.com/musivian/hardware_xiaomi_mojito.git --depth 1 -b mojito hardware/xiaomi

. build/envsetup.sh
lunch derp_mojito-user
mka derp
