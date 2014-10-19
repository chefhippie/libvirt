#
# Cookbook Name:: libvirt
# Provider:: network
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

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

action :create do
  template create_xml_path do
    owner "root"
    group "root"
    mode 0640

    cookbook "libvirt"
    source "network.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "mac" => new_resource.mac,
      "bridge" => new_resource.bridge,
      "ip" => new_resource.ip,
      "netmask" => new_resource.netmask,
      "dhcp_enable" => new_resource.dhcp_enable,
      "dhcp_start" => new_resource.dhcp_start,
      "dhcp_end" => new_resource.dhcp_end,
      "dhcp_hosts" => new_resource.dhcp_hosts
    )

    notifies :run, "bash[virsh_net_create_#{new_resource.name}]", :immediately
  end

  bash "virsh_net_create_#{new_resource.name}" do
    code <<-EOH
      virsh net-create #{create_xml_path}
    EOH

    action :run
    notifies :reload, "service[libvirt-daemon]"

    not_if do
      all_include? new_resource.name
    end
  end

  new_resource.updated_by_last_action(true)
end

action :define do
  template define_xml_path do
    owner "root"
    group "root"
    mode 0640

    cookbook "libvirt"
    source "network.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "mac" => new_resource.mac,
      "bridge" => new_resource.bridge,
      "ip" => new_resource.ip,
      "netmask" => new_resource.netmask,
      "dhcp_enable" => new_resource.dhcp_enable,
      "dhcp_start" => new_resource.dhcp_start,
      "dhcp_end" => new_resource.dhcp_end,
      "dhcp_hosts" => new_resource.dhcp_hosts
    )

    notifies :run, "bash[virsh_net_define_#{new_resource.name}]", :immediately
  end

  bash "virsh_net_define_#{new_resource.name}" do
    code <<-EOH
      virsh net-define #{define_xml_path}
    EOH

    action :run
    notifies :reload, "service[libvirt-daemon]"

    not_if do
      all_include? new_resource.name
    end
  end

  new_resource.updated_by_last_action(true)
end

action :undefine do
  if inactive_include? new_resource.name
    bash "virsh_net_undefine_#{new_resource.name}" do
      code <<-EOH
        virsh net-undefine #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't undefine, network #{new_resource.name} is not in inactive list"
  end
end

action :start do
  if inactive_include? new_resource.name
    bash "virsh_net_start_#{new_resource.name}" do
      code <<-EOH
        virsh net-start #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't start, network #{new_resource.name} is not in inactive list"
  end
end

action :destroy do
  if active_include? new_resource.name
    bash "virsh_net_destroy_#{new_resource.name}" do
      code <<-EOH
        virsh net-destroy #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't destroy, network #{new_resource.name} is not in active list"
  end
end

action :autoboot do
  if noboot_include? new_resource.name
    bash "virsh_net_autoboot_#{new_resource.name}" do
      code <<-EOH
        virsh net-autostart #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't autoboot, network #{new_resource.name} is not in noboot list"
  end
end

action :noboot do
  if autoboot_include? new_resource.name
    bash "virsh_net_noboot_#{new_resource.name}" do
      code <<-EOH
        virsh net-autostart #{new_resource.name} --disable
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't noboot, network #{new_resource.name} is not in autoboot list"
  end
end

protected

def create_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_net_create_#{new_resource.name}.xml"
    )
  end
end

def define_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_net_define_#{new_resource.name}.xml"
    )
  end
end

def all_include?(name)
  listing_include? "--all", name
end

def autoboot_include?(name)
  listing_include? "--autostart", name
end

def noboot_include?(name)
  listing_include? "--no-autostart", name
end

def inactive_include?(name)
  listing_include? "--inactive", name
end

def active_include?(name)
  listing_include? "", name
end

def listing_include?(flag, name)
  `virsh net-list #{flag} | grep #{name} | wc -l`.strip != "0"
end
