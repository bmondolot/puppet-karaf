# PRIVATE CLASS - do not use directly
#
# Definition: karaf::instance::configuration::custom_properties.
define karaf::instance::configuration::custom_properties(
  $rootdir                 = undef,
  $service_user_name       = undef,
  $service_group_name      = undef,
  $karaf_custom_properties = undef,
) {
  file { "${rootdir}/${name}/etc/custom.properties":
    ensure  => file,
    content => template('karaf/karaf/etc/custom.properties.erb'),
    owner   => $service_user_name,
    group   => $service_group_name
  }
}