# Install the yum versionlock plugin
class package::yum::versionlock_plugin {
  package { 'yum-plugin-versionlock':
    ensure => present
  }
}
