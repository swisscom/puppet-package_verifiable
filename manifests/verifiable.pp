# install a package in a certain version
# and provide a fact to verify its version
define package::verifiable(
  $manage_package = true,
  $version        = 'installed',
  $epoch          = '',
){
  require package::base

  package::yum::versionlock{$name:
    ensure => $version,
    epoch  => $epoch
  }

  if $manage_package {
    package{$name:
      ensure => $version,
    }
  }

  $escaped_name = downcase(regsubst($name,'-','_', 'G'))
  file_line{
    "${name}_version_fact":
      line  => "package_${escaped_name}_version=${version}",
      match => "^package_${escaped_name}_version=",
      path  => $package::base::file_path,
  }

  # Versionlock before install/upgrade Package, before updating fact
  Package::Yum::Versionlock[$name] -> Package<| title == $name |> -> File_line["${name}_version_fact"]
}
