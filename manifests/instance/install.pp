# Definition: karaf::instance::install
define karaf::instance::install(
  $ensure             = undef,
  $install_from       = undef,
  $rootdir            = undef,
  $service_name       = undef,
  $service_group_name = undef,
  $service_group_id   = undef,
  $service_user_name  = undef,
  $service_user_id    = undef,

  $karaf_zip_url      = undef,
  $karaf_file_name    = undef,
) {

  if ($ensure == 'present') {
    # ---------------------------------------------
    # Create group and user for karaf service.
    # ---------------------------------------------
    ensure_resource('group', $service_group_name, {
      ensure => present,
      gid    => $service_group_id,
    })

    ensure_resource('user', $service_user_name, {
      ensure           => present,
      uid              => $service_user_id,
      gid              => $service_group_id,
      managehome       => true,
      shell            => '/bin/bash',
      require          => Group[$service_group_name]
    })

    # ---------------------------------------------
    # Deploy karaf zip package.
    # ---------------------------------------------
    if ($install_from == 'file') {
      ensure_resource('file',  "/tmp/${karaf_file_name}.zip", {
        ensure => present,
        source => "puppet:///modules/${caller_module_name}/karaf/dist/${karaf_file_name}.zip",
        owner   => $service_user_name,
        group   => $service_group_name
      })

      $unzip_require = File[ "${rootdir}/${karaf_file_name}.zip" ]
    } else {
      ensure_resource('exec', 'donwload_karaf', {
        command => "/usr/bin/wget -O /tmp/${karaf_file_name}.zip -q \"${karaf_zip_url}\"",
        creates  => "/tmp/${karaf_file_name}.zip",
        timeout => 1000
      })

      $unzip_require = Exec['donwload_karaf']
    }

    ensure_resource('exec', "${service_name}-unzip_karaf_package", {
      cwd       => "/home/${service_user_name}",
      command   => "/usr/bin/unzip /tmp/${karaf_file_name}.zip -d ${rootdir}",
      require   => [ $unzip_require ],
      'unless'  => "/usr/bin/test -d ${rootdir}/${karaf_file_name}"
    })

  }

  ensure_resource('file', "${rootdir}/${karaf_file_name}-${service_name}" , {
    ensure              => $ensure,
    owner               => $service_user_name,
    group               => $service_group_name,
    source              => "${rootdir}/${karaf_file_name}",
    source_permissions  => 'use',
    recurse => true
  })

  if ($ensure == 'absent') {
    $link_ensure = 'absent'
  } else {
    $link_ensure = 'link'
  }

  ensure_resource('file', "${rootdir}/${service_name}", {
    ensure  => $link_ensure,
    target  => "${rootdir}/${karaf_file_name}-${service_name}/",
    owner   => $service_user_name,
    group   => $service_group_name,
  })
}