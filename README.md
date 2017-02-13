# terraform-broadcom-kernel

This is just a simple Terraform configuration to boot an Ubuntu 14.04 virtual machine with the sole intent of compiling a version of the Broadcom `bnx2.ko` kernel module that doesn't have a certain [IPMI bug](https://lists.debian.org/debian-boot/2015/08/msg00135.html).

The module is then bundled into an Ubuntu 14.04 `initrd.gz` file to be used in a PXE/netboot environment.

Modify the `main.tf` file to suit your environment.
