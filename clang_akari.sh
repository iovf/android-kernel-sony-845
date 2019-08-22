rm -rf out
export ARCH=arm64
export DTC_EXT=/root/build_tool/dtc
export DTC_OVERLAY_TEST_EXT=/root/build_tool/ufdt_apply_overlay
export CLANG_PATH=/root/build_tool/clang-4691093/bin/
export CROSS_COMPILE=/root/build_tool/aarch64/bin/aarch64-linux-android-
export KCFLAGS=-mno-android
export PATH=${CLANG_PATH}:${PATH}
export CLANG_HOST=yes
export CLANG_TRIPLE=aarch64-linux-gnu-
export KBUILD_DIFFCONFIG=akari_diffconfig
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
make O=out ARCH=arm64 CONFIG_BUILD_ARM64_DT_OVERLAY=y sdm845-perf_defconfig
make O=out  CONFIG_BUILD_ARM64_DT_OVERLAY=y -j6
/root/build_tool/mkbootimg.py  \
--kernel out/arch/arm64/boot/Image.gz-dtb \
--ramdisk ./xz2.gz \
--os_version "9.0.0" --os_patch_level "2019-08-01" \
--cmdline "androidboot.hardware=qcom androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7 loop.max_part=7 panic_on_err=1 msm_drm.dsi_display0=dsi_panel_cmd_display:config0 buildvariant=user" \
--base 0x00000000 \
--kernel_offset 0x00008000 \
--tags_offset 0x00000100 \
--pagesize 4096 \
-o boot.img
/root/build_tool/mkdtimg create dtbo.img --page_size=4096 `find out/arch/arm64/boot/dts -name "*.dtbo"`
