# Install the yum versionlock plugin
class package_verifiable::yum::versionlock_plugin {
  $versionlock_pkg = $::operatingsystemmajrelease ? {
    /6|7/   => 'yum-plugin-versionlock',
    default => 'python3-dnf-plugin-versionlock'
  }

  package { $versionlock_pkg:
    ensure => present
  }
}
