#
# Cookbook Name:: libvirt
# Resource:: node
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
attribute :memory, :kind_of => Integer, :default => 1024
attribute :cpus, :kind_of => Integer, :default => 1
attribute :vnc, :kind_of => Integer, :default => 5900
attribute :disks, :kind_of => Array, :default => []
attribute :interfaces, :kind_of => Array, :default => []

default_action :create
