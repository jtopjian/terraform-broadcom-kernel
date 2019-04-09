#!/bin/bash

cd /root

sed -i -e 's/# deb-src/deb-src/g' /etc/apt/sources.list
apt-get update -qq
apt-get install -y dpkg-dev linux-headers-4.15.0-45-generic libssl-dev

mkdir linux
pushd linux
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/linux/4.15.0-45.48/linux_4.15.0.orig.tar.gz
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/linux/4.15.0-45.48/linux_4.15.0-45.48.diff.gz
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/linux/4.15.0-45.48/linux_4.15.0-45.48.dsc
dpkg-source -x linux_4.15.0-45.48.dsc

pushd linux-4.15.0
cp /root/files/.config.1804 .config
cp /usr/src/linux-headers-4.15.0-45-generic/Module.symvers .
cp /root/files/bnx2.c.1804 drivers/net/ethernet/broadcom/bnx2.c
make scripts
make modules_prepare
echo 4.15.0-45-generic > include/config/kernel.release
sed -i -e 's/4.15.18/4.15.0-45-generic/' include/generated/utsrelease.h
make M=drivers/net/ethernet/broadcom
popd
popd

mkdir initrd
pushd initrd
wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz
mkdir staging
pushd staging
zcat ../initrd.gz | cpio -iv
cp /root/linux/linux-4.15.0/drivers/net/ethernet/broadcom/bnx2.ko lib/modules/4.15.0-45-generic/kernel/drivers/net/ethernet/broadcom/bnx2.ko
find . -print0 | cpio -0 -H newc -ov | gzip -c > ../initrd.gz
popd
popd
