# terraform-broadcom-kernel

This is just a simple Terraform configuration to boot an Ubuntu 14.04 virtual machine with the sole intent of compiling a version of the Broadcom `bnx2.ko` kernel module that doesn't have a certain [IPMI bug](https://lists.debian.org/debian-boot/2015/08/msg00135.html).

The module is then bundled into an `initrd.gz` file to be used in a PXE/netboot environment.

Modify the `main.tf` file to suit your environment.

Follow the `files/bootstrap-x.sh` script to see the build process. You might have to tune the kernel version depending on what the latest netboot kernel is.
