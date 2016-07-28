# == Class profile_haproxy::install
#
# This class is called from profile_haproxy for install.
#
class profile_haproxy::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::monitor_address != undef {
    class { 'haproxy':
      global_options => {
        'log' => "${::monitor_address} local0",
      },
      merge_options  => true,
    }
  }
  else {
    class { 'haproxy': }
  }
}
