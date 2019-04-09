resource "openstack_compute_instance_v2" "kbuild-1804" {
  name            = "kbuild-1804"
  image_name      = "Ubuntu 18.04"
  flavor_name     = "m1.medium"
  key_pair        = "cybera"
  security_groups = ["AllowAll"]
  user_data       = "#cloud-config\ndisable_root: false"

  network {
    name = "default"
  }

  connection {
    user  = "root"
    agent = true
    host  = "${self.access_ip_v6}"
  }

  provisioner "file" {
    source      = "../files"
    destination = "/root/files"
  }
}
