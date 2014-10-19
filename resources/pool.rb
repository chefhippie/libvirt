#
# Cookbook Name:: libvirt
# Resource:: pool
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

actions :create, :define, :destroy, :delete, :start, :undefine, :build, :refresh, :autoboot, :noboot

attribute :name, :kind_of => String, :name_attribute => true
attribute :uuid, :kind_of => String, :default => nil
attribute :type, :kind_of => String, :default => nil
attribute :target, :kind_of => String, :default => nil
attribute :device, :kind_of => String, :default => nil
attribute :volume, :kind_of => String, :default => nil
attribute :host, :kind_of => String, :default => nil
attribute :dir, :kind_of => String, :default => nil
attribute :mode, :kind_of => String, :default => "0755"
attribute :owner, :kind_of => Integer, :default => -1
attribute :group, :kind_of => Integer, :default => -1
attribute :capacity, :kind_of => Integer, :default => 0
attribute :allocation, :kind_of => Integer, :default => 0
attribute :available, :kind_of => Integer, :default => 0

default_action :create
