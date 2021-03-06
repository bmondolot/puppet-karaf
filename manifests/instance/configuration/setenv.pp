# PRIVATE CLASS - do not use directly
#
# Definition: karaf::instance::configuration::setenv
define karaf::instance::configuration::setenv(
  $rootdir              = undef,
  $service_user_name    = undef,
  $service_group_name   = undef,
  $java_home            = undef,
  $default_env_vars     = undef,
) {
  file { "${rootdir}/${name}/bin/setenv":
    ensure  => file,
    content => template('karaf/karaf/bin/setenv.erb'),
    owner   => $service_user_name,
    group   => $service_group_name
  }
}