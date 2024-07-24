#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate

# 发布固件名称添加日期
sed -i 's/^IMG_PREFIX\:\=.*/IMG_PREFIX:=$(shell date +"%Y%m%d")-$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))/g' include/image.mk

# 页面版本号添加日期
sed -i "s/R[0-9]\+\.[0-9]\+\.[0-9]\+/&("$(date +%Y-%m-%d)")/g" package/lean/default-settings/files/zzz-default-settings

# Add luci-app-vssr <M>
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add luci-proto-minieap
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap


# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile






# Add extra wireless drivers
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/kernel/rtl8812au-ac
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/kernel/rtl8821cu
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/kernel/rtl8188eu
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/kernel/rtl8192du
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/kernel/rtl88x2bu
