resource "openstack_compute_instance_v2" "kbuild-1404" {
  name = "kbuild-1404"
  image_name = "Ubuntu 14.04"
  flavor_name = "m1.medium"
  key_pair = "infra"
  security_groups = ["AllowAll"]
  user_data = "#cloud-config\ndisable_root: false"

  connection {
    user = "root"
    private_key = "${file("~/infrastructure/keys/infra")}"
    host = "${self.access_ip_v6}"
  }

  provisioner "file" {
    source = "files"
    destination = "/root/files"
  }
}
