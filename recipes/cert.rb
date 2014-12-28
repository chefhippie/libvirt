#
# Cookbook Name:: libvirt
# Recipe:: cert
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

include_recipe "openssl"

openssl_cert "libvirt" do
  source node["libvirt"]["cert"]["source"]
  owner node["libvirt"]["cert"]["owner"]
  group node["libvirt"]["cert"]["group"]

  cert_path node["libvirt"]["cert"]["cert_path"]
  key_path node["libvirt"]["cert"]["key_path"]
  csr_path node["libvirt"]["cert"]["csr_path"]
  ca_cert node["libvirt"]["cert"]["ca_cert"]
  ca_key node["libvirt"]["cert"]["ca_key"]
  organization node["libvirt"]["cert"]["organization"]
  unit node["libvirt"]["cert"]["unit"]
  locality node["libvirt"]["cert"]["locality"]
  state node["libvirt"]["cert"]["state"]
  country node["libvirt"]["cert"]["country"]
  cn node["libvirt"]["cert"]["cn"]
  email node["libvirt"]["cert"]["email"]
  expiration node["libvirt"]["cert"]["expiration"]
  dns_names node["libvirt"]["cert"]["dns_names"]
  self_signing node["libvirt"]["cert"]["self_signing"]
end
