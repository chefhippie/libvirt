#
# Cookbook Name:: libvirt
# Attributes:: daemon
#
# Copyright 2013, Thomas Boerger
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

default["libvirt"]["daemon"]["service_name"] = "libvirtd"
default["libvirt"]["daemon"]["sysconfig_file"] = "/etc/sysconfig/libvirtd"
default["libvirt"]["daemon"]["config_file"] = "/etc/libvirt/libvirtd.conf"
default["libvirt"]["daemon"]["libvirt_file"] = "/etc/libvirt/libvirt.conf"

default["libvirt"]["daemon"]["uri_aliases"] = []
default["libvirt"]["daemon"]["uri_default"] = "qemu:///system"
