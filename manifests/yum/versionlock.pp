# Lock a RPM to a specfic version using the yum versionlock plugin
define package::yum::versionlock($ensure, $epoch = '') {
  require package::yum::versionlock_plugin

  if $ensure =~ /^absent|installed|latest|present$/ {
    $changes = [ "rm ${name}" ]
  } else {
    if $epoch == '' {
      $changes = [ "set ${name}/version ${ensure}" ]
    } else {
      # reverse order of commands fails, why?
      $changes = [ "set ${name}/epoch ${epoch}", "set ${name}/version ${ensure}" ]
    }
  }

  augeas {
    "${name}_yum_versionlock":
      incl      => '/etc/yum/pluginconf.d/versionlock.list',
      lens      => 'YumVersionlock.lns',
      load_path => '/var/lib/puppet/lib/package/lenses',
      context   => '/files/etc/yum/pluginconf.d/versionlock.list',
      changes   => $changes
  }
}
