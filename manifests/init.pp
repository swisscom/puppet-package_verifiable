# install a package in a certain version
# and provide a fact to verify its version
define package_verifiable(
  $version           = 'installed',
  $epoch             = '',
  $manage_package    = true,
  $manage_dependency = true,
){
  require package_verifiable::base

  package_verifiable::yum::versionlock {$title:
    ensure => $version,
    epoch  => $epoch
  }

  if $manage_package {
    package{$title:
      ensure => $version,
    }
  }

  package_verifiable::fact {$title: 
    package => $title,
    version => $version,
  }

  if $manage_dependency {
    # Versionlock before install/upgrade Package, before updating fact
    Package_verifiable::Yum::Versionlock[$title] -> Package<| title == $title |> -> File_line["${title}_version_fact"]
  }
}
