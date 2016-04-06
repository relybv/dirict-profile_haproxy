# == Class profile_haproxy::service
#
# This class is meant to be called from profile_haproxy.
# It ensure the service is running.
#
class profile_haproxy::service {

  service { $::profile_haproxy::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
