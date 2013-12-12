#basic setup for package::verifiable
class package::base {
  $file_path = '/etc/facter/facts.d/packages.txt'
  file{$file_path:
    ensure    => 'present',
    owner     => root,
    group     => 0,
    require   => undef,
    notify    => undef,
    before    => undef,
    subscribe => undef,
    mode      => '0644';
  }
}