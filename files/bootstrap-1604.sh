#!/bin/bash

cd /root

apt-get update -qq
apt-get install -y dpkg-dev
apt-get install -y dpkg-dev linux-headers-4.4.0-142-generic

apt-get source linux-image-4.4.0-142-generic
apt-get build-dep -y linux-image-4.4.0-142-generic

pushd linux-4.4.0
cp /root/files/.config.1604 .config
cp /usr/src/linux-headers-4.4.0-142-generic/Module.symvers .
cp /root/files/bnx2.c.1604 drivers/net/ethernet/broadcom/bnx2.c
make scripts
make modules_prepare
make M=drivers/net/ethernet/broadcom
popd

mkdir initrd
pushd initrd
wget http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz
mkdir staging
pushd staging
zcat ../initrd.gz | cpio -iv
cp /root/linux-4.4.0/drivers/net/ethernet/broadcom/bnx2.ko lib/modules/4.4.0-142-generic/kernel/drivers/net/ethernet/broadcom/bnx2.ko
find . -print0 | cpio -0 -H newc -ov | gzip -c > ../initrd.gz
popd
popd
