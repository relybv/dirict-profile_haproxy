# == Class profile_haproxy::install
#
# This class is called from profile_haproxy for install.
#
class profile_haproxy::install {
  if $::monitor_address != undef {
    class { 'haproxy':
      global_options   => { 'log'     => "${::monitor_address} local0" },
    }
  }
  else {
    class { 'haproxy': }
  }
}
