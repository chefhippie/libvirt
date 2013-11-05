#
# Cookbook Name:: libvirt
# Provider:: pool
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
    source "pool.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "type" => new_resource.type,
      "target" => new_resource.target,
      "device" => new_resource.device,
      "volume" => new_resource.volume,
      "host" => new_resource.host,
      "dir" => new_resource.dir,
      "mode" => new_resource.mode,
      "owner" => new_resource.owner,
      "group" => new_resource.group,
      "capacity" => new_resource.capacity,
      "allocation" => new_resource.allocation,
      "available" => new_resource.available
    )

    notifies :run, "bash[virsh_pool_create_#{new_resource.name}]", :immediately
  end

  bash "virsh_pool_create_#{new_resource.name}" do
    code <<-EOH
      virsh pool-create #{create_xml_path}
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
    source "pool.xml.erb"

    variables(
      "name" => new_resource.name,
      "uuid" => new_resource.uuid,
      "type" => new_resource.type,
      "target" => new_resource.target,
      "device" => new_resource.device,
      "volume" => new_resource.volume,
      "host" => new_resource.host,
      "dir" => new_resource.dir,
      "mode" => new_resource.mode,
      "owner" => new_resource.owner,
      "group" => new_resource.group,
      "capacity" => new_resource.capacity,
      "allocation" => new_resource.allocation,
      "available" => new_resource.available
    )

    notifies :run, "bash[virsh_pool_define_#{new_resource.name}]", :immediately
  end

  bash "virsh_pool_define_#{new_resource.name}" do
    code <<-EOH
      virsh pool-define #{define_xml_path}
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
    bash "virsh_pool_start_#{new_resource.name}" do
      code <<-EOH
        virsh pool-undefine #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't undefine, pool #{new_resource.name} is not in inactive list"
  end
end

action :start do
  if inactive_include? new_resource.name
    bash "virsh_pool_start_#{new_resource.name}" do
      code <<-EOH
        virsh pool-start #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't start, pool #{new_resource.name} is not in inactive list"
  end
end

action :destroy do
  if active_include? new_resource.name
    bash "virsh_pool_destroy_#{new_resource.name}" do
      code <<-EOH
        virsh pool-destroy #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't destroy, pool #{new_resource.name} is not in active list"
  end
end

action :refresh do
  if active_include? new_resource.name
    bash "virsh_pool_refresh_#{new_resource.name}" do
      code <<-EOH
        virsh pool-refresh #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't refresh, pool #{new_resource.name} is not in active list"
  end
end

action :delete do
  if inactive_include? new_resource.name
    bash "virsh_pool_delete_#{new_resource.name}" do
      code <<-EOH
        virsh pool-delete #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't delete, pool #{new_resource.name} is not in inactive list"
  end
end

action :build do
  if inactive_include? new_resource.name
    bash "virsh_pool_build_#{new_resource.name}" do
      code <<-EOH
        virsh pool-build #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't build, pool #{new_resource.name} is not in inactive list"
  end
end

action :autoboot do
  if noboot_include? new_resource.name
    bash "virsh_pool_autoboot_#{new_resource.name}" do
      code <<-EOH
        virsh pool-autostart #{new_resource.name}
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't autoboot, pool #{new_resource.name} is not in noboot list"
  end
end

action :noboot do
  if autoboot_include? new_resource.name
    bash "virsh_pool_noboot_#{new_resource.name}" do
      code <<-EOH
        virsh pool-autostart #{new_resource.name} --disable
      EOH

      action :run
    end

    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "Can't noboot, pool #{new_resource.name} is not in autoboot list"
  end
end

protected

def create_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_pool_create_#{new_resource.name}.xml"
    )
  end
end

def define_xml_path
  @create_xml_path ||= begin
    ::File.join(
      Chef::Config[:file_cache_path],
      "virsh_pool_define_#{new_resource.name}.xml"
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
  `virsh pool-list #{flag} | grep #{name} | wc -l`.strip != "0"
end
