rm -rf out
export ARCH=arm64
export DTC_EXT=/root/bkup/dtc
export DTC_OVERLAY_TEST_EXT=/root/bkup/ufdt_apply_overlay
export KCFLAGS=-mno-android
export PATH=/root/build_tool/aarch64/bin:$PATH
export CROSS_COMPILE=aarch64-linux-android-
export KBUILD_DIFFCONFIG=akari_diffconfig
make CONFIG_BUILD_ARM64_DT_OVERLAY=y O=./out sdm845-perf_defconfig
make CONFIG_BUILD_ARM64_DT_OVERLAY=y O=./out

/root/build_tool/mkbootimg.py  \
        --kernel out/arch/arm64/boot/Image.gz-dtb \
        --os_version "9.0.0" --os_patch_level "2019-07-01" \
        --cmdline "androidboot.hardware=qcom androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3 firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7 zram.backend=z3fold loop.max_part=7 panic_on_err=1 msm_drm.dsi_display0=dsi_panel_cmd_display:config0 buildvariant=userdebug" \
        --base 0x00000000 \
        --kernel_offset 0x00008000 \
        --tags_offset 0x00000100 \
        --pagesize 4096 \
        -o boot.img
/root/bkup/mkdtimg create dtbo.img --page_size=4096 `find out/arch/arm64/boot/dts -name "*.dtbo"`


