# == Class profile_haproxy::params
#
# This class is meant to be called from profile_haproxy.
# It sets variables according to platform.
#
class profile_haproxy::params {
  $member_ips = $::member_ips
  $member_names = $::member_names
  case $::osfamily {
    'Debian': {
      $package_name = 'profile_haproxy'
      $service_name = 'profile_haproxy'
    }
    'RedHat', 'Amazon': {
      $package_name = 'profile_haproxy'
      $service_name = 'profile_haproxy'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
