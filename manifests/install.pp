# == Class profile_haproxy::install
#
# This class is called from profile_haproxy for install.
#
class profile_haproxy::install {

  package { $::profile_haproxy::package_name:
    ensure => present,
  }
}
