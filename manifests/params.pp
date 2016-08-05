# == Class profile_haproxy::params
#
# This class is meant to be called from profile_haproxy.
# It sets variables according to platform.
#
class profile_haproxy::params {

  if $::member_ips != undef {
    $member_ips = split( $::member_ips, ';')
  }
  else {
    $member_ips = 'localhost'
  }

  if $::member_names != undef {
    $member_names = split( $::member_names, ';')
  }
  else {
    $member_names = 'localhost'
  }

  $monitor_address = $::monitor_address

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
