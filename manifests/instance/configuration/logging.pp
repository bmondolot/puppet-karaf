# PRIVATE CLASS - do not use directly
#
# Definition: karaf::instance::configuration::logging
define karaf::instance::configuration::logging(
  $rootdir              = undef,
  $service_user_name    = undef,
  $service_group_name   = undef,
  $file_karaf_logging   = undef,
) {
  file { "${rootdir}/${name}/etc/org.ops4j.pax.logging.cfg":
    ensure => present,
    source => [
      $file_karaf_logging
    ],
    owner  => $service_user_name,
    group  => $service_group_name
  }
}