#!/usr/bin/env bash

set -e

# 检查是否为 root 用户
if [ "$(id -u)" -ne 0 ]; then
  echo "please run this script as root"
  exit 1
fi

# 确定系统架构
ARCH=$(uname -m)
case $ARCH in
x86_64)
  ARCH_NAME="amd64"
  ;;
aarch64)
  ARCH_NAME="arm64"
  ;;
*)
  echo "arch not supported: $ARCH"
  exit 1
  ;;
esac

# 获取最新 release 信息
LATEST_RELEASE=$(curl -s https://api.github.com/repos/emctoo/quadlet-static/releases/latest)
DOWNLOAD_URL=$(echo $LATEST_RELEASE | grep -o "https://github.com/emctoo/quadlet-static/releases/download/[^\"]*quadlet-$ARCH_NAME")

if [ -z "$DOWNLOAD_URL" ]; then
  echo "fail to find download link, arch: $ARCH_NAME"
  exit 1
fi

# 下载二进制文件
echo "Downloading quadlet binary to /usr/local/bin/quadlet ..."
curl -sL $DOWNLOAD_URL -o /usr/local/bin/quadlet

# 设置执行权限
chmod +x /usr/local/bin/quadlet

# 创建符号链接
mkdir -p /etc/systemd/user-generators
ln -sf /usr/local/bin/quadlet /etc/systemd/user-generators/podman-user-generator

mkdir -p /etc/systemd/system-generators
ln -sf /usr/local/bin/quadlet /etc/systemd/system-generators/podman-system-generator

echo "quadlet downloaded to /usr/local/bin/quadlet"
echo "The following links are created: "
echo "  /etc/systemd/user-generators/podman-user-generator"
echo "  /etc/systemd/system-generators/podman-system-generator"
