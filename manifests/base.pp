#basic setup for package_verifiable
class package_verifiable::base {
  if versioncmp($::puppetversion, '4.0.0') >= 0 {
    $facts_dir = '/opt/puppetlabs/facter/facts.d'
  } else {
    $facts_dir = '/etc/facter/facts.d'
  }

  # Workaround needed if the Puppet does not manage the Puppet Agent itself
  exec { 'ensure-facts-dir-is-present':
    command => "mkdir -p ${facts_dir}",
    unless  => "test -d ${facts_dir}",
    path    => '/usr/bin:/bin',
  }

  file { "${facts_dir}/packages.txt":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Exec['ensure-facts-dir-is-present'],
  }
}
