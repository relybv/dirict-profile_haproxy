# == Class profile_haproxy::config
#
# This class is called from profile_haproxy for service config.
#
class profile_haproxy::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  haproxy::listen { 'stats':
    ipaddress => '127.0.0.1',
    ports     => '9090',
    options   => {
      'mode'  => 'http',
      'stats' => ['uri /','auth admin:admin'],
    },
  }

  # new http frontend
  haproxy::frontend { 'haproxy00':
    collect_exported => false,
    ipaddress        => '*',
    ports            => '80',
    mode             => 'http',
    options          => {
      'default_backend' => 'appl80',
      'log'             => 'global',
      'option'          => 'forwardfor',
    },
  }

  # new http backend
  haproxy::backend { 'appl80':
    mode             => 'http',
    options => {
      'option'  => [
        'httplog',
        'forwardfor',
      ],
      'balance' => 'roundrobin',
    },
  }

  # old ok balancemember
  haproxy::balancermember { 'members80':
    listening_service => 'haproxy80',
    server_names      => $profile_haproxy::member_names,
    ipaddresses       => $profile_haproxy::member_ips,
    ports             => '80',
    options           => 'check',
  }

  # new https frontend
  haproxy::frontend { 'haproxy443':
    collect_exported => false,
    mode             => 'http',
    bind             => {
      '*:443' => ['ssl', 'crt', '/etc/ssl/private/example.com.pem'],
    },
    options          => {
      'option'                      => [
        'http-keep-alive',
        'forwardfor',
      ],
      'reqadd X-Forwarded-Proto:\\' => 'https',
      'reqadd X-Forwarded-Port:\\'  => '443',
      'default_backend'             => 'appl443',
      'log'                         => 'global',
      'stats'                       => 'enable',
    },
  }

  # new https backend
  haproxy::backend { 'appl443':
    collect_exported => false,
    mode             => 'http',
    options          => {
      'balance'                                   => 'source',
      'http-request set-header X-Forwarded-Port'  => '%[dst_port]',
      'http-request add-header X-Forwarded-Proto' => 'https',
    },
  }

  # old ok balancemember
  haproxy::balancermember { 'members443':
    listening_service => 'haproxy443',
    server_names      => $profile_haproxy::member_names,
    ipaddresses       => $profile_haproxy::member_ips,
    ports             => '443',
    options           => 'send-proxy',
  }

}
