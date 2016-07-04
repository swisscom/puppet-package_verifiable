# install a package in a certain version
# and provide a fact to verify its version
define package_verifiable( #::package(
  $manage_package = true,
  $version        = 'installed',
  $epoch          = '',
){
  require package_verifiable::base

  package_verifiable::yum::versionlock{$name:
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
      path  => $package_verifiable::base::file_path,
  }

  # Versionlock before install/upgrade Package, before updating fact
  Package_verifiable::Yum::Versionlock[$name] -> Package<| title == $name |> -> File_line["${name}_version_fact"]
}