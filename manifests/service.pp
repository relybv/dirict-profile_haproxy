# == Class profile_haproxy::service
#
# This class is meant to be called from profile_haproxy.
# It ensure the service is running.
#
class profile_haproxy::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
