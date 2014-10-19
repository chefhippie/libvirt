#
# Cookbook Name:: libvirt
# Resource:: network
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

actions :create, :define, :destroy, :start, :undefine, :autoboot, :noboot

attribute :name, :kind_of => String, :name_attribute => true
attribute :uuid, :kind_of => String, :default => nil
attribute :mac, :kind_of => String, :default => nil
attribute :bridge, :kind_of => String, :default => "virbr1"
attribute :ip, :kind_of => String, :default => "192.168.0.1"
attribute :netmask, :kind_of => String, :default => "255.255.0.0"
attribute :dhcp_enable, :kind_of => [TrueClass, FalseClass], :default => false
attribute :dhcp_start, :kind_of => String, :default => nil
attribute :dhcp_end, :kind_of => String, :default => nil
attribute :dhcp_hosts, :kind_of => Array, :default => []

default_action :create
