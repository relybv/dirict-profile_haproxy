# == Class profile_haproxy::install
#
# This class is called from profile_haproxy for install.
#
class profile_haproxy::install {
  class { 'haproxy': }
}
