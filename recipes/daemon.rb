#
# Cookbook Name:: libvirt
# Recipe:: daemon
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

template node["libvirt"]["daemon"]["sysconfig_file"] do
  source "daemon.sysconfig.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["sysconfig_file"].empty?
  end
end

template node["libvirt"]["daemon"]["config_file"] do
  source "libvirtd.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["config_file"].empty?
  end
end

template node["libvirt"]["daemon"]["libvirt_file"] do
  source "libvirt.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["libvirt_file"].empty?
  end
end

template node["libvirt"]["daemon"]["lxc_file"] do
  source "lxc.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["lxc_file"].empty?
  end
end

template node["libvirt"]["daemon"]["qemu_file"] do
  source "qemu.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["qemu_file"].empty?
  end
end

template node["libvirt"]["daemon"]["qemulockd_file"] do
  source "qemulockd.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["qemulockd_file"].empty?
  end
end

template node["libvirt"]["daemon"]["virtlockd_file"] do
  source "virtlockd.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["libvirt"]["daemon"]
  )

  notifies :restart, "service[libvirt-daemon]"

  not_if do
    node["libvirt"]["daemon"]["virtlockd_file"].empty?
  end
end

service "libvirt-daemon" do
  service_name node["libvirt"]["daemon"]["service_name"]
  action [:enable, :start]
end
