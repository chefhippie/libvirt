#
# Cookbook Name:: libvirt
# Attributes:: daemon
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["libvirt"]["daemon"]["service_name"] = value_for_platform_family(
  "debian" => "libvirt-bin",
  "ubuntu" => "libvirt-bin",
  "suse" => "libvirtd"
)
default["libvirt"]["daemon"]["sysconfig_file"] = value_for_platform_family(
  "debian" => "/etc/default/libvirt-bin",
  "ubuntu" => "/etc/default/libvirt-bin",
  "suse" => "/etc/sysconfig/libvirtd"
)
default["libvirt"]["daemon"]["config_file"] = "/etc/libvirt/libvirtd.conf"
default["libvirt"]["daemon"]["libvirt_file"] = "/etc/libvirt/libvirt.conf"
default["libvirt"]["daemon"]["uri_aliases"] = []
default["libvirt"]["daemon"]["uri_default"] = "qemu:///system"

default["libvirt"]["daemon"]["listen_tls"] = true
default["libvirt"]["daemon"]["tls_port"] = 16514
default["libvirt"]["daemon"]["listen_tcp"] = true
default["libvirt"]["daemon"]["tcp_port"] = 16509
default["libvirt"]["daemon"]["listen_addr"] = "127.0.0.1"
default["libvirt"]["daemon"]["auth_unix_ro"] = "none"
default["libvirt"]["daemon"]["auth_unix_rw"] = "none"
default["libvirt"]["daemon"]["auth_tls"] = "none"
default["libvirt"]["daemon"]["auth_tcp"] = "sasl"
default["libvirt"]["daemon"]["key_file"] = node["libvirt"]["cert"]["key_path"]
default["libvirt"]["daemon"]["cert_file"] = node["libvirt"]["cert"]["cert_path"]
default["libvirt"]["daemon"]["ca_file"] = node["libvirt"]["cert"]["ca_cert"]
default["libvirt"]["daemon"]["crl_file"] = node["libvirt"]["cert"]["ca_crl"]
default["libvirt"]["daemon"]["tls_no_sanity_certificate"] = true
default["libvirt"]["daemon"]["tls_no_verify_certificate"] = true

default["libvirt"]["daemon"]["lxc_file"] = "/etc/libvirt/lxc.conf"
default["libvirt"]["daemon"]["lxc"]["log_with_libvirtd"] = 1
default["libvirt"]["daemon"]["lxc"]["security_driver"] = "none"
default["libvirt"]["daemon"]["lxc"]["security_default_confined"] = 0
default["libvirt"]["daemon"]["lxc"]["security_require_confined"] = 0

default["libvirt"]["daemon"]["qemu_file"] = "/etc/libvirt/qemu.conf"
default["libvirt"]["daemon"]["qemu"]["security_driver"] = "none"
default["libvirt"]["daemon"]["qemu"]["security_default_confined"] = 0
default["libvirt"]["daemon"]["qemu"]["security_require_confined"] = 0
default["libvirt"]["daemon"]["qemu"]["vnc_listen"] = "127.0.0.1"
default["libvirt"]["daemon"]["qemu"]["vnc_auto_unix_socket"] = true
default["libvirt"]["daemon"]["qemu"]["vnc_tls"] = false
default["libvirt"]["daemon"]["qemu"]["vnc_tls_x509_cert_dir"] = "/etc/pki/libvirt-vnc"
default["libvirt"]["daemon"]["qemu"]["vnc_tls_x509_verify"] = true
default["libvirt"]["daemon"]["qemu"]["vnc_password"] = (0...8).map { (65 + rand(26)).chr }.join
default["libvirt"]["daemon"]["qemu"]["vnc_sasl"] = false
default["libvirt"]["daemon"]["qemu"]["vnc_sasl_dir"] = "/some/directory/sasl"
default["libvirt"]["daemon"]["qemu"]["vnc_allow_host_audio"] = false
default["libvirt"]["daemon"]["qemu"]["spice_listen"] = "127.0.0.1"
default["libvirt"]["daemon"]["qemu"]["spice_tls"] = false
default["libvirt"]["daemon"]["qemu"]["spice_tls_x509_cert_dir"] = "/etc/pki/libvirt-spice"
default["libvirt"]["daemon"]["qemu"]["spice_password"] = (0...8).map { (65 + rand(26)).chr }.join

default["libvirt"]["daemon"]["qemulockd_file"] = "/etc/libvirt/qemu-lockd.conf"
default["libvirt"]["daemon"]["qemulockd"]["auto_disk_leases"] = 0
default["libvirt"]["daemon"]["qemulockd"]["require_lease_for_disks"] = 1
default["libvirt"]["daemon"]["qemulockd"]["file_lockspace_dir"] = "/var/lib/libvirt/lockd/files"
default["libvirt"]["daemon"]["qemulockd"]["lvm_lockspace_dir"] = "/var/lib/libvirt/lockd/lvmvolumes"
default["libvirt"]["daemon"]["qemulockd"]["scsi_lockspace_dir"] = "/var/lib/libvirt/lockd/scsivolumes"

default["libvirt"]["daemon"]["virtlockd_file"] = "/etc/libvirt/virtlockd.conf"
default["libvirt"]["daemon"]["virtlockd"]["log_filters"] = "3:remote 4:event"
default["libvirt"]["daemon"]["virtlockd"]["log_outputs"] = "3:syslog:virtlockd"
default["libvirt"]["daemon"]["virtlockd"]["log_level"] = 3
default["libvirt"]["daemon"]["virtlockd"]["log_buffer_size"] = 64
default["libvirt"]["daemon"]["virtlockd"]["max_clients"] = 1024
