# == Class profile_haproxy::install
#
# This class is called from profile_haproxy for install.
#
class profile_haproxy::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # add haproxy ppa repo
  include apt
  apt::ppa { 'ppa:vbernat/haproxy-1.6': }

  if $::monitor_address != undef {
    $logserver =  "${::monitor_address} local0"
  }
  else {
    $logserver = '127.0.0.1 local0'
  }

  class { 'haproxy':
    package_ensure   => 'latest',
    global_options   => {
      'log'                        => $logserver,
      'tune.ssl.default-dh-param'  => '2048',
      'ssl-default-bind-options'   => 'no-sslv3',
      'ssl-default-bind-ciphers'   => 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS',
      'ssl-default-server-option'  => 'no-sslv3',
      'ssl-default-server-ciphers' => 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS',
    },
    defaults_options => {
      'log'     => 'global',
      'retries' => '3',
      'option'  => [
        'redispatch',
        'http-server-close',
      ],
      'timeout' => [
        'http-request 10s',
        'connect 3s',
        'client 1m',
        'server 1m',
        'check 10s',
      ],
      'maxconn' => '8000',
    },
    merge_options    => true,
  }

}
