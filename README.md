libvirt Cookbook
================

To assign other storages to libvirt you can use the following examples 
for Directories, LVM and NFS:

    "pools" => {
      # LVM
      "cloud" => {
        "action" => %w(define start autoboot),
        "type" => "logical",
        "target" => "/dev/system",
        "device" => "/dev/sda2",
        "volume" => "system"
      }

      # NFS
      "cloud" => {
        "action" => %w(define start autoboot),
        "type" => "netfs",
        "target" => "/data/images",
        "host" => "nfs.server.de",
        "dir" => "/export/dir"
      }

      # Directory
      "cloud" => {
        "action" => %w(define start autoboot),
        "type" => "dir",
        "target" => "/data/images"
      }
    }
