#basic setup for package_verifiable
class package_verifiable::base {
  if versioncmp($::puppetversion, '4.0.0') >= 0 {
    $file_path = '/opt/puppetlabs/facter/facts.d/packages.txt'
  } else {
    $file_path = '/etc/facter/facts.d/packages.txt'
  }

  file{$file_path:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644';
  }
}
