#
# Cookbook Name:: libvirt
# Provider:: node
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

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

action :create do
  template create_xml_path do
    owner "root"
    group "root"
    mode 0640

    cookbook "libvirt"
    source "node.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "memory" => new_resource.memory,
      "cpus" => new_resource.cpus,
      "vnc" => new_resource.vnc,
      "disks" => extended_disks,
      "interfaces" => extended_interfaces
    )

    notifies :run, "bash[virsh_node_create_#{new_resource.name}]", :immediately
  end

  bash "virsh_node_create_#{new_resource.name}" do
    code <<-EOH
      virsh create #{create_xml_path}
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
    source "node.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "memory" => new_resource.memory,
      "cpus" => new_resource.cpus,
      "vnc" => new_resource.vnc,
      "disks" => extended_disks,
      "interfaces" => extended_interfaces
    )

    notifies :run, "bash[virsh_node_define_#{new_resource.name}]", :immediately
  end

  bash "virsh_node_define_#{new_resource.name}" do
    code <<-EOH
      virsh define #{define_xml_path}
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
    bash "virsh_node_undefine_#{new_resource.name}" do
      code <<-EOH
        virsh undefine #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't undefine, node #{new_resource.name} is not in inactive list"
  end
end

action :start do
  if inactive_include? new_resource.name
    bash "virsh_node_start_#{new_resource.name}" do
      code <<-EOH
        virsh start #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't start, node #{new_resource.name} is not in inactive list"
  end
end

action :destroy do
  if active_include? new_resource.name
    bash "virsh_node_destroy_#{new_resource.name}" do
      code <<-EOH
        virsh destroy #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't destroy, node #{new_resource.name} is not in active list"
  end
end

action :autoboot do
  if noboot_include? new_resource.name
    bash "virsh_node_autoboot_#{new_resource.name}" do
      code <<-EOH
        virsh autostart #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't autoboot, node #{new_resource.name} is not in noboot list"
  end
end

action :noboot do
  if autoboot_include? new_resource.name
    bash "virsh_node_noboot_#{new_resource.name}" do
      code <<-EOH
        virsh autostart #{new_resource.name} --disable
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't noboot, node #{new_resource.name} is not in autoboot list"
  end
end

protected

def create_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_node_create_#{new_resource.name}.xml"
    )
  end
end

def define_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_node_define_#{new_resource.name}.xml"
    )
  end
end

def extended_disks
  new_resource.disks.map do |disk|
    if disk["download"]
      remote_file disk["target"] do
        source disk["download"]
        action :none
      end.run_action(:create_if_missing)
    end

    case disk["type"]
    when "block"
      disk["driver_type"] = "raw"
      disk["source_type"] = "dev"
    when "file"
      disk["driver_type"] = "qcow2"
      disk["source_type"] = "file"
    end
  end
end

def extended_interfaces
  new_resource.interfaces.map do |interface|
    case interface["type"]
    when "bridge"
      interface["source_type"] = "bridge"
    when "network"
      interface["source_type"] = "network"
    end
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
  `virsh list #{flag} | grep #{name} | wc -l`.strip != "0"
end
