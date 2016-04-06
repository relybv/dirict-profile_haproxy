# == Class profile_haproxy::config
#
# This class is called from profile_haproxy for service config.
#
class profile_haproxy::config {

  haproxy::listen { 'stats':
    ipaddress => '127.0.0.1',
    ports     => '9090',
    options   => {
      'mode'  => 'http',
      'stats' => ['uri /','auth admin:admin'],
    },
  }

  haproxy::listen { 'haproxy80':
    collect_exported => false,
    ipaddress        => '*',
    ports            => '80',
    mode             => 'http',
    options          => {
      'option'  => ['httplog'],
      'balance' => 'roundrobin',
    },
  }

  haproxy::listen { 'haproxy443':
    collect_exported => false,
    ipaddress        => '*',
    ports            => '443',
    mode             => 'tcp',
    options          => {
      'balance' => 'source',
    },
  }

  haproxy::balancermember { 'members80':
    listening_service => 'haproxy80',
    server_names      => $profile_haproxy::member_names,
    ipaddresses       => $profile_haproxy::member_ips,
    ports             => '80',
    options           => 'check',
  }

  haproxy::balancermember { 'members443':
    listening_service => 'haproxy443',
    server_names      => $profile_haproxy::member_names,
    ipaddresses       => $profile_haproxy::member_ips,
    ports             => '443',
    options           => 'check',
  }

}
