#
# Cookbook Name:: libvirt
# Recipe:: default
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

include_recipe "network"

node["libvirt"]["packages"].each do |name|
  package name do
    action :install
  end
end

include_recipe "libvirt::cert"
include_recipe "libvirt::daemon"
include_recipe "libvirt::guests"

node["libvirt"]["networks"].each do |name, data|
  (data["action"] ? data["action"].map(&:to_sym) : [:define]).each do |current_action|
    libvirt_network name do
      uuid data["uuid"]
      mac data["mac"]
      domain data["domain"]
      bridge data["bridge"]
      ip data["ip"]
      netmask data["netmask"]

      dhcp_enable data["dhcp_enable"]
      dhcp_start data["dhcp_start"]
      dhcp_end data["dhcp_end"]
      dhcp_hosts data["dhcp_hosts"]

      dns_enable data["dns_enable"]
      dns_forwarders data["dns_forwarders"]
      dns_hosts data["dns_hosts"]

      action current_action
    end
  end
end

node["libvirt"]["nodes"].each do |name, data|
  (data["action"] ? data["action"].map(&:to_sym) : [:define]).each do |current_action|
    libvirt_node name do
      memory data["memory"]
      cpus data["cpus"]
      vnc data["vnc"]

      disks data["disks"]
      interfaces data["interfaces"]

      action current_action
    end
  end
end

node["libvirt"]["pools"].each do |name, data|
  (data["action"] ? data["action"].map(&:to_sym) : [:define]).each do |current_action|
    libvirt_pool name do
      uuid data["uuid"]
      type data["type"]
      target data["target"]

      device data["device"]
      volume data["volume"]

      host data["host"]
      dir data["dir"]

      mode data["mode"]
      owner data["owner"]
      group data["group"]

      capacity data["capacity"]
      allocation data["allocation"]
      available data["available"]

      action current_action
    end
  end
end
