libvirt Cookbook
================

Network
-------

```ruby
default["libvirt"]["networks"] = {
  "example" => {
    "action" => %w(define start autoboot),
    "mac" => "52:54:00:AB:B1:77",
    "bridge" => "virbr1",
    "ip" => "192.168.124.1",
    "netmask" => "255.255.255.0",
    "dhcp_enable" => true,
    "dhcp_hosts" => [
      {
        "mac" => "52:54:00:77:77:70",
        "name" => "host1.example.com",
        "ip" => "192.168.124.10"
      }
    ]
  }
}
```

Node
----

```ruby
default["libvirt"]["nodes"] = {
  "host1" => {
    "action" => %w(define),
    "memory" => 2048,
    "cpus" => 8,
    "vnc" => 5900,
    "disks" => [
      {
        "type" => "file",
        "download" => "http://example.com/host1.qcow2",
        "source" => "/var/lib/libvirt/images/host1.qcow2",
        "target" => "vda"
      }
    ],
    "interfaces" => [
      {
        "type" => "network",
        "source" => "example",
        "mac" => "52:54:00:77:77:70"
      }
    ]
  },
}
```

Pool
----

```ruby
default["libvirt"]["pools"] => {
  # LVM
  "cloud" => {
    "action" => %w(define start autoboot),
    "type" => "logical",
    "target" => "/dev/sda2",
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
```
