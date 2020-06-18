# == Class: package_verifiable
#
# Install a package in a certain version and provide a fact to verify its
# version.
#
# === Parameters
#
# [*version*]
#   (String) Set the package version
#   Defaults to `installed`.
#
# [*epoch*]
#   (String) Set the package epoch
#   Defaults to ` `.
#
# [*manage_package*]
#   (Boolean) Wether to ensure the package version with Puppet
#   Defaults to `true`.
#
# [*manage_dependency*]
#   (Boolean) Wether to manage the package dependencies too
#   Defaults to `true`.
#

define package_verifiable(
  String $version            = 'installed',
  String $epoch              = '',
  Boolean $manage_package    = true,
  Boolean $manage_dependency = true,
){
  require package_verifiable::base

  package_verifiable::yum::versionlock {$title:
    ensure => $version,
    epoch  => $epoch,
  }

  if $manage_package {
    package{$title:
      ensure => $version,
      tag    => "${module_name}_package",
    }
  }

  package_verifiable::fact {$title:
    package => $title,
    version => $version,
  }

  if $manage_dependency {
    # Versionlock before install/upgrade Package, before updating fact
    Package_verifiable::Yum::Versionlock<| tag == $module_name |> -> Package<| tag == "${module_name}_package" |> -> Package_verifiable::Fact<| tag == $module_name |>
  }
}
