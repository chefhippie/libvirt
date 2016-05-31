#
# Cookbook Name:: libvirt
# Attributes:: default
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

default["libvirt"]["packages"] = value_for_platform_family(
  "debian" => %w(
    libvirt-bin
    libvirt-dev
    lvm2
  ),
  "suse" => %w(
    libvirt
    libvirt-client
    libvirt-devel
    lvm2
    bridge-utils
    dnsmasq
    ebtables
  )
)

default["libvirt"]["hook"]["script"] = "/etc/libvirt/hooks/qemu"
default["libvirt"]["hook"]["schema"] = "/etc/libvirt/hooks/qemu.schema.json"
default["libvirt"]["hook"]["json"] = "/etc/libvirt/hooks/qemu.json"

default["libvirt"]["networks"] = {}
default["libvirt"]["nodes"] = {}
default["libvirt"]["pools"] = {}
default["libvirt"]["mappings"] = {}
