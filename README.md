# terraform-broadcom-kernel

This is just a simple Terraform configuration to boot a virtual machine with the sole intent of compiling a version of the Broadcom `bnx2.ko` kernel module that doesn't have a certain [IPMI bug](https://lists.debian.org/debian-boot/2015/08/msg00135.html).

The module is then bundled into an `initrd.gz` file to be used in a PXE/netboot environment.

Modify the `main.tf` file to suit your environment.

Follow the `files/bootstrap-x.sh` script to see the build process. You might have to tune the kernel version depending on what the latest netboot kernel is.

Notes pulled from internal Jira:

The required changes to the bnx kernel driver have been applied to a 16.04 kernel, tested, and working.

To do this from scratch:

* roughly follow the instructions found here: https://github.com/jtopjian/terraform-broadcom-kernel/blob/master/files/bootstrap-1604.sh
* Instead of doing cp /root/files/bnx2.c.1604 drivers/net/ethernet/broadcom/bnx2.c, actually modify the drivers/net/ethernet/broadcom/bnx2.c file. Re-add all of the changes that were removed in this commit (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=25bfb1dd4ba3b2d9a49ce9d9b0cd7be1840e15ed).
* Place a copy of the file in the files directory, called /files/.config.XXXX where XXXX is the distro version.
* Proceed with the bootstrap script.
* This might take a few attempts as you will need to determine which exact kernel version to download. This is based on the current version available for download here (http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/).

When the initrd.gz file has been created, add it and the latest linux file (http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64//linux) to Cobbler at:

/var/www/cobbler/ks_mirror/ubuntu-XXXX/install/netboot/ubuntu-installer/amd64
/var/www/html/cobbler_files/ubuntu-XXXX (commit this to git)
