# == Class: profile_haproxy
#
# Full description of class profile_haproxy here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_haproxy
(
  $member_ips = $::profile_haproxy::params::member_ips,
  $member_names = $::profile_haproxy::params::member_names,
  $monitor_address = $::profile_haproxy::params::monitor_address,
) inherits ::profile_haproxy::params {

  # validate parameters here

  class { '::profile_haproxy::install': }
  -> class { '::profile_haproxy::config': }
  ~> class { '::profile_haproxy::service': }
  -> Class['::profile_haproxy']

}
