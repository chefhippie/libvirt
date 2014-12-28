#
# Cookbook Name:: libvirt
# Attributes:: cert
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

default["libvirt"]["cert"]["source"] = "generate"
default["libvirt"]["cert"]["owner"] = "root"
default["libvirt"]["cert"]["group"] = "root"
  
default["libvirt"]["cert"]["cert_path"] = "#{node["openssl"]["cert_path"]}/libvirt/cert.pem"
default["libvirt"]["cert"]["key_path"] = "#{node["openssl"]["cert_path"]}/libvirt/key.pem"
default["libvirt"]["cert"]["csr_path"] = "#{node["openssl"]["cert_path"]}/libvirt/csr.pem"

default["libvirt"]["cert"]["ca_cert"] = node["openssl"]["ca"]["cert_path"]
default["libvirt"]["cert"]["ca_key"] = node["openssl"]["ca"]["key_path"]
default["libvirt"]["cert"]["ca_crl"] = node["openssl"]["ca"]["crl_path"]

default["libvirt"]["cert"]["cn"] = "libvirt"
default["libvirt"]["cert"]["organization"] = node["openssl"]["organization"]
default["libvirt"]["cert"]["unit"] = node["openssl"]["unit"]
default["libvirt"]["cert"]["locality"] = node["openssl"]["locality"]
default["libvirt"]["cert"]["state"] = node["openssl"]["state"]
default["libvirt"]["cert"]["country"] = node["openssl"]["country"]
default["libvirt"]["cert"]["email"] = node["openssl"]["email"]
default["libvirt"]["cert"]["expiration"] = node["openssl"]["expiration"]
default["libvirt"]["cert"]["self_signing"] = node["openssl"]["self_signing"]

default["libvirt"]["cert"]["dns_names"] = [
  node["fqdn"]
]
