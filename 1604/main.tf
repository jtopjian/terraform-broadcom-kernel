resource "openstack_compute_instance_v2" "kbuild-1604" {
  name = "kbuild-1604"
  image_name = "Ubuntu 16.04"
  flavor_name = "m1.medium"
  key_pair = "keyname"
  security_groups = ["AllowAll"]
  user_data = "#cloud-config\ndisable_root: false"

  connection {
    user = "root"
    private_key = "${file("path/to/id_rsa")}"
    host = "${self.access_ip_v6}"
  }

  provisioner "file" {
    source = "../files"
    destination = "/root/files"
  }
}
