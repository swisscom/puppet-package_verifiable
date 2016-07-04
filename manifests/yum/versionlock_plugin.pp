# Install the yum versionlock plugin
class package_verifiable::yum::versionlock_plugin {
  package { 'yum-plugin-versionlock':
    ensure => present
  }
}
