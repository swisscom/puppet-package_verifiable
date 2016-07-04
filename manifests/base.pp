#basic setup for package_verifiable
class package_verifiable::base {
  $file_path = '/etc/facter/facts.d/packages.txt'
  file{$file_path:
    ensure    => 'present',
    owner     => root,
    group     => 0,
    mode      => '0644';
  }
}
